// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/validator_datasource.dart';
import 'package:desafio_model_view/src/features/validator/domain/entities/validator_entity.dart';
import 'package:desafio_model_view/src/features/validator/domain/repositories/validator_repository.dart';

class ValidatorRepositoryImpl implements ValidatorRepository {
  final ValidatorDatasource _datasource;

  ValidatorRepositoryImpl({required ValidatorDatasource datasource})
      : _datasource = datasource;

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
      return Left(ServerException(message: e.toString()));
    }
  }
  
  @override
  Future<Either<ValidatorException, ValidatorEntity>> getPassword() async {
     try{
       final password = await _datasource.getPassword();
       return Right(password);
     } on ServerException catch (e) {
      return Left(ServerException(message: e.message));
    } on ValidatorException catch (e) {
      return Left(ValidatorException(message: e.message, errors: e.errors));
    } catch (e) {
      return Left(ServerException(message: e.toString()));
    }

  }
}
