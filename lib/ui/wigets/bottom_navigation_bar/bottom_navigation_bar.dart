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
          icon: SvgPicture.asset(
            AppIcons.list,
            colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AppIcons.listFull,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.map,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AppIcons.mapFull,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.heartDark,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AppIcons.heartFull,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.settings,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AppIcons.settingsFull,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
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
          Navigator.of(context).pushNamed(AppStrings.sightListScreen);
        } else if (index == 1) {
          Navigator.of(context).pushNamed(AppStrings.mapScreen);
        } else if (index == 2) {
          Navigator.of(context).pushNamed(AppStrings.visitedScreen);
        } else if (index == 3) {
          Navigator.of(context).pushNamed(AppStrings.settingsScreen);
        }
      },
    );
  }
}
