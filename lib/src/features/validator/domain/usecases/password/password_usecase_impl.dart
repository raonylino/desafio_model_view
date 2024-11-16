import 'package:dartz/dartz.dart';
import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/domain/entities/password_entity.dart';
import 'package:desafio_model_view/src/features/validator/domain/repositories/repository.dart';
import 'package:desafio_model_view/src/features/validator/domain/usecases/password/password_usecase.dart';

final class PasswordUsecaseImpl implements PasswordUsecase {
  final Repository _validatorRepository;

  PasswordUsecaseImpl({
    required Repository validatorRepository,
  }) : _validatorRepository = validatorRepository;
  @override
  Future<Either<ValidatorException, PasswordEntity>> call() {
    return _validatorRepository.getPassword();
  }
}
