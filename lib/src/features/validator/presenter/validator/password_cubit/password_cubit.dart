import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/datasource_impl.dart';
import 'package:desafio_model_view/src/features/validator/data/repositories/repository_impl.dart';
import 'package:desafio_model_view/src/features/validator/domain/usecases/password/password_usecase.dart';
import 'package:desafio_model_view/src/features/validator/domain/usecases/password/password_usecase_impl.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final PasswordUsecase _passwordUsecase;

  PasswordCubit({required PasswordUsecase passwordUsecase})
      : _passwordUsecase = passwordUsecase,
        super(const PasswordInitial());

  Future<void> getPassword() async {
    try {
      emit(const PasswordLoading());
      var passwordResult = await _passwordUsecase.call();

      log('Password value: $passwordResult');

      passwordResult.fold(
        (l) {
          log('Erro: ${l.message}');
          emit(const PasswordError());
          emit(const PasswordInitial());
        },
        (r) {
          log('Sucesso: sucesso, senha gerada');
          emit(PasswordSuccess(password: r.password));
          emit(const PasswordInitial());
        },
      );
    } catch (e) {
      log("Erro inesperado: $e");
      emit(const PasswordError());
      emit(const PasswordInitial());
    }
  }

  var passwordUsecase = PasswordUsecaseImpl(
      validatorRepository: RepositoryImpl(datasource: DatasourceImpl()));
}
