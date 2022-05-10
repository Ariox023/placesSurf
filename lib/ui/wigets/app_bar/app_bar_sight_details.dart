import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/colors/gradients.dart';
import 'package:places/ui/wigets/containers/conainer_for_image_network.dart';
import 'package:places/ui/wigets/containers/container_with_opacity_for_image.dart';

class AppBarDetails extends StatelessWidget implements PreferredSizeWidget {
  final Sight card;

  @override
  Size get preferredSize => const Size.fromHeight(360);

  const AppBarDetails({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          CarouselSlider(
            items: card.url
                .map(
                  (e) => Stack(
                    children: [
                      ImageNetworkWiget(
                        url: e,
                        gradient: AppGradients.whiteImageGradient,
                      ),
                      const ContainerWithOpacityForImages(),
                    ],
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 384,
              padEnds: false,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
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
