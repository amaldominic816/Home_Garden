// BookingListPage.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'BookingDetailPage.dart';

class Booking {
  final String serviceTitle;
  final DateTime date;
  final String timeSlot;
  final String name;
  final String address;
  final String mobile;
  final String email;
  final String status; // 'Accepted' or 'Pending'

  Booking({
    required this.serviceTitle,
    required this.date,
    required this.timeSlot,
    required this.name,
    required this.address,
    required this.mobile,
    required this.email,
    required this.status,
  });
}

class BookingListPage extends StatelessWidget {
  BookingListPage({Key? key}) : super(key: key);

  final List<Booking> bookings = [
    Booking(
      serviceTitle: "Garden Cleanup",
      date: DateTime.now().add(const Duration(days: 1)),
      timeSlot: "Morning",
      name: "John Doe",
      address: "123 Main St",
      mobile: "+1234567890",
      email: "john@example.com",
      status: "Pending",
    ),
    Booking(
      serviceTitle: "Lawn Mowing",
      date: DateTime.now().subtract(const Duration(days: 2)),
      timeSlot: "Afternoon",
      name: "Alice Smith",
      address: "456 Oak Ave",
      mobile: "+1987654321",
      email: "alice@example.com",
      status: "Accepted",
    ),
    // Add more sample bookings as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF215C3C),
                Color(0xFF3DAA77),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'My Bookings',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings found.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final b = bookings[index];
                final formattedDate = DateFormat.yMMMMd().format(b.date);
                final statusColor =
                    b.status == 'Accepted' ? Colors.green : Colors.orange;

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingDetailPage(booking: b),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: statusColor, width: 1.5)),
                  tileColor: Colors.grey.shade50,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  title: Text(
                    b.serviceTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  subtitle: Text('$formattedDate • ${b.timeSlot}'),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      b.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}