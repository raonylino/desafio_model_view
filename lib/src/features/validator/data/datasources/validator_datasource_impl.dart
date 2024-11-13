import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/validator_datasource.dart';
import 'package:desafio_model_view/src/features/validator/data/models/validator_model.dart';
import 'package:dio/dio.dart';

class ValidatorDatasourceImpl extends ValidatorDatasource {
  @override
  Future<ValidatorModel> getValidator({required String password}) async {
    final dio = Dio(BaseOptions(
      validateStatus: (status) {
        return true;
      },
    ));
    var response = await dio.post(
        'https://desafioflutter-api.modelviewlabs.com/validate',
        data: {"password": password});

    if ((response.statusCode ?? 0) > 200 && (response.statusCode ?? 0) < 300) {
      return ValidatorModel.fromMap(response.data);
    }

    if (response.statusCode == 400) {
      throw ValidatorException(
          message: response.data['message'], errors: response.data['errors']);
    }

    throw ServerException(message: 'Erro de servidor, tente novamente');
  }
}
