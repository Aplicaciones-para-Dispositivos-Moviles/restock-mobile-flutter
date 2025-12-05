import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restock/core/enums/status.dart';
import 'package:restock/features/auth/data/local/auth_storage.dart';
import 'package:restock/features/auth/data/remote/auth_service.dart';
import 'package:restock/features/auth/presentation/blocs/register_event.dart';
import 'package:restock/features/auth/presentation/blocs/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService service;
  final AuthStorage storage;

  RegisterBloc({
    required this.service,
    required this.storage,
  }) : super(const RegisterState()) {

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
      // Registrar usuario
      await service.register(
        username: state.username,
        password: state.password,
        roleId: 1,
      );

      // Hacer login automático después del registro
      final user = await service.login(state.username, state.password);

      // Guardar sesión
      await storage.saveSession(
        userId: user.id,
        token: user.token,
      );

      emit(state.copyWith(
        status: Status.success,
        userSubscription: user.subscription,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
