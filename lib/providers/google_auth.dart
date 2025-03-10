import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aibay/services/auth.dart'; // Ensure AuthService is correctly imported

final googleAuthControllerProvider =
    StateNotifierProvider<GoogleAuthController, AsyncValue<User?>>((ref) {
  return GoogleAuthController(ref);
});

class GoogleAuthController extends StateNotifier<AsyncValue<User?>> {
  final Ref ref;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService(); // For API calls

  GoogleAuthController(this.ref) : super(const AsyncValue.loading());

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return false; // User canceled login

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      state = AsyncValue.data(userCredential.user);

      // Send the ID token to the backend
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken != null) {
        await _authService.sendTokenToApi(idToken);
      }

      return true;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    state = AsyncValue.data(null);
  }
}
