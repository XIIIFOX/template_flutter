part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  const factory AuthEvent.login(String email, String password) = AuthLogin;
  const factory AuthEvent.register(
    String email,
    String password,
    String name,
  ) = AuthRegister;
  const factory AuthEvent.logout() = AuthLogout;
  const factory AuthEvent.checkAuthStatus() = AuthCheckStatus;
}

final class AuthLogin extends AuthEvent {
  const AuthLogin(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

final class AuthRegister extends AuthEvent {
  const AuthRegister(this.email, this.password, this.name);

  final String email;
  final String password;
  final String name;

  @override
  List<Object> get props => [email, password, name];
}

final class AuthLogout extends AuthEvent {
  const AuthLogout();

  @override
  List<Object> get props => const [];
}

final class AuthCheckStatus extends AuthEvent {
  const AuthCheckStatus();

  @override
  List<Object> get props => const [];
}
