// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/styles/text_styles.dart';

// Светлая тема.

final lightTheme = ThemeData(
  primaryColor: AppColors.white,
  backgroundColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
  ),
  cardColor: AppColors.background,
  splashColor: AppColors.rippleSpalsh,
  iconTheme: const IconThemeData(color: AppColors.mainDark),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(color: AppColors.secondary),
  ),
  textTheme: TextTheme(
    titleLarge: AppTextStyles.largeTitle.copyWith(color: AppColors.secondary),
    titleMedium: AppTextStyles.title.copyWith(color: AppColors.blackDetails),
    titleSmall: AppTextStyles.subtitle.copyWith(color: AppColors.secondary),
    headlineSmall: AppTextStyles.smallBold.copyWith(color: AppColors.secondary),
    labelMedium: AppTextStyles.medium.copyWith(color: AppColors.whiteMain),
    labelSmall: AppTextStyles.small.copyWith(color: AppColors.inactiveBlack),
    bodyMedium: AppTextStyles.small.copyWith(color: AppColors.secondary),
    bodySmall: AppTextStyles.text.copyWith(color: AppColors.greenDetails),
    displayMedium: AppTextStyles.smallBold.copyWith(color: AppColors.white),
    displaySmall: AppTextStyles.subtitle.copyWith(color: AppColors.whiteMain),
    displayLarge: AppTextStyles.button.copyWith(color: AppColors.greenDetails),
  ),
  buttonColor: AppColors.whiteGreen,
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.whiteGreen,
    onPrimary: AppColors.blackDark,
    tertiaryContainer: AppColors.blackDetails,
    secondary: AppColors.white,
    background: AppColors.white,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.inactiveBlack,
  ),
  dividerTheme: const DividerThemeData(color: AppColors.inactiveBlack),
  sliderTheme:
      const SliderThemeData(trackHeight: 2, thumbColor: AppColors.white),
  switchTheme: SwitchThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    thumbColor: MaterialStateColor.resolveWith((states) => AppColors.white),
    trackColor:
        MaterialStateColor.resolveWith((states) => AppColors.inactiveBlack),
  ),
  buttonTheme: const ButtonThemeData(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
  ),
);

// Темная тема.

final darkTheme = ThemeData(
  primaryColor: AppColors.mainDark,
  backgroundColor: AppColors.mainDark,
  scaffoldBackgroundColor: AppColors.mainDark,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.mainDark,
  ),
  cardColor: AppColors.blackDark,
  splashColor: AppColors.rippleSpalsh,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.mainDark,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(color: AppColors.white),
  ),
  iconTheme: const IconThemeData(color: AppColors.white),
  textTheme: TextTheme(
    titleLarge: AppTextStyles.largeTitle.copyWith(color: AppColors.white),
    titleMedium: AppTextStyles.title.copyWith(color: AppColors.white),
    titleSmall: AppTextStyles.subtitle.copyWith(color: AppColors.white),
    headlineSmall:
        AppTextStyles.smallBold.copyWith(color: AppColors.secondary2),
    labelMedium: AppTextStyles.medium.copyWith(color: AppColors.white),
    labelSmall: AppTextStyles.small.copyWith(color: AppColors.inactiveBlack),
    bodyMedium: AppTextStyles.small.copyWith(color: AppColors.white),
    bodySmall: AppTextStyles.text.copyWith(color: AppColors.greenDetails),
    displayMedium: AppTextStyles.smallBold.copyWith(color: AppColors.white),
    displaySmall: AppTextStyles.subtitle.copyWith(color: AppColors.white),
    displayLarge: AppTextStyles.button.copyWith(color: AppColors.greenDetails),
  ),
  buttonColor: AppColors.blackGreen,
  canvasColor: AppColors.mainDark,
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.whiteGreen,
    onPrimary: AppColors.blackDark,
    tertiaryContainer: AppColors.white,
    secondary: AppColors.mainDark,
    background: AppColors.mainDark,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: AppColors.secondary,
    unselectedLabelColor: AppColors.secondary2,
  ),
  dividerTheme: const DividerThemeData(color: AppColors.secondary2),
  sliderTheme: const SliderThemeData(
    trackHeight: 2,
    thumbColor: AppColors.white,
  ),
  switchTheme: SwitchThemeData(
    materialTapTargetSize: MaterialTapTargetSize.padded,
    thumbColor: MaterialStateColor.resolveWith((states) => AppColors.white),
    trackColor:
        MaterialStateColor.resolveWith((states) => AppColors.blackGreen),
  ),
  buttonTheme: const ButtonThemeData(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
  ),
);
