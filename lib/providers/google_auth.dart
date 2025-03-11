import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';

import 'package:aibay/constants.dart';



final googleAuthControllerProvider =

    StateNotifierProvider<GoogleAuthController, AsyncValue<User?>>((ref) {

  return GoogleAuthController();

});



class GoogleAuthController extends StateNotifier<AsyncValue<User?>> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: dotenv.env['FIREBASE_CLIENT_ID']);

  final Dio _dio = Dio();



  GoogleAuthController() : super(const AsyncValue.loading());



  /// 🔹 Google Sign-In

  Future<bool> signInWithGoogle() async {

    try {

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {

        print("⚠ User canceled Google Sign-In");

        return false;

      }



      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(

        accessToken: googleAuth.accessToken,

        idToken: googleAuth.idToken,

      );



      final UserCredential userCredential =

          await _auth.signInWithCredential(credential);



      state = AsyncValue.data(userCredential.user);



      // 🔹 Send the Firebase ID token to API

      await sendTokenToApi(await userCredential.user?.getIdToken());



      return true;

    } catch (e, stackTrace) {

      print("❌ Google Sign-In Error: $e");

      state = AsyncValue.error(e, stackTrace);

      return false;

    }

  }



  /// 🔹 Sign Out

  Future<void> signOut() async {

    try {

      await _auth.signOut();

      await _googleSignIn.signOut();

      state = AsyncValue.data(null);

      print("✅ User signed out successfully");

    } catch (e) {

      print("❌ Error during sign out: $e");

    }

  }



  /// 🔹 Send Firebase Token to API

  Future<void> sendTokenToApi(String? idToken) async {

    if (idToken == null) {

      print("⚠ No ID token found");

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