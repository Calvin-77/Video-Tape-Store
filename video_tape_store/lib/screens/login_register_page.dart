import 'package:flutter/material.dart';
import 'package:video_tape_store/auth/google_auth.dart';
import 'package:video_tape_store/style/style.dart';
import 'package:video_tape_store/screens/login_page.dart';
import 'package:video_tape_store/screens/register_page.dart';

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 185, width: 200),
            Image.asset(
              'assets/images/Logo.png',
              width: 385,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => {GoogleOAuth.signInGoogle(context)},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Image.asset(
                'assets/images/Google.png',
                width: 300,
                height: 30,
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
              thickness: 1,
              endIndent: 30,
              indent: 30,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have account?',
                    style: AppTextStyle.small2(context)),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text('Login', style: AppTextStyle.small),
                ),
                Text(
                  ' | ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: Text('Register', style: AppTextStyle.small),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
