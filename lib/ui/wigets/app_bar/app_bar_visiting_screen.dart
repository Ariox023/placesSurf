import 'package:flutter/material.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';

class AppBarVisitingSceen extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(116);

  const AppBarVisitingSceen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      centerTitle: true,
      elevation: 0,
      titleSpacing: 0,
      title: SizedBox(
        height: 56,
        width: double.infinity,
        child: Center(
          child: Text(
            AppStrings.scrTitleVisitingScreen,
            style: AppTextStyles.subtitle.copyWith(color: AppColors.secondary),
          ),
        ),
      ),
      bottom: const TabBarVisitedScreen(),
    );
  }
}

class TabBarVisitedScreen extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(52);

  const TabBarVisitedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: const TabBar(
          indicator: BoxDecoration(
            color: AppColors.blackDetails,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          unselectedLabelColor: AppColors.inactiveBlack,
          tabs: [
            Tab(
              child: Center(
                child: Text(AppStrings.scrTabBarViewVisitingScreen1),
              ),
              iconMargin: EdgeInsets.symmetric(horizontal: 6),
            ),
            Tab(
              child: Center(
                child: Text(AppStrings.scrTabBarViewVisitingScreen2),
              ),
              iconMargin: EdgeInsets.symmetric(horizontal: 6),
            ),
          ],
        ),
      ),
    );
  }
}
