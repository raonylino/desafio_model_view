import 'package:desafio_model_view/src/features/validator/data/models/password_model.dart';
import 'package:desafio_model_view/src/features/validator/data/models/validator_model.dart';

abstract class Datasource {
  Future<ValidatorModel> getValidator({required String password});

  Future<PasswordModel> getPassword();
}
