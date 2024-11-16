part of 'password_cubit.dart';

sealed class PasswordState {
  const PasswordState();
}

final class PasswordInitial extends PasswordState {
  const PasswordInitial();
}

final class PasswordLoading extends PasswordState {
  const PasswordLoading();
}

final class PasswordSuccess extends PasswordState {
  final String password;
  const PasswordSuccess({required this.password});
}

final class PasswordError extends PasswordState {
  const PasswordError();
}
