import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        primary: Color(0xFFD3D3C7),
        secondary: Color(0xFF000000),
        surface: Color(0xFFFFFFFF)),
    splashColor: Colors.transparent,
    highlightColor: const Color(0xFFFFFFFF),
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
        primary: Color(0xFF2B2B38),
        secondary: Color(0xFFFFFFFF),
        surface: Color(0xFF161621)),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory);
