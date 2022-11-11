import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';
import 'package:places/ui/wigets/app_bar/app_bar_sight_details.dart';
import 'package:places/ui/wigets/bottom_navigation_bar/bottom_navigation_bar.dart';

class SightDetails extends StatelessWidget {
  static const routeName = '/details';

  const SightDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = ModalRoute.of(context)?.settings.arguments as Sight;

    return Scaffold(
      appBar: AppBarDetails(card: card),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizeHeight24(),
              Text(
                card.name,
                style: AppTextStyles.title.copyWith(
                  color: AppColors.blackDetails,
                ),
              ),
              Row(
                children: [
                  Text(
                    card.type,
                    style: AppTextStyles.smallBold.copyWith(
                      color: AppColors.blackDetails,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    AppStrings.scrTimeDetailScreen,
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.inactiveBlack,
                    ),
                  ),
                ],
              ),
              const SizeHeight24(),
              Text(
                card.details,
                style: AppTextStyles.small.copyWith(
                  color: AppColors.blackDetails,
                ),
              ),
              const SizeHeight24(),
              InkWell(
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.greenDetails,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.goWhite,
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        AppStrings.scrButtonDetailScreen,
                        style: AppTextStyles.button,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  final hiveBox = Hive.box<Sight>('box_for_Sights');
                  final boxCard = hiveBox.get(card.name)!
                    ..liked = false
                    ..visited = true
                    ..timeVisit = 'Test';
                  hiveBox.put(card.name, boxCard);
                  Navigator.of(context)
                      .pushReplacementNamed('/vizited', arguments: 1);
                },
              ),
              const SizeHeight24(),
              const Divider(
                color: AppColors.inactiveBlack,
                height: 0.8,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  FlexsibleButtonCalendar(card: card),
                  FlexsibleButtonFavorited(card: card),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 1,
      ),
    );
  }
}

class FlexsibleButtonCalendar extends StatelessWidget {
  final Sight card;
  const FlexsibleButtonCalendar({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Container(
              height: 40,
              color: Colors.transparent,
            ),
            Positioned(
              top: 8,
              left: 16,
              child: SvgPicture.asset(AppIcons.calendar),
            ),
            Positioned(
              top: 13,
              left: 48,
              child: Text(
                AppStrings.scrMenyCalendarDetailScreen,
                style: AppTextStyles.small
                    .copyWith(color: AppColors.inactiveBlack),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlexsibleButtonFavorited extends StatelessWidget {
  final Sight card;
  const FlexsibleButtonFavorited({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {
          final sightBox = Hive.box<Sight>('box_for_Sights');
          final sightK = sightBox.get(card.name);
          sightK!.liked = true;
          sightBox.put(card.name, sightK);
        },
        child: Stack(
          children: [
            Container(
              height: 40,
              color: Colors.transparent,
            ),
            Positioned(
              top: 8,
              left: 24,
              child: SvgPicture.asset(AppIcons.heartDark),
            ),
            Positioned(
              top: 13,
              left: 56,
              child: Text(
                AppStrings.scrMenyFavoritDetailScreen,
                style:
                    AppTextStyles.small.copyWith(color: AppColors.blackDetails),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SizeHeight24 extends StatelessWidget {
  const SizeHeight24({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 24,
    );
  }
}
