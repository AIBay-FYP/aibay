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
    state = LoginState(status: LoginStatus.loading);

    await Future.delayed(Duration(seconds: 2));

    if (username == "user" && password == "password") {
      state = LoginState(status: LoginStatus.success);
    } else {
      state = LoginState(
          status: LoginStatus.error, errorMessage: "Invalid credentials");
    }
  }
}

final loginProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier());
