import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';
import 'package:places/ui/wigets/app_bar/app_bar_sight_details.dart';

class SightDetails extends StatelessWidget {
  static const routeName = '/details';

  const SightDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = ModalRoute.of(context)!.settings.arguments as Sight;

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
              Container(
                height: 48,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.greenDetails,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage('res/icons/GO.png'),
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      AppStrings.scrButtonDetailScreen,
                      style: AppTextStyles.button,
                    ),
                  ],
                ),
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
                children: const [
                  FlexsibleButtonCalendar(),
                  FlexsibleButtonFavorited(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlexsibleButtonCalendar extends StatelessWidget {
  const FlexsibleButtonCalendar({
    Key? key,
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
            const Positioned(
              top: 10.5,
              left: 17,
              child: Icon(
                Icons.calendar_month,
                size: 22,
                color: AppColors.inactiveBlack,
              ),
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
  const FlexsibleButtonFavorited({
    Key? key,
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
            const Positioned(
              top: 11,
              left: 26,
              child: Icon(
                Icons.favorite_outline_sharp,
                size: 22,
                color: AppColors.blackDetails,
              ),
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
