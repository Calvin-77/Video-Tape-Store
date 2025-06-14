import 'package:flutter/material.dart';
import 'package:video_tape_store/admin_page/home_page.dart';
import 'package:video_tape_store/user_page/main_page.dart';
import 'package:video_tape_store/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    final url = Uri.parse('http://10.0.2.2:3000/users/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        User user = User.fromJson(data);

        String username = data["Username"];
        final storage = await SharedPreferences.getInstance();
        await storage.setString("Username", username);

        if (user.Role == 'admin') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else if (user.Role == 'user') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        }
      } else {
        print('Login gagal: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/image_login.png',
              ),
              TextField(
                enabled: true,
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                enabled: true,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
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
