import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState {
  final LoginStatus status;
  final String? errorMessage;

  LoginState({this.status = LoginStatus.initial, this.errorMessage});
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  Future<void> login(String username, String password) async {
    state = LoginState(status: LoginStatus.loading);  // Set state to loading

    await Future.delayed(Duration(seconds: 2));

    if (username == "user" && password == "password") {
      state = LoginState(status: LoginStatus.success);  // Set state to success
    } else {
      state = LoginState(
          status: LoginStatus.error, errorMessage: "Invalid credentials");  // Set state to error
    }
  }

  Future<void> signInWithGoogle() async {
    state = LoginState(status: LoginStatus.loading);  // Set state to loading

    try {
      await Future.delayed(Duration(seconds: 2));

      state = LoginState(status: LoginStatus.success);
    } catch (e) {
      state = LoginState(status: LoginStatus.error, errorMessage: "Google sign-in failed");
    }
  }
}


final loginProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier());
