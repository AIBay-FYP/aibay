import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final listingsProvider = FutureProvider<List<dynamic>>((ref) async {
  final response = await Dio().get("http://localhost:5000/listings");
  print("Fetched items: ${response.data.length}");  // Debugging
  return response.data;
});