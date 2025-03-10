import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Sora',
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF), // Light Mode Background (White)
    colorScheme: const ColorScheme.light(
      surface: Color(0xFFFFFFFF), // Background Color
      primary: Color(0xFF364C59), // Button & Primary Color
      secondary: Color(0xFFD9D9D9), // Light Mode Highlighter
      onSecondary: Color(0xFFE8E8E8), // Light Mode TextField Color
      onSurface: Color(0xFF0C0C0C), // Default Text Color
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF0C0C0C)), // Primary text
      bodyMedium: TextStyle(color: Color(0xFF696363)), // Light Text Color
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF364C59), // Use primary color
        foregroundColor: Colors.white, // Text color
      ),
    ),
    applyElevationOverlayColor: false,
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Sora',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0C0C0C), // Dark Background
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF0C0C0C), // Background Color
      primary: Color(0xFF364C59), // Button & Primary Color
      secondary: Color(0xFF3B3B3B), // Highlighter
      onSecondary: Color(0xFF262626), // Dark Mode TextField Color
      onSurface: Color(0xFFFFFFFF), // Default Text Color (White)
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // Primary text
      bodyMedium: TextStyle(color: Color(0xFF696363)), // Light Text Color
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF364C59), // Use primary color
        foregroundColor: Colors.white, // Text color
      ),
    ),
    applyElevationOverlayColor: false,
  );


  static const Color primaryTextColorLight = Color(0xFF0C0C0C);
  static const Color secondaryTextColorLight = Color(0xFF696363);
  
  static const Color primaryTextColorDark = Color(0xFFFFFFFF);
  static const Color secondaryTextColorDark = Color(0xFF696363);
}
