import 'dart:convert';
import 'package:aibay/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // To load dotenv

class AuthService {
  final Dio _dio = Dio();  

  // Function to send token to the API using Dio
  Future<void> sendTokenToApi(String idToken) async {
    try {
      // Get the baseUrl from environment variables
      String url = ApiConstants.verifyUser;

      // Send the token to the API
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $idToken',
          },
        ),
        data: json.encode({
          'token': idToken,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Token sent successfully');
      } else {
        // Handle failure
        print('Failed to send token: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error sending token: $e');
      throw Exception('Error sending token to API');
    }
  }
}



