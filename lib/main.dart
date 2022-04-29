import 'package:flutter/material.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      initialRoute: '/',
      routes: {
        SightDetails.routeName: (context) => const SightDetails(),
      },
      home: const SightListScreen(),
    );
  }
}
