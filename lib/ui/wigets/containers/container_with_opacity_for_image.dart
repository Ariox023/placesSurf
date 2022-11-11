import 'package:flutter/material.dart';
import 'package:places/presets/colors/gradients.dart';

class ContainerWithOpacityForImages extends StatelessWidget {
  final double opacity;
  final double height;

  const ContainerWithOpacityForImages({
    this.opacity = 0.4,
    this.height = 360,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.whiteImageGradient,
        ),
      ),
    );
  }
}
