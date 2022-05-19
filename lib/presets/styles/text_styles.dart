import 'package:flutter/material.dart';

/// Стили текста приложения
class AppTextStyles {
  static const largeTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.125,
  );

  static const title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.208,
  );

  static const subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.333,
  );

  static const text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
  );

  static const smallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.285,
  );

  static const small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.285,
  );

  static const superSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.333,
  );

  static const button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.285,
    letterSpacing: 0.03,
    color: Colors.white,
  );

  AppTextStyles._();
}
