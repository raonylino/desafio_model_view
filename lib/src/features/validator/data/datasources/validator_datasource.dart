
import 'package:desafio_model_view/src/features/validator/data/models/validator_model.dart';

abstract class ValidatorDatasource {
  
  Future<ValidatorModel> getValidator({required String password});

  Future<ValidatorModel> getPassword();

}