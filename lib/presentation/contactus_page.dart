import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  final String email = 'contact@gardeningservices.com';
  final String phone = '+1 234 567 8900';
  final String address = '123 Garden Lane,\nGreen City, GC 12345';

  final Color _greenStart = const Color(0xFF215C3C);
  final Color _greenEnd = const Color(0xFF3DAA77);

  @override
  Widget build(BuildContext context) {
    final TextStyle infoLabelStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.green.shade900,
      fontSize: 16,
    );
    final TextStyle infoTextStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black87,
      height: 1.3,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_greenStart, _greenEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Contact Us',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email', style: infoLabelStyle),
              const SizedBox(height: 8),
              Text(email, style: infoTextStyle),
              const SizedBox(height: 24),

              Text('Phone', style: infoLabelStyle),
              const SizedBox(height: 8),
              Text(phone, style: infoTextStyle),
              const SizedBox(height: 24),

              Text('Address', style: infoLabelStyle),
              const SizedBox(height: 8),
              Text(address, style: infoTextStyle),

              const Spacer(),
             SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      // Implement contact action or navigation here, e.g., open email app or call phone.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contact method tapped')),
      );
    },
    icon: const Icon(Icons.email_outlined, color: Colors.white),
    label: const Text(
      'Send Email',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4CAF50),
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}