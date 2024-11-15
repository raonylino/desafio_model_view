import 'package:dartz/dartz.dart';
import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/domain/entities/validator_entity.dart';
import 'package:desafio_model_view/src/features/validator/domain/repositories/validator_repository.dart';
import 'package:desafio_model_view/src/features/validator/domain/usecases/validator_usecase.dart';

final class ValidatorUsecaseImpl implements ValidatorUsecase {
  final ValidatorRepository _validatorRepository;

  ValidatorUsecaseImpl({
    required ValidatorRepository validatorRepository,
  }) : _validatorRepository = validatorRepository;
  @override
  Future<Either<ValidatorException, ValidatorEntity>> call(
      {required String password}) {
    return _validatorRepository.call(password: password);
  }

 Future<Either<ValidatorException, ValidatorEntity>> getPassword() {
    return _validatorRepository.getPassword();
 }
}
