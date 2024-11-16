import 'package:desafio_model_view/src/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: AppColors.primaryColor,
          size: 100,
        ),
      ),
    );
  }
}
