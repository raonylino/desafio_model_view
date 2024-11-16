import 'package:bloc/bloc.dart';
import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/datasource_impl.dart';
import 'package:desafio_model_view/src/features/validator/data/repositories/repository_impl.dart';
import 'package:desafio_model_view/src/features/validator/domain/usecases/password/password_usecase.dart';
import 'package:desafio_model_view/src/features/validator/domain/usecases/validator/validator_usecase_impl.dart';

part 'validator_state.dart';

class ValidatorCubit extends Cubit<ValidatorState> {
  final ValidatorUsecaseImpl _validatorUsecase;

  ValidatorCubit(
      {required ValidatorUsecaseImpl validatorUsecase,
      required PasswordUsecase passwordUsecase})
      : _validatorUsecase = validatorUsecase,
        super(const ValidatorInitial());

  Future<void> validator({required String password}) async {
    emit(const ValidatorLoading());
    var result = await _validatorUsecase.call(password: password);

    result.fold(
      (l) {
        if (l is ServerException) {
          emit(ValidatorServerError(message: l.message, errors: l.errors));
        } else {
          emit(ValidatorError(message: l.message, errors: l.errors));
        }

        emit(const ValidatorInitial());
      },
      (r) {
        emit(ValidatorSuccess(id: r.id, message: r.message));
        emit(const ValidatorInitial());
      },
    );
  }

  var usecase = ValidatorUsecaseImpl(
      validatorRepository: RepositoryImpl(datasource: DatasourceImpl()));
}
