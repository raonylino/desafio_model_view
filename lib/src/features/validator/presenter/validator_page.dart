import 'package:desafio_model_view/src/constants/app_colors.dart';
import 'package:desafio_model_view/src/constants/app_text_styles.dart';
import 'package:desafio_model_view/src/features/validator/presenter/cubit/validator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final cubit = context.read<ValidatorCubit>();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: screenSize.width,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.contain,
                      ),
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.normal,
                          color: Colors.black,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(6, 6),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenSize.width,
                    padding: const EdgeInsets.all(20),
                    child: BlocConsumer<ValidatorCubit, ValidatorState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is ValidatorError) {
                          showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                  message:
                                      '${state.message}\n${state.errors}}'));
                        }

                        if (state is ValidatorServerError) {
                          showTopSnackBar(Overlay.of(context),
                              CustomSnackBar.error(message: state.message));
                        }

                        if (state is ValidatorSuccess) {
                          /* Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ValidatorPage())); */
                          //TODO Trocar pela tela de sucesso

                          showTopSnackBar(Overlay.of(context),
                              CustomSnackBar.success(message: state.message));
                        }
                      },
                      builder: (context, state) {
                        return switch (state) {
                          ValidatorLoading() =>
                            const Center(child: CircularProgressIndicator()),
                          ValidatorSuccess() =>
                            const Center(child: CircularProgressIndicator()),
                          ValidatorError() =>
                            const Center(child: CircularProgressIndicator()),
                          ValidatorServerError() =>
                            const Center(child: CircularProgressIndicator()),
                          ValidatorInitial() => Column(
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                SizedBox(
                                  width: screenSize.width * .8,
                                  child: TextFormField(
                                    controller: emailEC,
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'Email obrigatório'),
                                      Validatorless.email('Email inválido'),
                                    ]),
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.1),
                                      prefixIcon: const Icon(Icons.email),
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
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: screenSize.width * .8,
                                  child: TextFormField(
                                    controller: passwordEC,
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'Senha obrigatória'),
                                      Validatorless.min(
                                          8, 'Senha menor que 8 caracteres'),
                                    ]),
                                    obscureText: obscureText,
                                    decoration: InputDecoration(
                                      hintText: 'Senha',
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.1),
                                      prefixIcon: const Icon(Icons.key),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        },
                                        icon: Icon(
                                          obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
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
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * .8,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Sugestão de senha',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily:
                                                TextStyles.instance.secondary,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              passwordEC.text = cubit
                                                  .getPassword()
                                                  .toString();
                                              obscureText = false;
                                            });
                                          },
                                          child: Text(
                                            'Clique aqui',
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 16,
                                              fontFamily:
                                                  TextStyles.instance.secondary,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 70,
                                ),
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
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.validator(
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
                        };
                      },
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      height: 10,
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
    );
  }
}
