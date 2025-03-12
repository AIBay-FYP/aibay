import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:aibay/constants.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: dotenv.env["FIREBASE_CLIENT_ID"]);
  final hello = dotenv.env["FIREBASE_CLIENT_ID"];
  final Dio _dio = Dio();

  /// 🔹 Google Sign-In
  Future<User?> signInWithGoogle() async {
  log(hello.toString());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
      if (googleUser == null) {
        log("⚠ User canceled Google Sign-In");
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        // idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // 🔹 Send the Firebase ID token to API
      // await sendTokenToApi(userCredential.user);

      return userCredential.user;
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      return null;
    }
  }

  /// 🔹 Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      print("✅ User signed out successfully");
    } catch (e) {
      print("❌ Error during sign out: $e");
    }
  }

  /// 🔹 Send Firebase Token to API
  Future<void> sendTokenToApi(User? user) async {
    if (user == null) {
      print("⚠ No user found");
      return;
    }

    try {
      String? idToken = await user.getIdToken();
      if (idToken == null) {
        print("⚠ No ID token found");
        return;
      }

      String url = ApiConstants.verifyUser; // Replace with your actual API endpoint

      final response = await _dio.post(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: json.encode({
          'token': idToken,
          'name': user.displayName,
          'email': user.email,
        }),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        print('✅ User Verified: ${response.data['user']}');
      } else {
        print('❌ Server Error: ${response.data['message']}');
      }
    } catch (e) {
      print('❌ Error sending token: $e');
    }
  }
}
