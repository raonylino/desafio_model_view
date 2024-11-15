
import 'package:dartz/dartz.dart';
import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/domain/entities/validator_entity.dart';

abstract class ValidatorRepository {
  Future <Either<ValidatorException, ValidatorEntity>> call({required String password});

  Future<Either<ValidatorException, ValidatorEntity>> getPassword();
}