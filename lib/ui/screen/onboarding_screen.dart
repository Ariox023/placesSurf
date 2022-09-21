// ignore_for_file: use_colored_box, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';
import 'package:places/ui/wigets/bottom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          if (_currentPageIndex != 2)
            TextButton(
              onPressed: () {
                setState(() {
                  _currentPageIndex++;
                  _controller.animateToPage(
                    _currentPageIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                  );
                });
              },
              child: Text(
                AppStrings.buttonSkip,
                style: theme.textTheme.bodySmall,
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              FirstTabBarViewWiget(),
              SecondTabBarViewWiget(),
              ThirdTabBarViewWiget(),
            ],
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPageIndex == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: _currentPageIndex == i
                        ? AppColors.greenDetails
                        : AppColors.inactiveBlack,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _currentPageIndex == 2
          ? BottomButton(
              text: AppStrings.scrOnboardingScreenThirdPageButton,
              style: AppTextStyles.button,
              color: theme.buttonColor,
              func: () => setState(() {
                _currentPageIndex = 0;
                _controller.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              }),
            )
          : null,
    );
  }
}

class FirstTabBarViewWiget extends StatelessWidget {
  const FirstTabBarViewWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcons.iconTutorialFrame1,
          color: theme.textTheme.labelMedium?.color,
        ),
        const SizedBox(
          height: 42,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width - 104),
          child: Text(
            AppStrings.scrOnboardingScreenFirstPage1,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width - 104),
          child: Text(
            AppStrings.scrOnboardingScreenFirstPage2,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: AppColors.secondary2),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class SecondTabBarViewWiget extends StatelessWidget {
  const SecondTabBarViewWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcons.iconTutorialFrame2,
          color: theme.textTheme.labelMedium?.color,
        ),
        const SizedBox(
          height: 42,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width - 104),
          child: Text(
            AppStrings.scrOnboardingScreenSecondPage1,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width - 104),
          child: Text(
            AppStrings.scrOnboardingScreenSecondPage2,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: AppColors.secondary2),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class ThirdTabBarViewWiget extends StatelessWidget {
  const ThirdTabBarViewWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcons.iconTutorialFrame3,
          color: theme.textTheme.labelMedium?.color,
        ),
        const SizedBox(
          height: 42,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width - 104),
          child: Text(
            AppStrings.scrOnboardingScreenThirdPage1,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width - 104),
          child: Text(
            AppStrings.scrOnboardingScreenThirdPage2,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: AppColors.secondary2),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
