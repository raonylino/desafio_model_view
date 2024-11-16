import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color.fromRGBO(0, 120, 255, 1);
  static const secondaryColor = Color.fromRGBO(0, 193, 252, 1);
  static const accentColor = Color.fromRGBO(2, 239, 211, 1);
  static const errorColor = Color.fromRGBO(255, 0, 0, 1);
  static const successColor = Color.fromRGBO(0, 255, 0, 1);
  static const warningColor = Color.fromRGBO(255, 255, 0, 1);
  static const infoColor = Color.fromRGBO(0, 255, 255, 1);
  static const black = Color.fromRGBO(0, 0, 0, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const grey = Color.fromRGBO(189, 195, 199, 1);

  static const gradient = LinearGradient(
    colors: [
      Color.fromRGBO(0, 120, 255, 1),
      Color.fromRGBO(0, 193, 252, 1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const gradientGrey = LinearGradient(
    colors: [
      Color.fromRGBO(189, 195, 199, 1),
      Color.fromRGBO(44, 62, 80, 1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const backgroundColor = Color.fromRGBO(231, 231, 231, 1);
  static const backgroundColorOpacity = Color.fromRGBO(231, 231, 231, .5);
}
