import 'package:aibay/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(AppTheme.darkTheme); 

  void toggleTheme() {
    state = state.brightness == Brightness.dark
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>(
  (ref) => ThemeNotifier(),
);
