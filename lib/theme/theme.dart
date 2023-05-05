// export standard Themedata

import 'package:flutter/material.dart';

// Create a swatch from #0f1932
const MaterialColor _primarySwatch = MaterialColor(
  0xff0f1932,
  <int, Color>{
    50: Color(0xffe6e6e6),
    100: Color(0xffcccccc),
    200: Color(0xffb3b3b3),
    300: Color(0xff999999),
    400: Color(0xff808080),
    500: Color(0xff666666),
    600: Color(0xff4d4d4d),
    700: Color(0xff333333),
    800: Color(0xff1a1a1a),
    900: Color(0xff000000),
  },
);

/// The light theme for the application
ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xffffffff),
    primary: Color(0xff0f1932),
    secondary: Color(0xff345cab),
  ),
  // cardColor: const Color(0xff142242),
  iconTheme: const IconThemeData(color: Color(0xff0f1932)),
  primarySwatch: _primarySwatch,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 38,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 10,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
      fontSize: 10,
    ),
    labelLarge: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
  ),
);
