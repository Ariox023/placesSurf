import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/colors/gradients.dart';
import 'package:places/presets/icons/icons.dart';
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
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/details', arguments: cardSign);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin:
            EdgeInsets.symmetric(horizontal: 16, vertical: model == 1 ? 5 : 16),
        clipBehavior: Clip.hardEdge,
        child: Column(
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
                  style: AppTextStyles.small.copyWith(
                    color: AppColors.inactiveBlack,
                  ),
                ),
              ),
            const SizedBox(
              height: 16,
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
        if (model == 1)
          Positioned(
            top: 16,
            right: 16,
            height: 24,
            width: 24,
            child: SecondIconButtonWiget(
              cardSign: cardSign,
            ),
          )
        else
          Positioned(
            top: 16,
            right: 16,
            height: 24,
            width: 24,
            child: SecondIconButtonWiget2(
              cardSign: cardSign,
              model: model,
            ),
          ),
        if (model != 1)
          Positioned(
            top: 16,
            right: 56,
            height: 24,
            width: 24,
            child: FirstIconButtonWiget(
              cardSign: cardSign,
              model: model,
            ),
          ),
      ],
    );
  }
}

class SecondIconButtonWiget extends StatefulWidget {
  final Sight cardSign;
  const SecondIconButtonWiget({
    Key? key,
    required this.cardSign,
  }) : super(key: key);

  @override
  State<SecondIconButtonWiget> createState() => _SecondIconButtonWigetState();
}

class _SecondIconButtonWigetState extends State<SecondIconButtonWiget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        AppIcons.heart,
        color: widget.cardSign.liked ? Colors.blue : AppColors.white,
      ),
      padding: EdgeInsets.zero,
      onPressed: () {
        widget.cardSign.liked = !widget.cardSign.liked;
        Hive.box<Sight>('box_for_Sights')
            .put(widget.cardSign.name, widget.cardSign);
        setState(() {});
      },
    );
  }
}

class SecondIconButtonWiget2 extends StatefulWidget {
  final Sight cardSign;
  final int model;
  const SecondIconButtonWiget2({
    Key? key,
    required this.cardSign,
    required this.model,
  }) : super(key: key);

  @override
  State<SecondIconButtonWiget2> createState() => _SecondIconButtonWigetState2();
}

class _SecondIconButtonWigetState2 extends State<SecondIconButtonWiget2> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.clear_rounded),
      color: AppColors.white,
      padding: EdgeInsets.zero,
      onPressed: () {
        if (widget.model == 2) {
          widget.cardSign.liked = false;
        } else {
          widget.cardSign.visited = false;
          widget.cardSign.timeVisit = '';
        }
        Hive.box<Sight>('box_for_Sights')
            .put(widget.cardSign.name, widget.cardSign);
        setState(() {});
      },
    );
  }
}

class FirstIconButtonWiget extends StatefulWidget {
  final Sight cardSign;
  final int model;
  const FirstIconButtonWiget({
    Key? key,
    required this.cardSign,
    this.model = 1,
  }) : super(key: key);

  @override
  State<FirstIconButtonWiget> createState() => _FirstIconButtonWigetState();
}

class _FirstIconButtonWigetState extends State<FirstIconButtonWiget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        widget.model == 2 ? AppIcons.calendarWhite : AppIcons.share,
        color: AppColors.white,
      ),
      padding: EdgeInsets.zero,
      onPressed: () {
        widget.cardSign.liked = !widget.cardSign.liked;
        setState(() {});
      },
    );
  }
}
