import 'dart:async';
import 'package:restock/core/enums/status.dart';
import 'package:restock/features/auth/data/auth_service.dart';
import 'package:restock/features/auth/presentation/blocs/login_event.dart';
import 'package:restock/features/auth/presentation/blocs/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService service;
  
  LoginBloc({required this.service}) : super(const LoginState()) {
    on<OnEmailChanged>(
      (event, emit) => emit(state.copyWith(email: event.email)),
    );
    on<OnPasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.password)),
    );
    on<Login>(_onLogin);
  }

  FutureOr<void> _onLogin(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await service.login(state.email, state.password);
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}