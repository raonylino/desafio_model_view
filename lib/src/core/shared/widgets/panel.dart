import 'package:desafio_model_view/src/core/constants/app_colors.dart';
import 'package:desafio_model_view/src/core/shared/widgets/shimed_box.dart';
import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget? child;
  final double? width;
  final double? height;
  final double? radius;
  final bool withShadow;
  final bool isLoading;
  final Border? border;
  final Color? color;
  final Function()? onTap;
  final Function()? onLongPress;
  final bool? clickable;

  const Panel({
    super.key,
    this.padding = const EdgeInsets.all(20),
    this.child,
    this.withShadow = true,
    this.isLoading = false,
    this.width,
    this.height,
    this.radius,
    this.border,
    this.onTap,
    this.onLongPress,
    this.clickable,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmedBox(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
      );
    }

    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        border: border,
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
        borderRadius: BorderRadius.circular(radius ?? 15),
      ),
      child: Material(
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(radius ?? 15),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          splashColor: Colors.transparent,
          splashFactory: InkSparkle.splashFactory,
          overlayColor: WidgetStateProperty.all<Color>(
            AppColors.primaryColor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(radius ?? 15),
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
