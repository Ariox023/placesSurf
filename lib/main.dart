// ignore_for_file: avoid_void_async, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/ui/screen/settings.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(SightAdapter());
  await Hive.initFlutter();

  final sightBox = await Hive.openBox<Sight>('box_for_Sights');
  for (final e in mocks) {
    final card = sightBox.get(e.name);
    if (card == null) {
      await sightBox.put(
        e.name,
        Sight(
          details: e.details,
          lat: e.lat,
          lon: e.lon,
          name: e.name,
          type: e.type,
          url: e.url,
          workingHours: e.workingHours,
        ),
      );
    } else {
      card
        ..details = e.details
        ..lat = e.lat
        ..lon = e.lon
        ..type = e.type
        ..url = e.url
        ..workingHours = e.workingHours;
    }
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      initialRoute: '/',
      routes: {
        SightDetails.routeName: (context) => const SightDetails(),
        VisitingScreen.routeName: (context) => const VisitingScreen(),
        Settings.routeName: (context) => const Settings(),
      },
      home: const SightListScreen(),
    );
  }
}
