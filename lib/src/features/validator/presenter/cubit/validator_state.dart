part of 'validator_cubit.dart';

sealed class ValidatorState {
  const ValidatorState();
}

class ValidatorInitial extends ValidatorState {
  const ValidatorInitial();
}

final class ValidatorLoading extends ValidatorState {
  const ValidatorLoading();
}

final class ValidatorSuccess extends ValidatorState {
  final String message;
  final String id;
  const ValidatorSuccess({required this.message, required this.id});
}

final class ValidatorError extends ValidatorState {
  final String message;
  final List? errors;
  const ValidatorError({required this.message, this.errors});
}

final class ValidatorServerError extends ValidatorState {
  final String message;
  final List? errors;
  const ValidatorServerError({required this.message, this.errors});
}
