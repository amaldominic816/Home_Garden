// File: home_page.dart

import 'package:flutter/material.dart';
import 'package:home_garden/presentation/ProfilePage.dart';
import 'booking_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> services = const [
    {
      'title': 'Lawn Mowing',
      'icon': Icons.grass,
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'Hedge Trimming',
      'icon': Icons.content_cut,
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'Garden Clearness',
      'icon': Icons.cleaning_services,
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'Jet Washing',
      'icon': Icons.water_damage,
      'color': Color(0xFF4CAF50),
    },
  ];

  void _onChooseServiceTap() {
    // Show modal bottom sheet with list of services for booking
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
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: service['color'],
                      child: Icon(service['icon'], color: Colors.white),
                    ),
                    title: Text(
                      service['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BookingPage(serviceTitle: service['title']),
                        ),
                      );
                    },
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color(0xFF215C3C), // replaces Colors.green.shade700
                Color(0xFF3DAA77),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade200.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 16, top: 20, bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                    height: 70,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.green.shade700,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProfilePage()),
    );
                      },
                      tooltip: 'Profile',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Promotion text
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Gardening Services you'll love today",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _onChooseServiceTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // "Choose a Service" label with button
            GestureDetector(
              onTap: _onChooseServiceTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  children: [
                    Text(
                      'Choose a Service',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.green.shade900,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.green.shade900,
                      size: 28,
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Services cards grid (1 item per row)
            Expanded(
              child: GridView.builder(
                itemCount: services.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // one item per row
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 4,
                ),
                itemBuilder: (context, index) {
                  final service = services[index];
                  return GestureDetector(
                    onTap: () {
                      // Open booking page with chosen service
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BookingPage(serviceTitle: service['title']),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: service['color'],
                            child: Icon(
                              service['icon'],
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Text(
                              service['title'],
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.green[900],
                                fontWeight: FontWeight.w700,
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
          ],
        ),
      ),
    );
  }
}