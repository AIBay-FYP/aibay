import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {"message": "Your requested service is now available", "time": "12:32", "status": "unread", "type": "Updates"},
    {"message": "Your requested service is now available", "time": "12:32", "status": "read", "type": "Updates"},
    {"message": "Your requested service is now available", "time": "12:43", "status": "read", "type": "Updates"},
    {"message": "Your requested service is now available", "time": "12:22", "status": "read", "type": "Updates"},
  ];
});

/// Mock Data for In Progress Screen
final inProgressProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      "productName": "Product Name 1",
      "type": "Rent",
      "price": "Rs 100/day", // Price
      "actions": ["Pay Now", "Cancel"],
    },
    {
      "productName": "Product Name 2",
      "type": "Rent",
      "price": "Rs 100/day", // Price
      "actions": ["Pay Now", "Cancel"],
    },
  ];
});

/// Mock Data for Booked Screen
final bookedProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      "productName": "Product Name 3",
      "type": "Rent",
      "price": "Rs 100/day", // Price
      "actions": ["Get Contract"],
    },
  ];
});

/// Mock Data for Requested Screen
final requestedProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      "productName": "Product Name 4",
      "type": "Rent",
      "price": "Rs 100/day", // Price
      "actions": ["Cancel Request"],
    },
    {
      "productName": "Product Name 5",
      "type": "Rent",
      "price": "Rs 100/day", // Price
      "actions": ["Cancel Request"],
    },
  ];
});