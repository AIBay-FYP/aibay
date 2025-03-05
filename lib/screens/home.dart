import 'package:aibay/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Switcher"),
        backgroundColor: colorScheme.surface, 
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Min Background Color Box
            Container(
              height: 60,
              width: double.infinity,
              color: const Color(0xFF0C0C0C), // Fixed Min Background Color
              child: const Center(
                child: Text("Min Background", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),

            // Background Color Box
            Container(
              height: 60,
              width: double.infinity,
              color: colorScheme.surface, 
              child: Center(
                child: Text("Background", style: textTheme.bodyLarge),
              ),
            ),
            const SizedBox(height: 10),

            // Text Colors
            Text(
              "Text Color",
              style: TextStyle(color: textTheme.bodyLarge?.color, fontSize: 18),
            ),
            const SizedBox(height: 5),

            Text(
              "Light Text Color",
              style: TextStyle(color: textTheme.bodyMedium?.color, fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Highlighter Color Box
            Container(
              height: 60,
              width: double.infinity,
              color: colorScheme.secondary, // Dynamic Highlighter Color
              child: Center(
                child: Text("Highlighter", style: textTheme.bodyLarge),
              ),
            ),
            const SizedBox(height: 10),

            // Button / Highlight Color
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary, // Dynamic Button Color
              ),
              onPressed: () {},
              child: const Text("Button / Highlight"),
            ),
            const SizedBox(height: 10),

            // TextField Example (Uses Light/Dark Mode Colors)
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: colorScheme.onSecondary, // Dynamic TextField Color
                hintText: "Enter text...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
