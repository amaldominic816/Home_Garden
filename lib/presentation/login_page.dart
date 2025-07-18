import 'package:flutter/material.dart';
import 'home_page.dart';      // <‑‑ new import

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _goToHome() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 500)); // fake wait
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo-c.png', width: 160, height: 160),
                const SizedBox(height: 32),
                Text('Welcome Back',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                    )),
                const SizedBox(height: 8),
                Text('Sign in to continue',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    )),
                const SizedBox(height: 32),

                // Email + Password (optional in dummy mode)
                TextField(
                  controller: _emailController,
                  decoration: _inputDecoration('Email', Icons.email_outlined),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: _inputDecoration('Password', Icons.lock_outline),
                ),
                const SizedBox(height: 24),

                // LOGIN
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _goToHome,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Login',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 24),

                // Divider
                Row(children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Or continue with',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14)),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ]),
                const SizedBox(height: 24),

                // Social buttons (also dummy)
                Row(children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Image.asset('assets/images/google.png', width: 20),
                      label: const Text('Google'),
                      style: _socialStyle(),
                      onPressed: _isLoading ? null : _goToHome,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.apple, size: 20),
                      label: const Text('Apple'),
                      style: _socialStyle(),
                      onPressed: _isLoading ? null : _goToHome,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helpers
  InputDecoration _inputDecoration(String hint, IconData icon) =>
      InputDecoration(
        filled: true,
        fillColor: Colors.grey[50],
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey[500], size: 20),
        border: _border(Colors.grey[300]!),
        enabledBorder: _border(Colors.grey[300]!),
        focusedBorder: _border(const Color(0xFF1b6b37), width: 2),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      );

  OutlineInputBorder _border(Color c, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c, width: width),
      );

  ButtonStyle _socialStyle() => OutlinedButton.styleFrom(
        foregroundColor: Colors.grey[800],
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      );
}
