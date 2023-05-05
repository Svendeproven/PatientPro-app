import 'package:exam_app/theme/theme.dart';
import 'package:flutter/material.dart';

/// The dark theme for the application
ThemeData darktheme = themeData.copyWith(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0xff0f1932),
    primary: Color(0xff736d75),
    secondary: Color(0xff345cab),
  ),
  cardColor: const Color(0xff142242),
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 38,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 12,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 10,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      fontSize: 10,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
);
