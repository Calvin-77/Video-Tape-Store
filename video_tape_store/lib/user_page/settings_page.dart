import 'package:flutter/material.dart';
import 'package:video_tape_store/screens/login_register_page.dart';
import 'package:video_tape_store/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_tape_store/user_page/film_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String Username = "";

  @override
  void initState() {
    super.initState();
    load_user();
  }

  Future<void> load_user() async {
    final storage = await SharedPreferences.getInstance();
    String? username = storage.getString("Username");

    setState(() {
      Username = username ?? "Guest";
    });
  }

  Future<void> logout() async {
    FilmPage.cart.clear();
    final storage = await SharedPreferences.getInstance();
    await storage.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginRegisterPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/images/default_avatar.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                Username,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Center(
                    child: Text(
                      Theme.of(context).brightness == Brightness.dark
                          ? "Light Mode"
                          : "Dark Mode",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
