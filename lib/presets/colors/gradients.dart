import 'package:flutter/material.dart';
import 'package:places/presets/colors/colors.dart';

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

  static Gradient addSightGradient = const LinearGradient(
    transform: GradientRotation(272.5 - 90),
    begin: Alignment(-1.25, 0),
    end: Alignment(1.33, 0),
    colors: [
      Color.fromRGBO(255, 231, 105, 1),
      AppColors.blackGreen,
    ],
  );

  AppGradients._();
}
