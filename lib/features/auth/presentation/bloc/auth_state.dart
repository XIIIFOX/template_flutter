part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(UserEntity user) = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.error(Failure failure) = AuthError;
}

final class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => const [];
}

final class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object> get props => const [];
}

final class Authenticated extends AuthState {
  const Authenticated(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  List<Object> get props => const [];
}

final class AuthError extends AuthState {
  const AuthError(this.failure);

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
