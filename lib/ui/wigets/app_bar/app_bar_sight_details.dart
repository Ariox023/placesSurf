// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/colors/gradients.dart';
import 'package:places/ui/wigets/containers/conainer_for_image_network.dart';
import 'package:places/ui/wigets/containers/container_with_opacity_for_image.dart';

class AppBarDetails extends StatefulWidget implements PreferredSizeWidget {
  final Sight card;

  const AppBarDetails({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  State<AppBarDetails> createState() => _AppBarDetailsState();

  // ignore: member-ordering-extended
  @override
  Size get preferredSize => const Size.fromHeight(250);
}

class _AppBarDetailsState extends State<AppBarDetails> {
  final controller = PageController(viewportFraction: 0.9);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          // CarouselSlider.builder(
          //   itemCount: card.url.length,
          //   itemBuilder: (context, index, realIndex) {
          //     return Stack(
          //       children: [
          //         ImageNetworkWiget(
          //           url: card.url[index],
          //           gradient: AppGradients.whiteImageGradient,
          //         ),
          //         const ContainerWithOpacityForImages(),
          //       ],
          //     );
          //   },
          // items: card.url
          //     .map(
          //       (e) => Stack(
          //         children: [
          //           ImageNetworkWiget(
          //             url: e,
          //             gradient: AppGradients.whiteImageGradient,
          //           ),
          //           const ContainerWithOpacityForImages(),
          //         ],
          //       ),
          //     )
          //     .toList(),
          //   options: CarouselOptions(
          //     height: 384,
          //     padEnds: false,
          //     autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          //   ),
          // ),
          PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ImageNetworkWiget(
                    url: widget.card.url[index % (widget.card.url.length)],
                    gradient: AppGradients.whiteImageGradient,
                  ),
                  const ContainerWithOpacityForImages(),
                ],
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index % (widget.card.url.length);
              });
            },
            itemCount: 10000,
            padEnds: false,
            controller: controller,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.card.url.length, (i) {
                return Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width /
                      widget.card.url.length,
                  height: 10,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: _currentPageIndex == i
                        ? AppColors.whiteMain
                        : Colors.transparent,
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: 36,
            left: 16,
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              clipBehavior: Clip.hardEdge,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 13,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
