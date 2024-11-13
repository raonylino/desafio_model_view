import 'package:bloc/bloc.dart';
import 'package:desafio_model_view/src/core/exceptions/validator_exceptions.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/validator_datasource_impl.dart';
import 'package:desafio_model_view/src/features/validator/data/repositories/validator_repository_impl.dart';
import 'package:desafio_model_view/src/features/validator/domain/useCases/validator_usecase_impl.dart';

part 'validator_state.dart';

class ValidatorCubit extends Cubit<ValidatorState> {
  final ValidatorUsecaseImpl _usecase;

  ValidatorCubit({required ValidatorUsecaseImpl usecase})
      : _usecase = usecase,
        super(const ValidatorInitial());

  Future<void> validator({required String password}) async {
    emit(const ValidatorLoading());
    var result = await _usecase.call(password: password);

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
      validatorRepository:
          ValidatorRepositoryImpl(datasource: ValidatorDatasourceImpl()));
}
