import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/colors/gradients.dart';

class ImageNetworkWiget extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final double strokeWidth;
  final BoxFit fit;
  final Gradient gradient;
  final BlendMode colorBlendMode;

  const ImageNetworkWiget({
    required this.url,
    this.height = 384,
    this.width = double.infinity,
    this.strokeWidth = 6,
    this.fit = BoxFit.fill,
    this.gradient = AppGradients.defaultGradient,
    this.colorBlendMode = BlendMode.multiply,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: gradient),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: fit,
          height: height,
          width: width,
          colorBlendMode: colorBlendMode,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: AppColors.inactiveBlack.withOpacity(1),
              strokeWidth: strokeWidth,
            ),
          ),
        ),
      ),
    );
  }
}
