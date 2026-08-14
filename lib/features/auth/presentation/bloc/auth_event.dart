part of 'auth_bloc.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(String email, String password) = AuthLogin;
  const factory AuthEvent.register(String email, String password, String name) = AuthRegister;
  const factory AuthEvent.logout() = AuthLogout;
  const factory AuthEvent.checkAuthStatus() = AuthCheckStatus;
}
