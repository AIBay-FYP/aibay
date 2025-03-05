import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Sora',
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF), // Light Mode Background (White)
    primaryColor: const Color(0xFF364C59), // Button or other highlight-related color
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF0C0C0C)), // Min Background (Used for Text in Light Mode)
      bodyMedium: TextStyle(color: Color(0xFF696363)), // Light Text Color
    ),
    colorScheme: const ColorScheme.light(
      surface: Color(0xFFFFFFFF), // Background Color
      primary: Color(0xFF364C59), // Button Color (Same as primaryColor)
      secondary: Color(0xFFD9D9D9), // Light Mode Highlighter (New)
      onSecondary: Color(0xFFE8E8E8), // Light Mode TextField Color (New)
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Sora',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0C0C0C), // Min Background (Dark Mode)
    primaryColor: const Color(0xFF364C59), // Button or other highlight-related color
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // Text Color (White)
      bodyMedium: TextStyle(color: Color(0xFF696363)), // Light Text Color
    ),
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF1F1F1F), // Background Color
      primary: Color(0xFF364C59), // Button Color (Same as primaryColor)
      secondary: Color(0xFF3B3B3B), // Highlighter
      onSecondary: Color(0xFF262626), // Dark Mode TextField Color (New)
    ),
  );
}
