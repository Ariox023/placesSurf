// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';
import 'package:places/ui/wigets/app_bar/app_bar_sight_details.dart';
import 'package:places/ui/wigets/bottom_navigation_bar/bottom_navigation_bar.dart';

class SightDetails extends StatefulWidget {
  final Sight card;
  const SightDetails({Key? key, required this.card}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  @override
  Widget build(BuildContext context) {
    // final card = ModalRoute.of(context)?.settings.arguments as Sight;
    final theme = Theme.of(context);

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   toolbarHeight: 0,
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 250,
            flexibleSpace: AppBarDetails(card: widget.card),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizeHeight24(),
                  Text(
                    widget.card.name,
                    style: theme.textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.card.type,
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        AppStrings.scrTimeDetailScreen,
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizeHeight24(),
                  Text(
                    widget.card.details,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizeHeight24(),
                  Ink(
                    decoration: BoxDecoration(
                      color: theme.buttonColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      splashColor: theme.buttonColor.withGreen(199),
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.goWhite,
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              AppStrings.scrButtonDetailScreen,
                              style: AppTextStyles.button,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        final hiveBox = Hive.box<Sight>(AppStrings.boxSights);
                        final boxCard = hiveBox.get(widget.card.name)!
                          ..liked = false
                          ..visited = true
                          ..timeVisit = 'Test';
                        hiveBox.put(widget.card.name, boxCard);
                        Navigator.of(context).pushReplacementNamed(
                          AppStrings.visitedScreen,
                          arguments: 1,
                        );
                      },
                    ),
                  ),
                  const SizeHeight24(),
                  const Divider(
                    height: 0.8,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          child: FlexsibleButtonCalendar(card: widget.card),
                          onTap: () {
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
                                      widget.card.liked = true;
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then(
                                        (time) {
                                          if (time != null) {
                                            widget.card.timeVisit =
                                                'Запланировано на: ${value.toLocal().day} ${DateFormat.MMM().format(value)} ${value.toLocal().year} ${time.format(context)}';
                                          } else {
                                            widget.card.timeVisit =
                                                'Запланировано на: ${value.toLocal().day} ${DateFormat.MMM().format(value)} ${value.toLocal().year}';
                                          }
                                        },
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Flexible(
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          onTap: () {
                            widget.card.liked = true;
                          },
                          child: FlexsibleButtonFavorited(card: widget.card),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 1,
      ),
    );
  }
}

class FlexsibleButtonCalendar extends StatelessWidget {
  final Sight card;
  const FlexsibleButtonCalendar({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          color: Colors.transparent,
        ),
        Positioned(
          top: 8,
          left: 16,
          child: SvgPicture.asset(AppIcons.calendar),
        ),
        Positioned(
          top: 13,
          left: 48,
          child: Text(
            AppStrings.scrMenyCalendarDetailScreen,
            style: AppTextStyles.small.copyWith(color: AppColors.inactiveBlack),
          ),
        ),
      ],
    );
  }
}

class FlexsibleButtonFavorited extends StatelessWidget {
  final Sight card;
  const FlexsibleButtonFavorited({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          height: 40,
          color: Colors.transparent,
        ),
        Positioned(
          top: 8,
          left: 24,
          child: SvgPicture.asset(
            AppIcons.heartDark,
            color: theme.textTheme.bodyMedium!.color,
          ),
        ),
        Positioned(
          top: 13,
          left: 56,
          child: Text(
            AppStrings.scrMenyFavoritDetailScreen,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
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
