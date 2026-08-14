import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_flutter/core/error/failures.dart';
import 'package:template_flutter/features/auth/domain/entities/user_entity.dart';
import 'package:template_flutter/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:template_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:template_flutter/features/auth/domain/usecases/logout_usecase.dart';
import 'package:template_flutter/features/auth/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthLogin(:final email, :final password):
          await _onLogin(email, password, emit);
        case AuthRegister(:final email, :final password, :final name):
          await _onRegister(email, password, name, emit);
        case AuthLogout():
          await _onLogout(emit);
        case AuthCheckStatus():
          await _onCheckAuthStatus(emit);
      }
    });
  }

  Future<void> _onLogin(String email, String password, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await loginUseCase(LoginParams(email: email, password: password));
    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onRegister(String email, String password, String name, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await registerUseCase(RegisterParams(email: email, password: password, name: name));
    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onLogout(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await logoutUseCase();
    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> _onCheckAuthStatus(Emitter<AuthState> emit) async {
    final result = await getCurrentUserUseCase();
    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (user) => user != null
          ? emit(AuthState.authenticated(user))
          : emit(const AuthState.unauthenticated()),
    );
  }
}

extension AuthStateMatching on AuthState {
  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(UserEntity user)? authenticated,
    T Function()? unauthenticated,
    T Function(Failure failure)? error,
    required T Function() orElse,
  }) =>
      switch (this) {
        AuthInitial() when initial != null => initial(),
        AuthLoading() when loading != null => loading(),
        Authenticated(:final user) when authenticated != null =>
          authenticated(user),
        Unauthenticated() when unauthenticated != null => unauthenticated(),
        AuthError(:final failure) when error != null => error(failure),
        _ => orElse(),
      };
}
