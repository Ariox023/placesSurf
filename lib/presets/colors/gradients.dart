import 'package:flutter/material.dart';

/// Градиенты приложения
class AppGradients {
  static const Gradient whiteImageGradient = LinearGradient(
    colors: [
      Color.fromRGBO(37, 40, 73, 1),
      Color.fromRGBO(59, 62, 91, 0.08),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient defaultGradient = LinearGradient(colors: []);

  AppGradients._();
}
