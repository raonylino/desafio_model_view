import 'dart:developer';

import 'package:desafio_model_view/src/features/validator/presenter/cubit/validator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ValidatorPage extends StatelessWidget {
  const ValidatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ValidatorCubit>();

    final passwordEC = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<ValidatorCubit, ValidatorState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is ValidatorError) {
            showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                    message: '${state.message}\n${state.errors}}'));
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
            ValidatorLoading() => const CircularProgressIndicator(),
            ValidatorSuccess() => const CircularProgressIndicator(),
            ValidatorError() => const CircularProgressIndicator(),
            ValidatorServerError() => const CircularProgressIndicator(),
            ValidatorInitial() => Column(
                children: [
                  const Text('Senha:'),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      key: formKey,
                      controller: passwordEC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        cubit.validator(password: passwordEC.text);
                      },
                      child: const Text('Entrar'))
                ],
              ),
          };

          /* return  */
        },
      ),
    );
  }
}
