import 'package:dartz/dartz.dart';
import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/domain/entities/validator_entity.dart';

abstract class ValidatorUsecase {
  Future<Either<ValidatorException, ValidatorEntity>> call(
      {required String password});
}
