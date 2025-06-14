import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_tape_store/user_page/main_page.dart';

class GoogleOAuth {
  static final _oauth = GoogleSignIn(scopes: ['email']);

  static Future<void> signInGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? account = await _oauth.signIn();

      if (account != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } catch (error) {
      print("Error signing in: $error");
    }
  }
}
