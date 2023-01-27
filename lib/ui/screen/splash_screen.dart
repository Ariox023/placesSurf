// ignore_for_file: unused_element

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

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
    // _generateMassAsync();
    // _generateMass();
    // _generateMassIsolate();
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

  void myIsolate(SendPort isolateToMainStream) {
    final mainToIsolateStream = ReceivePort();
    isolateToMainStream.send(mainToIsolateStream.sendPort);

    mainToIsolateStream.listen(
      <String>(message) {
        if (message == 'Exit') {
          exit(0);
        }
        if (message == 'generate mass') {
          _generateMass();
        }
      },
    );
    // isolateToMainStream.send('done');
  }

  Future<Future> initIsolate() async {
    final Completer completer = Completer<SendPort>();
    final isolateToMainSrteam = ReceivePort();

    // ignore: cascade_invocations
    isolateToMainSrteam.listen(
      <String>(data) {
        if (data is SendPort) {
          completer.complete(data);
        }
      },
    );

    // ignore: unused_local_variable
    final myIsolateInstance =
        await Isolate.spawn(myIsolate, isolateToMainSrteam.sendPort);

    return completer.future;
  }

  void _navigateToNext() {
    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.of(context)
          .pushReplacementNamed(AppStrings.sightListScreen),
    );
  }

  Future<void> _generateMassAsync() async {
    final listOfStrins = List.generate(10000, (index) => 'abcd');

    for (var element in listOfStrins) {
      element = element.split('').reversed.join();
      // ignore: avoid_print
      print(element);
    }
  }

  void _generateMass() {
    final listOfStrins = List.generate(10000, (index) => 'abcd');

    for (var element in listOfStrins) {
      element = element.split('').reversed.join();
      // ignore: avoid_print
      print(element);
    }
  }

  Future<void> _generateMassIsolate() async {
    // ignore: unused_local_variable
    final mainToIsolateStream = await initIsolate() as SendPort
      ..send('generate mass')
      ..send('Exit');
  }
}
