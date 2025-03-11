import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aibay/theme/app_colors.dart'; // Import the AppTheme class
import 'package:aibay/providers/notifications_provider.dart'; // Import the notifications provider

/// StateProvider to manage the selected toggle button (In Progress, Booked, or Requested)
final selectedToggleProvider = StateProvider<String>((ref) => 'In Progress');

class ServicesToggleScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inProgress = ref.watch(inProgressProvider); // Use inProgressProvider
    final booked = ref.watch(bookedProvider); // Use bookedProvider
    final requested = ref.watch(requestedProvider); // Use requestedProvider
    final selectedToggle = ref.watch(selectedToggleProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Toggle Buttons for In Progress, Booked, and Requested
          _buildToggleButtonsForServices(ref, selectedToggle),
          SizedBox(height: 16),

          // Conditional UI based on selected toggle
          if (selectedToggle == 'In Progress') ...[
            _buildServicesScreen(inProgress),
          ] else if (selectedToggle == 'Booked') ...[
            _buildServicesScreen(booked),
          ] else if (selectedToggle == 'Requested') ...[
            _buildServicesScreen(requested),
          ],
        ],
      ),
    );
  }

  /// Toggle Buttons for "In Progress", "Booked", and "Requested"
  Widget _buildToggleButtonsForServices(WidgetRef ref, String selectedToggle) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // In Progress Button
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8), // Add space between buttons
              child: _buildToggleButton(ref, 'In Progress', selectedToggle == 'In Progress'),
            ),
          ),

          // Booked Button
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4), // Add space between buttons
              child: _buildToggleButton(ref, 'Booked', selectedToggle == 'Booked'),
            ),
          ),

          // Requested Button
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8), // Add space between buttons
              child: _buildToggleButton(ref, 'Requested', selectedToggle == 'Requested'),
            ),
          ),
        ],
      ),
    );
  }

  /// Single Toggle Button
  Widget _buildToggleButton(WidgetRef ref, String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedToggleProvider.notifier).state = text; // Update selected toggle
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.darkTheme.colorScheme.primary // Use AppTheme color
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppTheme.darkTheme.colorScheme.primary // Use AppTheme color
                : Colors.grey.shade600, // Slightly different gray for unselected
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? AppTheme.primaryTextColorDark // Use AppTheme color
                : Colors.grey.shade400, // Slightly different gray for unselected
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  /// Services Screen (Shared UI for In Progress, Booked, and Requested)
  Widget _buildServicesScreen(List<Map<String, dynamic>> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Services List
        ...services.map((service) => _buildServiceTile(service)).toList(),
      ],
    );
  }

  /// Service Tile Widget
  Widget _buildServiceTile(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.onSecondary, // Use AppTheme color
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.darkTheme.colorScheme.primary, // Use AppTheme color
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat Icon Button (Top Right Corner)
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.chat, color: AppTheme.primaryTextColorDark),
              onPressed: () {
                // Handle chat button press
                print("Chat clicked for ${service["productName"]}");
              },
            ),
          ),

          // Product Image and Details
          Row(
            children: [
              // Product Image (Placeholder)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800, // Placeholder for image
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.image, color: Colors.grey.shade400), // Placeholder icon
              ),
              SizedBox(width: 16),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // Product Name
                  Text(
                    service["productName"], // Product name
                    style: TextStyle(
                      color: AppTheme.primaryTextColorDark, // Use AppTheme color
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Type
                  Text(
                    service["type"], // Type
                    style: TextStyle(
                      color: AppTheme.secondaryTextColorDark, // Use AppTheme color
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Price
                  Text(
                    service["price"], // Price
                    style: TextStyle(
                      color: AppTheme.secondaryTextColorDark, // Use AppTheme color
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  
                    // Action Buttons
                    Wrap(
                      spacing: 8,
                      children: service["actions"].map<Widget>((action) {
                        return action == "Cancel"
                            ? OutlinedButton(
                                onPressed: () {
                                  // Handle cancel button press
                                  print("$action clicked for ${service["productName"]}");
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.white, // White border
                                    width: 1,
                                  ),
                                  backgroundColor: Colors.transparent, // Transparent background
                                ),
                                child: Text(
                                  action,
                                  style: TextStyle(
                                    color: Colors.white, // White text
                                    fontWeight: FontWeight.normal, // Non-bold text
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  // Handle button press
                                  print("$action clicked for ${service["productName"]}");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.darkTheme.colorScheme.primary, // Use AppTheme color
                                  foregroundColor: AppTheme.primaryTextColorDark, // Use AppTheme color
                                ),
                                child: Text(action),
                              );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}