import 'package:restock/core/enums/status.dart';

class LoginState {
  final Status status;
  final String email;
  final String password;
  final String? message;

  const LoginState({
    this.status = Status.initial,
    this.email = '',
    this.password = '',
    this.message,
  });

  LoginState copyWith({
    Status? status,
    String? email,
    String? password,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }
}