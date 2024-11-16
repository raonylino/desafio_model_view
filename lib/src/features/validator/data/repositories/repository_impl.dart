// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/datasource.dart';
import 'package:desafio_model_view/src/features/validator/domain/entities/password_entity.dart';
import 'package:desafio_model_view/src/features/validator/domain/entities/validator_entity.dart';
import 'package:desafio_model_view/src/features/validator/domain/repositories/repository.dart';

class RepositoryImpl implements Repository {
  final Datasource _datasource;

  RepositoryImpl({required Datasource datasource}) : _datasource = datasource;

  @override
  Future<Either<ValidatorException, ValidatorEntity>> call(
      {required String password}) async {
    try {
      final result = await _datasource.getValidator(password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerException(message: e.message));
    } on ValidatorException catch (e) {
      return Left(ValidatorException(message: e.message, errors: e.errors));
    } catch (e) {
      return Left(ServerException(message: 'Erro inesperado'));
    }
  }

  @override
  Future<Either<ValidatorException, PasswordEntity>> getPassword() async {
    try {
      final password = await _datasource.getPassword();
      return Right(password);
    } on ServerException catch (e) {
      return Left(ServerException(message: e.message));
    } on ValidatorException catch (e) {
      return Left(ValidatorException(message: e.message, errors: e.errors));
    } catch (e) {
      return Left(ServerException(message: 'Erro inesperado'));
    }
  }
}
