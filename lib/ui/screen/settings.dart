// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/ui/wigets/bottom_navigation_bar/bottom_navigation_bar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static const menyItemsLang = {
    AppStrings.boxSettingsLangRu: AppStrings.scrFirstSettingsScreenLanRu,
    AppStrings.boxSettingsLangEn: AppStrings.scrFirstSettingsScreenLanEn,
  };

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box<String>(AppStrings.boxSettings);
    var lang = settingsBox.get(AppStrings.boxSettingsLang);
    final thema = settingsBox.get(AppStrings.boxSettingsTheme);
    var darkThema = thema == AppStrings.boxSettingsThemeDark;
    final themeCont = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.scrSettingsScreen),
        titleTextStyle: themeCont.textTheme.titleSmall,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: themeCont.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              AppStrings.scrFirstSettingsScreenLan,
              style: themeCont.textTheme.labelMedium,
            ),
            trailing: DropdownButton<String>(
              value: lang,
              items: menyItemsLang.entries
                  .map((e) => DropdownMenuItem(
                        child: Text(
                          e.value,
                          style: themeCont.textTheme.labelMedium,
                        ),
                        value: e.key,
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  lang = newValue;
                  settingsBox.put(AppStrings.boxSettingsLang, newValue!);
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              AppStrings.scrFirstSettingsScreenThema,
              style: themeCont.textTheme.labelMedium,
            ),
            trailing: CupertinoSwitch(
              value: darkThema,
              onChanged: (newValue) {
                setState(() {
                  darkThema = newValue;
                  settingsBox.put(
                    AppStrings.boxSettingsTheme,
                    newValue
                        ? AppStrings.boxSettingsThemeDark
                        : AppStrings.boxSettingsThemeLight,
                  );
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              AppStrings.scrFirstSettingsScreenInfo,
              style: themeCont.textTheme.labelMedium,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.info_outline,
                color: themeCont.buttonColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppStrings.tutorialScreen);
                // Navigator.of(context).pushNamed('test');
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 3,
      ),
    );
  }
}
