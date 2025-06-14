import 'package:flutter/material.dart';
import 'package:video_tape_store/screens/login_register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginRegisterPage()),
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/Logo.png',
            height: 330,
          ),
        ),
      ),
    );
  }
}
