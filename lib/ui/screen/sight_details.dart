import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';

class SightDetails extends StatelessWidget {
  static const routeName = '/details';

  const SightDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = ModalRoute.of(context)!.settings.arguments as Sight;

    return Scaffold(
      appBar: _AppBar(card: card),
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

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final Sight card;

  @override
  Size get preferredSize => const Size.fromHeight(360);

  const _AppBar({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 384,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(card.url),
            ),
          ),
          Positioned(
            top: 36,
            left: 16,
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              clipBehavior: Clip.hardEdge,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 13,
                  color: AppColors.blackDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
