import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';

class EmptyWidget extends StatelessWidget {
  final String icon;
  final String subtitle;
  final String str;
  const EmptyWidget({
    Key? key,
    required this.icon,
    this.subtitle = AppStrings.scrTabBarViewEmptyBody,
    required this.str,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(
            height: 24,
          ),
          Text(
            subtitle,
            style:
                AppTextStyles.subtitle.copyWith(color: AppColors.inactiveBlack),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 53),
            child: Text(
              str,
              style:
                  AppTextStyles.small.copyWith(color: AppColors.inactiveBlack),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
