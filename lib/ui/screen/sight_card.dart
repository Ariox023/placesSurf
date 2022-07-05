import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/colors/gradients.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';
import 'package:places/ui/wigets/containers/conainer_for_image_network.dart';
import 'package:places/ui/wigets/containers/container_with_opacity_for_image.dart';

class SightCard extends StatelessWidget {
  final Sight cardSign;
  final int model;
  const SightCard({Key? key, required this.cardSign, this.model = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: model == 1 ? 5 : 16,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageCardWiget(cardSign: cardSign, model: model),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    cardSign.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppTextStyles.text,
                  ),
                ),
                if (model == 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      cardSign.details,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.small,
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 28,
                      child: Text(
                        cardSign.timeVisit.isEmpty ? '' : cardSign.timeVisit,
                        style: AppTextStyles.small.copyWith(
                          color: model == 2
                              ? AppColors.whiteGreen
                              : AppColors.inactiveBlack,
                        ),
                      ),
                    ),
                  ),
                if (model != 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      cardSign.workingHours,
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  splashColor: theme.splashColor,
                  highlightColor: Colors.transparent,
                  radius: 100,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppStrings.detailsScreen,
                      arguments: cardSign,
                    );
                  },
                ),
              ),
            ),
            if (model == 1)
              Positioned(
                top: 4,
                right: 4,
                child: SecondIconButtonWigetLike(
                  cardSign: cardSign,
                ),
              )
            else
              Positioned(
                top: 4,
                right: 4,
                child: SecondIconButtonWigetRemove(
                  cardSign: cardSign,
                  model: model,
                ),
              ),
            if (model != 1)
              if (model == 2)
                Positioned(
                  top: 4,
                  right: 50,
                  child: FirstIconButtonWigetCalendar(
                    cardSign: cardSign,
                    model: model,
                  ),
                )
              else
                Positioned(
                  top: 4,
                  right: 50,
                  child: FirstIconButtonWigetShare(
                    cardSign: cardSign,
                    model: model,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class ImageCardWiget extends StatelessWidget {
  final Sight cardSign;
  final int model;

  const ImageCardWiget({
    Key? key,
    required this.cardSign,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageNetworkWiget(
          url: cardSign.url[0],
          height: 96,
          fit: BoxFit.cover,
          gradient: AppGradients.whiteImageGradient,
        ),
        const ContainerWithOpacityForImages(
          height: 96,
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            cardSign.type,
            style: AppTextStyles.button,
          ),
        ),
      ],
    );
  }
}

class SecondIconButtonWigetLike extends StatefulWidget {
  final Sight cardSign;
  const SecondIconButtonWigetLike({
    Key? key,
    required this.cardSign,
  }) : super(key: key);

  @override
  State<SecondIconButtonWigetLike> createState() =>
      _SecondIconButtonWigetLikeState();
}

class _SecondIconButtonWigetLikeState extends State<SecondIconButtonWigetLike> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        type: MaterialType.transparency,
        child: IconButton(
          highlightColor: Colors.transparent,
          icon: SvgPicture.asset(
            widget.cardSign.liked ? AppIcons.heartFull : AppIcons.heart,
            color: AppColors.white,
          ),
          padding: EdgeInsets.zero,
          onPressed: () {
            widget.cardSign.liked = !widget.cardSign.liked;
            widget.cardSign.timeVisit = '';
            Hive.box<Sight>(AppStrings.boxSights)
                .put(widget.cardSign.name, widget.cardSign);
            setState(() {});
          },
        ),
      ),
    );
  }
}

class SecondIconButtonWigetRemove extends StatefulWidget {
  final Sight cardSign;
  final int model;
  const SecondIconButtonWigetRemove({
    Key? key,
    required this.cardSign,
    required this.model,
  }) : super(key: key);

  @override
  State<SecondIconButtonWigetRemove> createState() =>
      _SecondIconButtonWigetRemoveState();
}

class _SecondIconButtonWigetRemoveState
    extends State<SecondIconButtonWigetRemove> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        type: MaterialType.transparency,
        child: IconButton(
          icon: const Icon(Icons.clear_rounded),
          color: AppColors.white,
          highlightColor: Colors.transparent,
          padding: EdgeInsets.zero,
          onPressed: () {
            if (widget.model == 2) {
              widget.cardSign.liked = false;
            } else {
              widget.cardSign.visited = false;
            }
            widget.cardSign.timeVisit = '';
            Hive.box<Sight>(AppStrings.boxSights)
                .put(widget.cardSign.name, widget.cardSign);
            setState(() {});
          },
        ),
      ),
    );
  }
}

class FirstIconButtonWigetCalendar extends StatefulWidget {
  final Sight cardSign;
  final int model;
  const FirstIconButtonWigetCalendar({
    Key? key,
    required this.cardSign,
    this.model = 1,
  }) : super(key: key);

  @override
  State<FirstIconButtonWigetCalendar> createState() =>
      _FirstIconButtonWigetCalendarState();
}

class _FirstIconButtonWigetCalendarState
    extends State<FirstIconButtonWigetCalendar> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        type: MaterialType.transparency,
        child: IconButton(
          highlightColor: Colors.transparent,
          icon: SvgPicture.asset(
            AppIcons.calendarWhite,
            color: AppColors.white,
          ),
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(
              () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 10),
                ).then(
                  (value) {
                    if (value != null) {
                      // ignore: cascade_invocations
                      final box = Hive.box<Sight>(AppStrings.boxSights);
                      final card = box.get(widget.cardSign.name);
                      card!.timeVisit =
                          'Запланировано на: ${value.toLocal().day} ${DateFormat.MMM().format(value)} ${value.toLocal().year}';
                      widget.cardSign.timeVisit = card.timeVisit;
                      box.put(card.name, card);
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class FirstIconButtonWigetShare extends StatefulWidget {
  final Sight cardSign;
  final int model;
  const FirstIconButtonWigetShare({
    Key? key,
    required this.cardSign,
    this.model = 1,
  }) : super(key: key);

  @override
  State<FirstIconButtonWigetShare> createState() =>
      _FirstIconButtonWigetShareState();
}

class _FirstIconButtonWigetShareState extends State<FirstIconButtonWigetShare> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        type: MaterialType.transparency,
        child: IconButton(
          highlightColor: Colors.transparent,
          icon: SvgPicture.asset(
            AppIcons.share,
            color: AppColors.white,
          ),
          padding: EdgeInsets.zero,
          onPressed: () {},
        ),
      ),
    );
  }
}
