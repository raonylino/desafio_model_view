import 'package:desafio_model_view/src/core/constants/app_colors.dart';
import 'package:desafio_model_view/src/core/constants/app_text_styles.dart';
import 'package:desafio_model_view/src/core/shared/widgets/loader.dart';
import 'package:desafio_model_view/src/core/shared/widgets/panel.dart';
import 'package:desafio_model_view/src/core/shared/widgets/widget_extension.dart';
import 'package:desafio_model_view/src/features/validator/presenter/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  final String? initialMessage;
  const HomePage({super.key, this.initialMessage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    cubit = HomeCubit();
    cubit.init(widget.initialMessage);
    super.initState();
  }

  late HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/background.png'),
        backgroundColor: Colors.black,
        toolbarHeight: 150,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        builder: (context, state) {
          return state is HomeInitial
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: screenSize.height * 0.35,
                        child: Lottie.asset(
                          'assets/animations/security.json',
                          fit: BoxFit.cover,
                          repeat: true,
                        ),
                      ),
                    ),
                    Text(
                      'Desafio Model View',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: TextStyles.instance.primary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        bottom: 30,
                      ),
                      child: Text(
                        'Segurança na ponta do dedo',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: TextStyles.instance.secondary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.25),
                      child: Panel(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.black.withAlpha(150),
                              maxRadius: 30,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                maxRadius: 28,
                                child: CircleAvatar(
                                  backgroundColor: cubit.initialMessage != null
                                      ? Colors.green
                                      : Colors.red,
                                  maxRadius: 26,
                                  child: Icon(
                                    cubit.initialMessage != null
                                        ? Icons.check
                                        : Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                                .animate(
                                    onPlay: (controller) => controller.repeat())
                                .shake(
                                    hz: 3,
                                    duration: 2.seconds,
                                    curve: Curves.linearToEaseOut,
                                    delay: 1.seconds,
                                    rotation: 0.3)
                                .animate()
                                .scaleXY(
                                  curve: Curves.linearToEaseOut,
                                  duration: 2.seconds,
                                  begin: 0,
                                  end: 1,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Resposta do serivdor:',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: TextStyles.instance.secondary,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.message ?? 'Sem resposta',
                              style: TextStyle(
                                color: cubit.initialMessage != null
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: TextStyles.instance.secondary,
                              ),
                            ),
                          ),
                        ]),
                      ).animate().slideY(
                            duration: 2.seconds,
                            curve: Curves.linearToEaseOut,
                            begin: 2,
                            end: 0,
                          ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: screenSize.width * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sair',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : const Loader();
        },
      ),
    );
  }
}
