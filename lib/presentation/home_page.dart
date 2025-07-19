// File: home_page.dart

import 'package:flutter/material.dart';
import 'package:home_garden/presentation/ProfilePage.dart';
import 'package:home_garden/presentation/widgets/custombutton.dart';
import 'booking_page.dart';


import 'package:flutter/material.dart';

class Servicepage extends StatefulWidget {
  const Servicepage({Key? key}) : super(key: key);

  @override
  State<Servicepage> createState() => _HomePageState();
}

class _HomePageState extends State<Servicepage> {
  final List<Map<String, dynamic>> services = const [
    {
      'title': 'Lawn Mowing',
      'icon': "assets/icon/Lawn mowing icon.jpg",
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'Hedge Trimming',
      'icon': "assets/icon/hedge trimming icon.jpg",
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'Garden Clearness',
      'icon': "assets/icon/Garden Clearenses.jpg",
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'Jet Washing',
      'icon': "assets/icon/jet washing icon.jpg",
      'color': Color(0xFF4CAF50),
    },
  ];

  int? _selectedServiceIndex; // Track selected service

  void _onChooseServiceTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose a Service',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.green[900],
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                itemCount: services.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedServiceIndex = index;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookingPage(serviceTitle: service['title']),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: service['color'],
                                child: Image.asset(
                                  service['icon'],
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  service['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a Service',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 5,
                ),
                itemBuilder: (context, index) {
                  final service = services[index];
                  final isSelected = _selectedServiceIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedServiceIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.green[700]! : const Color.fromARGB(49, 0, 0, 0),
                          width: isSelected ? 2 : 0.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            service['icon'],
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Text(
                              service['title'],
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              text: 'Next',
              backgroundColor:Color(0xFF205b3b) ,
              onPressed: () {
                if (_selectedServiceIndex != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingPage(
                        serviceTitle: services[_selectedServiceIndex!]['title'],
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a service')),
                  );
                }
              },
              borderRadius: 10,
              padding: 10,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
