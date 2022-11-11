// ignore_for_file: avoid_types_on_closure_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/styles/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/wigets/bottom_navigation_bar/bottom_navigation_bar.dart';

/// Экран 'Список интересных мест'
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    final sightBox = Hive.box<Sight>('box_for_Sights');

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 152,
        centerTitle: false,
        titleSpacing: 16,
        elevation: 0,
        titleTextStyle: AppTextStyles.largeTitle.copyWith(
          color: AppColors.secondary,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        title: const _Text(),
      ),
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder(
        valueListenable: sightBox.listenable(),
        builder: (BuildContext context, Box<Sight> box, _) {
          return ListView(
            children: [
              for (var item in box.values)
                SightCard(
                  cardSign: item,
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

/// Text
// ignore: unused_element
class _Text extends StatelessWidget {
  const _Text({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      'Список\nинтересных мест',
      style: AppBarTheme.of(context).titleTextStyle,
      textAlign: TextAlign.start,
    );
  }
}

/// RichText
// ignore: unused_element
class _RichText extends StatelessWidget {
  const _RichText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'С',
        style: AppTextStyles.largeTitle.copyWith(
          color: AppColors.whiteGreen,
        ),
        children: const [
          TextSpan(
            text: 'писок\n',
            style: TextStyle(color: AppColors.secondary),
          ),
          TextSpan(
            text: 'и',
            style: TextStyle(color: AppColors.whiteYellow),
          ),
          TextSpan(
            text: 'нтересных мест',
            style: TextStyle(color: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}
