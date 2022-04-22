import 'package:flutter/material.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: AppSrings.appTitle,
      home: SightListScreen(),
    );
  }
}