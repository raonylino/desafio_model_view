import 'package:desafio_model_view/src/constants/routes_assets.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/validator_datasource_impl.dart';
import 'package:desafio_model_view/src/features/validator/data/repositories/validator_repository_impl.dart';
import 'package:desafio_model_view/src/features/validator/domain/useCases/validator_usecase_impl.dart';
import 'package:desafio_model_view/src/features/validator/presenter/cubit/validator_cubit.dart';
import 'package:desafio_model_view/src/features/validator/presenter/validator_page.dart';
import 'package:desafio_model_view/src/features/validator/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesafioModelApp extends StatelessWidget {
  const DesafioModelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ValidatorUsecaseImpl(
          validatorRepository:
              ValidatorRepositoryImpl(datasource: ValidatorDatasourceImpl())),
      child: MaterialApp(
        title: 'Desafio Model View',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          //--------------- SPLASH ---------------
          RoutesAssets.splashPage: (context) => const SplashPage(),
          //--------------- VALIDATOR ------------
          RoutesAssets.validatorPage: (context) {
            return BlocProvider(
                create: (context) => ValidatorCubit(
                    usecase: context.read<ValidatorUsecaseImpl>()),
                child: const ValidatorPage());
          },
        },
      ),
    );
  }
}
