import 'package:desafio_model_view/src/core/constants/routes_assets.dart';
import 'package:desafio_model_view/src/features/validator/data/datasources/datasource_impl.dart';
import 'package:desafio_model_view/src/features/validator/data/repositories/repository_impl.dart';
import 'package:desafio_model_view/src/features/validator/domain/usecases/password/password_usecase_impl.dart';
import 'package:desafio_model_view/src/features/validator/domain/usecases/validator/validator_usecase_impl.dart';
import 'package:desafio_model_view/src/features/validator/presenter/home/cubit/home_cubit.dart';
import 'package:desafio_model_view/src/features/validator/presenter/home/home_page.dart';
import 'package:desafio_model_view/src/features/validator/presenter/validator/password_cubit/password_cubit.dart';
import 'package:desafio_model_view/src/features/validator/presenter/validator/validator_cubit/validator_cubit.dart';
import 'package:desafio_model_view/src/features/validator/presenter/validator/validator_page.dart';
import 'package:desafio_model_view/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DesafioModelApp extends StatelessWidget {
  const DesafioModelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ValidatorUsecaseImpl(
              validatorRepository:
                  RepositoryImpl(datasource: DatasourceImpl())),
        ),
        RepositoryProvider(
          create: (context) => PasswordUsecaseImpl(
              validatorRepository:
                  RepositoryImpl(datasource: DatasourceImpl())),
        ),
      ],
      child: MaterialApp(
        title: 'Desafio Model View',
        theme: ThemeData(
            extensions: const [SkeletonizerConfigData()],
            primarySwatch: Colors.blue,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            )),
        routes: {
          //--------------- SPLASH ---------------
          RoutesAssets.splashPage: (context) => const SplashPage(),
          //--------------- VALIDATOR ------------
          RoutesAssets.validatorPage: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => ValidatorCubit(
                          validatorUsecase:
                              context.read<ValidatorUsecaseImpl>(),
                          passwordUsecase: context.read<PasswordUsecaseImpl>(),
                        )),
                BlocProvider(
                    create: (context) => PasswordCubit(
                        passwordUsecase: context.read<PasswordUsecaseImpl>())),
              ],
              child: const ValidatorPage(),
            );
          },

          //--------------- HOME ---------------
          RoutesAssets.homePage: (context) => const HomePage(),
        },
      ),
    );
  }
}
