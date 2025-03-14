import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aibay/theme/app_colors.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_getSystemTheme());

  static ThemeData _getSystemTheme() {
    return WidgetsBinding.instance.window.platformBrightness == Brightness.dark
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;
  }

  void setSystemTheme() {
    state = _getSystemTheme();
  }

  void toggleTheme() {
    state = state.brightness == Brightness.dark
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>(
  (ref) => ThemeNotifier(),
);
