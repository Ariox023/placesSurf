import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  const BottomBar({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).iconTheme.color;

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.list, color: color),
          activeIcon: SvgPicture.asset(
            AppIcons.listFull,
            color: color,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.map, color: color),
          activeIcon: SvgPicture.asset(
            AppIcons.mapFull,
            color: color,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.heartDark, color: color),
          activeIcon: SvgPicture.asset(
            AppIcons.heartFull,
            color: color,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.settings, color: color),
          activeIcon: SvgPicture.asset(
            AppIcons.settingsFull,
            color: color,
          ),
          label: '',
        ),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushNamed(AppStrings.maingsScreen);
        } else if (index == 1) {
          Navigator.of(context)
              .pushNamed(AppStrings.visitedScreen, arguments: 1);
        } else if (index == 2) {
          Navigator.of(context).pushNamed(AppStrings.visitedScreen);
        } else if (index == 3) {
          Navigator.of(context).pushNamed(AppStrings.settingsScreen);
        }
      },
    );
  }
}
