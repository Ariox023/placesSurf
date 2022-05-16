import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/icons/icons.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  const BottomBar({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.list),
          activeIcon: SvgPicture.asset(
            AppIcons.listFull,
            color: AppColors.whiteMain,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.map),
          activeIcon: SvgPicture.asset(
            AppIcons.mapFull,
            color: AppColors.whiteMain,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.heartDark),
          activeIcon: SvgPicture.asset(AppIcons.heartFull),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.settings),
          activeIcon: SvgPicture.asset(
            AppIcons.settingsFull,
            color: AppColors.whiteMain,
          ),
          label: '',
        ),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushReplacementNamed('/');
        } else if (index == 1) {
          Navigator.of(context).pushReplacementNamed('/vizited', arguments: 1);
        } else if (index == 2) {
          Navigator.of(context).pushReplacementNamed('/vizited');
        } else if (index == 3) {
          Navigator.of(context).pushReplacementNamed('/settings');
          // Theme.of(context).
        }
      },
    );
  }
}
