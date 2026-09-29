abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthGoogleLoginSuccess extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthResetPasswordSuccess extends AuthState {}

class AuthUpdateSuccess extends AuthState {}

class AuthDeleteSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}
