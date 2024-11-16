import 'package:desafio_model_view/src/core/constants/app_colors.dart';
import 'package:desafio_model_view/src/core/constants/app_text_styles.dart';
import 'package:desafio_model_view/src/core/shared/widgets/loader.dart';
import 'package:desafio_model_view/src/features/validator/presenter/home/home_page.dart';
import 'package:desafio_model_view/src/features/validator/presenter/validator/password_cubit/password_cubit.dart';
import 'package:desafio_model_view/src/features/validator/presenter/validator/validator_cubit/validator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:validatorless/validatorless.dart';

class ValidatorPage extends StatefulWidget {
  const ValidatorPage({super.key});

  @override
  State<ValidatorPage> createState() => _ValidatorPageState();
}

class _ValidatorPageState extends State<ValidatorPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validatorCubit = context.read<ValidatorCubit>();
    final passwordCubit = context.read<PasswordCubit>();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/background.png'),
          backgroundColor: Colors.black,
          toolbarHeight: 220,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
            ),
          ),
        ),
        body: BlocConsumer<ValidatorCubit, ValidatorState>(
            bloc: validatorCubit,
            listener: (context, state) {
              if (state is ValidatorError) {
                showTopSnackBar(
                    snackBarPosition: SnackBarPosition.bottom,
                    Overlay.of(context),
                    CustomSnackBar.error(
                        message: '${state.message}\n${state.errors}}'));
              }

              if (state is ValidatorServerError) {
                showTopSnackBar(
                    snackBarPosition: SnackBarPosition.bottom,
                    Overlay.of(context),
                    CustomSnackBar.error(message: state.message));
              }

              if (state is ValidatorSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(
                      initialMessage: state.message,
                    ),
                  ),
                );

                /* showTopSnackBar(
                    snackBarPosition: SnackBarPosition.bottom,
                    Overlay.of(context),
                    CustomSnackBar.success(message: state.message)); */
              }
            },
            builder: (context, state) {
              return switch (state) {
                ValidatorLoading() => const Loader(),
                ValidatorSuccess() => const Loader(),
                ValidatorError() => const Loader(),
                ValidatorServerError() => const Loader(),
                ValidatorInitial() => CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: screenSize.width * .8,
                                      child: TextFormField(
                                        controller: emailEC,
                                        validator: Validatorless.multiple([
                                          Validatorless.required(
                                              'Email obrigatório'),
                                          Validatorless.email(
                                              'Email inválido'),
                                        ]),
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          filled: true,
                                          fillColor:
                                              Colors.black.withOpacity(0.1),
                                          prefixIcon: const Icon(Icons.email),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    SizedBox(
                                      width: screenSize.width * .8,
                                      child: BlocConsumer<PasswordCubit,
                                          PasswordState>(
                                        bloc: passwordCubit,
                                        listener: (context, state) {
                                          if (state is PasswordError) {
                                            showTopSnackBar(
                                              snackBarPosition:
                                                  SnackBarPosition.bottom,
                                              Overlay.of(context),
                                              const CustomSnackBar.error(
                                                  message:
                                                      'Erro ao gerar senha'),
                                            );
                                          }
                                          if (state is PasswordSuccess) {
                                            passwordEC.text = state.password;
                                            obscureText = false;
                                            showTopSnackBar(
                                              snackBarPosition:
                                                  SnackBarPosition.bottom,
                                              Overlay.of(context),
                                              const CustomSnackBar.success(
                                                  message: 'Senha gerada'),
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          return Skeletonizer(
                                            enabled: state is PasswordLoading,
                                            //enabled: state is PasswordLoading,
                                            child: Skeleton.unite(
                                              child: TextFormField(
                                                controller: passwordEC,
                                                validator:
                                                    Validatorless.multiple([
                                                  Validatorless.required(
                                                      'Senha obrigatória'),
                                                  Validatorless.min(8,
                                                      'Senha menor que 8 caracteres'),
                                                ]),
                                                obscureText: obscureText,
                                                decoration: InputDecoration(
                                                  hintText: 'Senha',
                                                  filled: true,
                                                  fillColor: Colors.black
                                                      .withOpacity(0.1),
                                                  prefixIcon:
                                                      const Icon(Icons.key),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        obscureText =
                                                            !obscureText;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      obscureText
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * .8,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Sugestão de senha',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: TextStyles
                                                    .instance.secondary,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                passwordCubit.getPassword();
                                              },
                                              child: Text(
                                                'Clique aqui',
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 16,
                                                  fontFamily: TextStyles
                                                      .instance.secondary,
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    const SizedBox(height: 70),
                                    Container(
                                      width: screenSize.width * .8,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.gradient,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            validatorCubit.validator(
                                                password: passwordEC.text);
                                          }
                                        },
                                        child: Text(
                                          'Entrar',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontFamily:
                                                TextStyles.instance.secondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '© Desafio model view - 2024',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: TextStyles.instance.secondary,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              };
            }));
  }
}
