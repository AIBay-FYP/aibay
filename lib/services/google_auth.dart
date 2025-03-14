import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:aibay/constants.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const List<String> scopes = [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];


  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: dotenv.env["FIREBASE_CLIENT_ID"],
    scopes: scopes,
  );
  
  final hello = dotenv.env["FIREBASE_CLIENT_ID"];
  final Dio _dio = Dio();


  Future<User?> signInWithGoogle() async {
  log(hello.toString());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAccount? account = _googleSignIn.currentUser;

      if (googleUser == null) {
        log("⚠ User canceled Google Sign-In");
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      await sendTokenToApi(userCredential.user);

      return userCredential.user;
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      print("✅ User signed out successfully");
    } catch (e) {
      print("❌ Error during sign out: $e");
    }
  }

  Future<void> sendTokenToApi(User? user) async {
    if (user == null) {
      print("⚠ No user found");
      return;
    }
    try {
      String? idToken = await user.getIdToken();
      log(idToken!);
      if (idToken == null) {
        print("⚠ No ID token found");
        return;
      }
      final base = dotenv.env['BASE_URL']!;
      final dio = Dio(BaseOptions(
        baseUrl: base,  // Replace with your server's address
        connectTimeout: Duration(milliseconds: 100000),  // 10 seconds (increase if needed)
        receiveTimeout: Duration(milliseconds: 100000),  // 10 seconds (increase if needed)
      ));

      String url = ApiConstants.verifyUser; 
      log(url);

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
