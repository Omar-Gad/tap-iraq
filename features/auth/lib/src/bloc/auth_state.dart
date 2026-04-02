import 'package:core/core.dart';
import 'package:domain/domain.dart';

enum AuthStep {
  login,
  register,
  userRegister,
  resetPassword,
}

sealed class AuthState extends Equatable {
  final AuthStep step;
  final String? email;
  final String? password;

  const AuthState({
    this.step = AuthStep.login,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [step, email, password];
}

class AuthInitial extends AuthState {
  const AuthInitial({
    super.step,
    super.email,
    super.password,
  });
}

class AuthLoading extends AuthState {
  const AuthLoading({
    super.step,
    super.email,
    super.password,
  });
}


class AuthSuccess extends AuthState {
  final AppUser user;

  const AuthSuccess(
    this.user, {
    super.step,
    super.email,
    super.password,
  });

  @override
  List<Object?> get props => [user, step, email, password];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(
    this.message, {
    super.step,
    super.email,
    super.password,
  });

  @override
  List<Object?> get props => [message, step, email, password];
}


