// ignore_for_file: avoid_types_on_closure_parameters, cascade_invocations
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/wigets/app_bar/app_bar_visiting_screen.dart';
import 'package:places/ui/wigets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:places/ui/wigets/containers/empty_body.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    final sightBox = Hive.box<Sight>(AppStrings.boxSights);

    final index = ModalRoute.of(context)?.settings.arguments ?? 0;
    final indexInt = int.parse(index.toString());

    return DefaultTabController(
      length: 2,
      initialIndex: indexInt,
      child: Scaffold(
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
              Dismissible(
                direction: DismissDirection.endToStart,
                dismissThresholds: const {
                  DismissDirection.endToStart: 0.2,
                },
                dragStartBehavior: DragStartBehavior.down,
                key: Key(item.name),
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete_forever_outlined,
                    size: 32,
                  ),
                ),
                onDismissed: (dir) {
                  item.liked = false;
                  item.timeVisit = '';
                  item.save();
                },
                child: SightCard(
                  cardSign: item,
                  model: 2,
                  key: ValueKey(item.name),
                ),
              ),
        ];
        if (listOfWidgets.isEmpty) {
          return const EmptyWidget(
            icon: AppIcons.card,
            str: AppStrings.scrTabBarViewLikedEmptyBody,
          );
        }

        return ListView(
          key: const PageStorageKey<String>('List liked cards'),
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
      valueListenable: sightBox.listenable(),
      builder: (BuildContext context, Box<Sight> box, _) {
        final listOfWigets = <SightCard>[
          for (var item in box.values)
            if (item.visited)
              SightCard(
                cardSign: item,
                model: 3,
                key: ValueKey(item.name),
              ),
        ];

        if (listOfWigets.isEmpty) {
          return const EmptyWidget(
            icon: AppIcons.go,
            str: AppStrings.scrTabBarViewVisitedEmptyBody,
          );
        }

        return ListView(
          key: const PageStorageKey<String>('List visited cards'),
          children: listOfWigets,
        );
      },
    );
  }
}
