import 'package:flutter/material.dart';


class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get primary => 'Montserrat';
  String get secondary => 'Quicksand';
}

extension AppTextStyles on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
