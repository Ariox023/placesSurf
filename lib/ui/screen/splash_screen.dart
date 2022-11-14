import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/colors/gradients.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future isInitialized;

  @override
  void initState() {
    _navigateToNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.addSplashGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          AppIcons.iconSpalsh,
          color: AppColors.white,
        ),
      ),
    );
  }

  void _navigateToNext() {
    Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushNamed(AppStrings.sightListScreen),
    );
  }
}
