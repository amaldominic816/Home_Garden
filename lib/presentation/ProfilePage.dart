// lib/presentation/ProfilePage.dart
import 'package:flutter/material.dart';
import 'package:home_garden/presentation/contactus_page.dart';
import 'package:home_garden/presentation/login_page.dart';
import 'BookingListPage.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userEmail;

  const ProfilePage({
    Key? key,
    this.userName = 'John Doe',
    this.userEmail = 'johndoe@example.com',
  }) : super(key: key);

  void _onContactUs(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ContactUsPage()));
  }

  void _onViewBooking(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookingListPage()),
    );
  }

  void _onLogout(BuildContext context) {
    // Replace this with your actual logout logic
    // Navigator.of(context).popUntil((route) => route.isFirst);
    // Optionally navigate to login page if implemented:
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final greenColor = const Color(0xFF4CAF50);

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
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 125,
                      child: Image.asset(
                        'assets/images/logo-c.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      userName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DMSans',
                        color: Colors.green.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _onContactUs(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: greenColor, width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              foregroundColor: greenColor,
                            ),
                            child: const Text(
                              'Contact Us',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _onViewBooking(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: greenColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                            ),
                            child: const Text(
                              'View Bookings',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextButton(
                onPressed: () => _onLogout(context),
                style: TextButton.styleFrom(
                  foregroundColor: greenColor,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DMSans',
                  ),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}