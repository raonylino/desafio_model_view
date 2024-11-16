import 'package:dartz/dartz.dart';
import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/domain/entities/password_entity.dart';

abstract class PasswordUsecase {
  Future<Either<ValidatorException, PasswordEntity>> call();
}
