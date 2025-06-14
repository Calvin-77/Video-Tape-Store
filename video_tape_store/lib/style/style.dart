import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle title(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  static TextStyle title2(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: 32.0,
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  static TextStyle small = const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: Colors.red,
  );

  static TextStyle small2(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
