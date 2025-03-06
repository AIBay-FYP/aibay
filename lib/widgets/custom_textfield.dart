import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? placeholder;
  final IconData? icon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.placeholder,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;


    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, 
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textTheme.bodyMedium, // Use hint color from the theme
          prefixIcon: icon != null ? Icon(icon, color: colorScheme.onSecondary) : null,
          fillColor: colorScheme.onSecondary,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: colorScheme.onSecondary, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: colorScheme.onSecondary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: colorScheme.onSecondary.withValues(alpha:0.5), width: 1),
          ),
        ),
        style: TextStyle(color: colorScheme.onSecondary, fontSize: screenWidth * 0.04), // Font size responsive
      ),
    );
  }
}
