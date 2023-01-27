import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/categories.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/categories.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/map.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/settings.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/tutorial_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

// ignore: long-method
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SightAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CategoryAdapter());
  }

  final sightBox = await Hive.openBox<Sight>(AppStrings.boxSights);
  for (final e in mocks) {
    final card = sightBox.get(e.name);
    if (card == null) {
      await sightBox.put(
        e.name,
        e,
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

  final settingsBox = await Hive.openBox<String>(AppStrings.boxSettings);
  var lang = settingsBox.get(AppStrings.boxSettingsLang);
  if (lang == null) {
    lang = AppStrings.boxSettingsLangRu;
    await settingsBox.put(AppStrings.boxSettingsLang, lang);
  }
  var nameOfTheme = settingsBox.get(AppStrings.boxSettingsTheme);
  if (nameOfTheme == null) {
    nameOfTheme = AppStrings.boxSettingsThemeLight;
    await settingsBox.put(AppStrings.boxSettingsTheme, nameOfTheme);
  }
  Intl.defaultLocale = lang;
  await initializeDateFormatting(Intl.defaultLocale);

  final listCategories =
      await Hive.openBox<Category>(AppStrings.boxFiltersListCategories);
  for (final e in categories) {
    final category = listCategories.get(e.name);
    if (category == null) {
      await listCategories.put(
        e.name,
        e,
      );
    }
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box<String>(AppStrings.boxSettings);

    return ValueListenableBuilder(
      valueListenable: settingsBox.listenable(),
      // ignore: avoid_types_on_closure_parameters
      builder: (context, Box<String> box, _) {
        Intl.defaultLocale = settingsBox.get(AppStrings.boxSettingsLang);
        initializeDateFormatting(Intl.defaultLocale);

        final nameOfTheme = box.get(AppStrings.boxSettingsTheme);
        late final ThemeMode theme;

        theme = nameOfTheme == AppStrings.boxSettingsThemeDark
            ? ThemeMode.dark
            : ThemeMode.light;

        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: theme,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          initialRoute: AppStrings.maingsScreen,
          routes: {
            AppStrings.detailsScreen: (context) => SightDetails(
                  card: mocks[0],
                ),
            AppStrings.visitedScreen: (context) => const VisitingScreen(),
            AppStrings.settingsScreen: (context) => const Settings(),
            AppStrings.filtersScreen: (context) => const FiltersScreen(),
            AppStrings.tutorialScreen: (context) => const TutorialScreen(),
            AppStrings.addSightScreen: (context) => const AddSightScreen(),
            AppStrings.categoriesScreen: (context) => const Categories(),
            AppStrings.mapScreen: (context) => const GooglMap(),
            AppStrings.onboardingScreen: (context) => const OnboardingScreen(),
            AppStrings.splashScreen: (context) => const SplashScreen(),
            AppStrings.sightListScreen: (context) => const SightListScreen(),
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}
