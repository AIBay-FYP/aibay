import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aibay/services/google_auth.dart';

// Provider for the authentication service
final googleAuthServiceProvider = Provider<GoogleAuthService>((ref) {
  return GoogleAuthService();
});

// StateNotifier for Google Authentication
final googleAuthControllerProvider =
    StateNotifierProvider<GoogleAuthController, AsyncValue<User?>>((ref) {
  final authService = ref.watch(googleAuthServiceProvider);
  return GoogleAuthController(authService);
});

class GoogleAuthController extends StateNotifier<AsyncValue<User?>> {
  final GoogleAuthService _authService;

  GoogleAuthController(this._authService) : super(const AsyncValue.loading());

  Future<bool> signInWithGoogle() async {
    state = const AsyncValue.loading();
    final user = await _authService.signInWithGoogle();
    if (user != null) {
      state = AsyncValue.data(user);
      return true;
    } else {
      state = AsyncValue.data(null);
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = AsyncValue.data(null);
  }
}
