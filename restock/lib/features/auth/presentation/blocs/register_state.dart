import 'package:restock/core/enums/status.dart';

class RegisterState {
  final Status status;
  final String username;
  final String password;
  final String? message;
  final int? userSubscription;

  const RegisterState({
    this.status = Status.initial,
    this.username = '',
    this.password = '',
    this.message,
    this.userSubscription,
  });

  RegisterState copyWith({
    Status? status,
    String? username,
    String? password,
    String? message,
    int? userSubscription,
  }) {
    return RegisterState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      message: message ?? this.message,
      userSubscription: userSubscription ?? this.userSubscription,
    );
  }
}
