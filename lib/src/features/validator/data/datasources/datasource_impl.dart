import 'dart:developer';

import 'package:desafio_model_view/src/core/constants/api_path.dart';
import 'package:desafio_model_view/src/core/constants/status_code_accepted.dart';
import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/datasource.dart';
import 'package:desafio_model_view/src/features/validator/data/models/password_model.dart';
import 'package:desafio_model_view/src/features/validator/data/models/validator_model.dart';
import 'package:dio/dio.dart';

class DatasourceImpl extends Datasource {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiPath.baseUrl,
    validateStatus: (status) =>
        status != null && StatusCodeAccepted.accepted.contains(status),
  ))
    ..interceptors.add(LogInterceptor());

  @override
  Future<ValidatorModel> getValidator({required String password}) async {
    var response = await _dio.post(ApiPath.validator, data: {
      "password": password,
      'author:': 'Raony Lino de Oliveira - raony_lino@hotmail.com'
    });

    if ((response.statusCode ?? 0) > 200 && (response.statusCode ?? 0) < 300) {
      return ValidatorModel.fromMap(response.data);
    }

    if (response.statusCode == 400) {
      throw ValidatorException(
          message: response.data['message'], errors: response.data['errors']);
    }

    if (response.statusCode == 503) {
      if (response.data['message'] != null) {
        throw ServerException(message: response.data['message']);
      }
    }

    throw ServerException(message: 'Erro inesperado');
  }

  @override
  Future<PasswordModel> getPassword() async {
    try {
      final response = await _dio.get(ApiPath.random,
          data: {'author:': 'Raony Lino de Oliveira - raony_lino@hotmail.com'});

      log('response: ${response.data}');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        if (data['password'] == null) {
          log('Password is null');
          throw ServerException(message: 'Password is null');
        } else if (data['password'] is! String) {
          log('Password is not a string');
          throw ServerException(message: 'Password is not a string');
        }
        return PasswordModel.fromMap(data);
      } else {
        log("Erro na requisição: ${response.statusCode}");
        throw ServerException(message: 'Erro de servidor, tente novamente');
      }
    } on DioException catch (e) {
      log("Erro na comunicação com a API: ${e.message}");
      throw ServerException(message: 'Erro de servidor, tente novamente');
    } catch (e) {
      log("Erro inesperado 2: $e");
      throw ServerException(message: 'Erro de servidor, tente novamente');
    }
  }
}
