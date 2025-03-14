import 'package:aibay/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBlueButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double fontSize;
  final double elevation;
  final double height;

  const CustomBlueButton({
    super.key,
    required this.text,
    required this.onPressed, // Default text color is white
    this.padding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Default padding
    this.borderRadius = 12.0, // Default border radius
    this.fontSize = 16.0, // Default font size
    this.elevation = 4.0, // Default elevation for shadow
    this.height = 50.0, // Default button height
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: colorScheme.primary, // Text color
        padding: padding, // Padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Border radius
        ),
        elevation: elevation, // Shadow for elevation
        minimumSize: Size(double.infinity, height*0.8), // Full width button with height
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize, // Font size
          fontWeight: FontWeight.bold, // Font weight
        ),
      ),
    );
  }
}
