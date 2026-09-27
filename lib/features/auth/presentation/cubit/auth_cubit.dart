import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';
import 'authstate.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (state is AuthLoading) return;

    if (email.trim().isEmpty || password.isEmpty) {
      emit(
        AuthFailure(
          "Please enter email and password",
        ),
      );
      return;
    }

    emit(AuthLoading());

    try {
      await repository.login(
        email: email.trim(),
        password: password,
      );

      emit(AuthLoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getErrorMessage(e)));
    } catch (e) {
      emit(AuthFailure("Error: $e"));
    }
  }

  Future<void> loginWithGoogle() async {
    if (state is AuthLoading) return;

    emit(AuthLoading());

    try {
      await repository.loginWithGoogle();

      emit(AuthGoogleLoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getGoogleErrorMessage(e)));
    } catch (e) {
      emit(AuthFailure("Google Login Error: $e"));
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    if (state is AuthLoading) return;

    if (email.trim().isEmpty ||
        password.isEmpty ||
        name.trim().isEmpty ||
        phone.trim().isEmpty) {
      emit(
        AuthFailure(
          "Please enter all required data",
        ),
      );
      return;
    }

    emit(AuthLoading());

    try {
      await repository.register(
        email: email.trim(),
        password: password,
        name: name.trim(),
        phone: phone.trim(),
      );

      emit(AuthRegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getRegisterErrorMessage(e)));
    } catch (e) {
      emit(AuthFailure("Registration failed: $e"));
    }
  }
  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    if (state is AuthLoading) return;

    if (name.trim().isEmpty || phone.trim().isEmpty) {
      emit(
        AuthFailure(
          "Please fill all fields",
        ),
      );
      return;
    }

    emit(AuthLoading());

    try {
      await repository.updateProfile(
        name: name.trim(),
        phone: phone.trim(),
      );

      emit(AuthUpdateSuccess());
    } catch (e) {
      emit(
        AuthFailure(
          "Failed to update data",
        ),
      );
    }
  }
  Future<void> resetPassword({
    required String email,
  }) async {
    if (state is AuthLoading) return;

    if (email.trim().isEmpty) {
      emit(
        AuthFailure(
          "Please enter your email",
        ),
      );
      return;
    }

    emit(AuthLoading());

    try {
      await repository.resetPassword(
        email: email.trim(),
      );

      emit(AuthResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getResetPasswordErrorMessage(e)));
    } catch (e) {
      emit(
        AuthFailure(
          "Failed to send reset email",
        ),
      );
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      return "No account found with this email";
    }

    if (e.code == 'wrong-password' ||
        e.code == 'invalid-credential') {
      return "Email or password is incorrect";
    }

    if (e.code == 'invalid-email') {
      return "Invalid email";
    }

    if (e.code == 'network-request-failed') {
      return "Please check your internet connection";
    }

    return e.message ?? "Login failed";
  }

  String _getGoogleErrorMessage(FirebaseAuthException e) {
    if (e.code == 'network-request-failed') {
      return "Please check your internet connection";
    }

    if (e.code == 'account-exists-with-different-credential') {
      return "An account already exists with a different sign-in method";
    }

    return e.message ?? "Google Login failed";
  }

  String _getRegisterErrorMessage(FirebaseAuthException e) {
    if (e.code == 'email-already-in-use') {
      return "This email is already registered";
    }

    if (e.code == 'invalid-email') {
      return "Invalid email";
    }

    if (e.code == 'weak-password') {
      return "Password is too weak";
    }

    if (e.code == 'network-request-failed') {
      return "Please check your internet connection";
    }

    return e.message ?? "Registration failed";
  }

  String _getResetPasswordErrorMessage(
      FirebaseAuthException e,
      ) {
    if (e.code == 'invalid-email') {
      return "Invalid email";
    }

    if (e.code == 'user-not-found') {
      return "No account found with this email";
    }

    if (e.code == 'network-request-failed') {
      return "Please check your internet connection";
    }

    return e.message ?? "Failed to send reset email";
  }
}