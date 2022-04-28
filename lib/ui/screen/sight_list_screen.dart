import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/mocks.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/styles/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

/// Экран 'Список интересных мест'
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: const _RichText(),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: mocks
              .map((e) => SightCard(
                    cardSign: e,
                  ))
              .toList(),
        ),
      ),
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
      textAlign: TextAlign.left,
    );
  }
}

/// RichText
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
