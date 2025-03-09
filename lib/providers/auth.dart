import 'package:aibay/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  return AuthController(ref);
});

class AuthController extends StateNotifier<AsyncValue<User?>> {
  final Ref ref;
  String _verificationId = "";

  AuthController(this.ref) : super(const AsyncValue.loading());
  FirebaseAuth get _auth => ref.read(firebaseAuthProvider);
  final AuthService _authService = AuthService();

  // phone number verification
  Future<bool> verifyPhoneNumber(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          state = AsyncValue.data(_auth.currentUser);
        },
        verificationFailed: (FirebaseAuthException e) {
          state = AsyncValue.error(e, StackTrace.current);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          print(_verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );

      return true;

    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<bool> signInWithOtp(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
      state = AsyncValue.data(_auth.currentUser);
      await _sendTokenToApi();
      return true;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = AsyncValue.data(null);
  }


   Future<void> _sendTokenToApi() async {
    try {
      // Retrieve the ID token of the current user
      String? idToken = await _auth.currentUser?.getIdToken();

      if (idToken != null) {
        // Call AuthService to send token to API
        await _authService.sendTokenToApi(idToken);
      }
    } catch (e) {
      print('Error sending token: $e');
    }
  }
}
