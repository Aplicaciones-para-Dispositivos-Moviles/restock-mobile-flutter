import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restock/core/enums/status.dart';
import 'package:restock/features/auth/data/auth_service.dart';
import 'package:restock/features/auth/presentation/blocs/register_event.dart';
import 'package:restock/features/auth/presentation/blocs/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService service;

  RegisterBloc({required this.service}) : super(const RegisterState()) {

    on<OnUsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });

    on<OnPasswordChangedRegister>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  FutureOr<void> _onRegisterSubmitted(
      RegisterSubmitted event,
      Emitter<RegisterState> emit
  ) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await service.register(
        username: state.username,
        password: state.password,
        roleId: 1,
      );

      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
