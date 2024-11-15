import 'dart:developer';

import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/validator_datasource.dart';
import 'package:desafio_model_view/src/features/validator/data/models/validator_model.dart';
import 'package:dio/dio.dart';

class ValidatorDatasourceImpl extends ValidatorDatasource {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://desafioflutter-api.modelviewlabs.com',
    validateStatus: (status) => status != null && status < 500,
  ));

  @override
  Future<ValidatorModel> getValidator({required String password}) async {
    var response = await _dio.post('/validate', data: {"password": password});

    if ((response.statusCode ?? 0) > 200 && (response.statusCode ?? 0) < 300) {
      return ValidatorModel.fromMap(response.data);
    }

    if (response.statusCode == 400) {
      throw ValidatorException(
          message: response.data['message'], errors: response.data['errors']);
    }

    throw ServerException(message: 'Erro de servidor, tente novamente');
  }

  @override
  Future<ValidatorModel> getPassword() async {
    try {
      final response = await _dio.get('/random');

      if (response.statusCode == 200 && response.data != null) {
        return ValidatorModel.fromMap(response.data);
      } else {
        log("Erro na requisição: ${response.statusCode}");
        throw ServerException(message: 'Erro de servidor, tente novamente');
      }
    } on DioException catch (e) {
      log("Erro na comunicação com a API: ${e.message}");
      throw ServerException(message: 'Erro de servidor, tente novamente');
    } catch (e) {
      log("Erro inesperado: $e");
      throw ServerException(message: 'Erro de servidor, tente novamente');
    }
  }
}
