import 'dart:convert';
import 'package:aibay/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio _dio = Dio();

  /// 🔹 Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Send Firebase token to API after successful sign-in
      await sendTokenToApi(await userCredential.user?.getIdToken());

      return userCredential;
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      return null;
    }
  }

  /// 🔹 Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  /// 🔹 Send Firebase Token to API
  Future<void> sendTokenToApi(String? idToken) async {
    if (idToken == null) {
      print("⚠️ No ID token found");
      return;
    }

    try {
      String url = ApiConstants.verifyUser; // Replace with your actual API endpoint

      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $idToken',
          },
        ),
        data: json.encode({'token': idToken}),
      );

      if (response.statusCode == 200) {
        print('✅ Token sent successfully');
      } else {
        print('❌ Failed to send token: ${response.statusMessage}');
      }
    } catch (e) {
      print('❌ Error sending token: $e');
    }
  }
}
