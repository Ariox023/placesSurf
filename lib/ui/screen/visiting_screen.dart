// ignore_for_file: avoid_types_on_closure_parameters
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/wigets/app_bar/app_bar_visiting_screen.dart';
import 'package:places/ui/wigets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:places/ui/wigets/containers/empty_body';

class VisitingScreen extends StatefulWidget {
  static const routeName = '/vizited';
  const VisitingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    final sightBox = Hive.box<Sight>('box_for_Sights');

    final index = ModalRoute.of(context)?.settings.arguments ?? 0;
    final indexInt = int.parse(index.toString());

    return DefaultTabController(
      length: 2,
      initialIndex: indexInt,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const AppBarVisitingSceen(),
        body: TabBarView(
          children: [
            FirstTabBarViewWiget(sightBox: sightBox),
            SecondTabBarViewWiget(
              sightBox: sightBox,
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(
          currentIndex: indexInt == 0 ? 2 : 1,
        ),
      ),
    );
  }
}

class FirstTabBarViewWiget extends StatelessWidget {
  final Box<Sight> sightBox;
  const FirstTabBarViewWiget({
    Key? key,
    required this.sightBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sightBox.listenable(),
      builder: (BuildContext context, Box<Sight> box, _) {
        final listOfWidgets = [
          for (var item in box.values)
            if (item.liked)
              SightCard(
                cardSign: item,
                model: 2,
              ),
        ];
        if (listOfWidgets.isEmpty) {
          return const EmptyWidget(
            icon: AppIcons.card,
            str: AppStrings.scrTabBarViewLikedEmptyBody,
          );
        }

        return ListView(
          children: listOfWidgets,
        );
      },
    );
  }
}

class SecondTabBarViewWiget extends StatelessWidget {
  final Box<Sight> sightBox;
  const SecondTabBarViewWiget({
    Key? key,
    required this.sightBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      child: Container(color: Colors.red),
      valueListenable: sightBox.listenable(),
      builder: (BuildContext context, Box<Sight> box, _) {
        final listOfWigets = <SightCard>[
          for (var item in box.values)
            if (item.visited)
              SightCard(
                cardSign: item,
                model: 3,
              ),
        ];

        if (listOfWigets.isEmpty) {
          return const EmptyWidget(
            icon: AppIcons.go,
            str: AppStrings.scrTabBarViewVisitedEmptyBody,
          );
        }

        return ListView(
          children: listOfWigets,
        );
      },
    );
  }
}
