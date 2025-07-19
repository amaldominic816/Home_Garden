import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:home_garden/presentation/home_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[50]!,
              Colors.grey[100]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Image.asset(
                'assets/images/logo-c.png',
                fit: BoxFit.contain,
                height: 300,
                // width: 400,
              ),
              const SizedBox(height: 0),
              const Text(
                'Gardening Services\nYou\'ll Love - Book Today!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  letterSpacing: 1.2,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 40),
              _buildCustomButton(
                context,
                icon:Icons.bookmark_add,
                text: 'Book a Service',
                onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Servicepage (),
                            ),
                          );
                },
              ),
              const SizedBox(height: 20),
              _buildCustomButton(
                context,
                icon: Icons.search,
                text: 'Contact Us',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _buildCustomButton(
                context,
                icon: Icons.bookmark_add,
                text: 'My Bookings',
                onTap: () {},
              ),
              const Spacer(),
      
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildCustomButton(
  //   BuildContext context, {
  //   required IconData icon,
  //   required String text,
  //   required VoidCallback onTap,
  // }) {
  //   return InkWell(
  //     onTap: onTap,
  //     borderRadius: BorderRadius.circular(12),
  //     child: Container(
  //       width: 300,
  //       height: 80,
  //       decoration: BoxDecoration(
  //         // gradient: LinearGradient(
  //         //   colors: [Colors.green[700]!, Colors.green[500]!],
  //         //   begin: Alignment.topLeft,
  //         //   end: Alignment.bottomRight,

  //         // ),
  //         color: Color(0xFF205b3b),
  //         borderRadius: BorderRadius.circular(12),
  //         // boxShadow: [
  //         //   BoxShadow(
  //         //     color: Colors.green.withOpacity(0.3),
  //         //     spreadRadius: 2,
  //         //     blurRadius: 8,
  //         //     offset: const Offset(0, 4),
  //         //   ),
  //         // ],
  //       ),
  //       child: Row(
        
  //         children: [

  //           Center(
  //             child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //               children: [  Icon(
  //               icon,
  //               color: Colors.white,
  //               size: 24,
  //             ),
  //             const SizedBox(width: 12),
  //             Text(
  //               text,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),],),
  //           )
          
  //         ],
  //       ),
  //     ),
  //   );
  // }

Widget _buildCustomButton(
  BuildContext context, {
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF205b3b),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Container(
          width: 170,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}