import 'package:flutter/material.dart';
import 'package:places/presets/strings/app_strings.dart';

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
      centerTitle: true,
      elevation: 0,
      titleSpacing: 0,
      title: SizedBox(
        height: 56,
        width: double.infinity,
        child: Center(
          child: Text(
            AppStrings.scrTitleVisitingScreen,
            style: Theme.of(context).textTheme.titleSmall,
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
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
            ),
            tabs: const [
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
      ),
    );
  }
}
