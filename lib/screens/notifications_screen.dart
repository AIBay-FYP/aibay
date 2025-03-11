import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aibay/theme/app_colors.dart'; // Import the AppTheme class
import 'package:aibay/providers/notifications_provider.dart'; // Import the notifications provider
import 'services_toggle_screen.dart'; // Import the Services Toggle Screen

/// StateProvider to manage the selected tab (Updates or Services)
final selectedTabProvider = StateProvider<String>((ref) => 'Updates');

class NotificationsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider); // Use notificationsProvider
    final selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(color: AppTheme.primaryTextColorDark), // Use AppTheme color
        ),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.primaryTextColorDark), // Use AppTheme color
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView( // Wrap the entire body in a SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Heading
            Text(
              "Notifications",
              style: TextStyle(
                color: AppTheme.primaryTextColorDark, // Use AppTheme color
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),

            // Toggle Buttons for Updates and Services
            _buildToggleButtons(ref, selectedTab),
            SizedBox(height: 24),

            // Conditional UI based on selected tab
            if (selectedTab == 'Updates') ...[
              // Updates Screen
              _buildUpdatesScreen(notifications),
            ] else if (selectedTab == 'Services') ...[
              // Services Screen
              ServicesToggleScreen(), // Use the Services Toggle Screen
            ],
          ],
        ),
      ),
    );
  }

  /// Toggle Buttons for "Updates" & "Services"
  Widget _buildToggleButtons(WidgetRef ref, String selectedTab) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.secondary, // Use AppTheme color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _buildToggleButton(ref, 'Updates', selectedTab == 'Updates'),
          _buildToggleButton(ref, 'Services', selectedTab == 'Services'),
        ],
      ),
    );
  }

  /// Single Toggle Button
  Widget _buildToggleButton(WidgetRef ref, String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(selectedTabProvider.notifier).state = text; // Update selected tab
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.darkTheme.colorScheme.primary // Use AppTheme color
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? AppTheme.primaryTextColorDark // Use AppTheme color
                  : AppTheme.secondaryTextColorDark, // Use AppTheme color
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  /// Updates Screen
  Widget _buildUpdatesScreen(List<Map<String, String>> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Unread Section
        Text(
          "Unread",
          style: TextStyle(
            color: AppTheme.primaryTextColorDark, // Use AppTheme color
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        ...notifications
            .where((n) => n["status"] == "unread" && n["type"] == "Updates")
            .map((notification) => _buildNotificationTile(notification, isUnread: true)),

        SizedBox(height: 24),

        // Last Month Section
        Text(
          "Last Month",
          style: TextStyle(
            color: AppTheme.primaryTextColorDark, // Use AppTheme color
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        ...notifications
            .where((n) => n["status"] == "read" && n["type"] == "Updates")
            .map((notification) => _buildNotificationTile(notification)),
      ],
    );
  }

  /// Notification Tile Widget
  Widget _buildNotificationTile(Map<String, String> notification, {bool isUnread = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnread
            ? AppTheme.darkTheme.colorScheme.primary.withOpacity(0.8) // Use AppTheme color
            : AppTheme.darkTheme.colorScheme.onSecondary, // Use AppTheme color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            notification["message"]!,
            style: TextStyle(
              color: AppTheme.primaryTextColorDark, // Use AppTheme color
              fontSize: 16,
            ),
          ),
          Text(
            notification["time"]!,
            style: TextStyle(
              color: AppTheme.secondaryTextColorDark, // Use AppTheme color
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}