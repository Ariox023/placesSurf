// ignore_for_file: avoid_types_on_closure_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/colors/gradients.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/wigets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:places/ui/wigets/containers/empty_body.dart';
import 'package:places/ui/wigets/search_field.dart';

/// Экран 'Список интересных мест'
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final _serchEditionController = TextEditingController();
  String query = '';
  List<Widget> listOfWidgets = [];

  @override
  void initState() {
    super.initState();

    _serchEditionController.addListener(_searchSignt);
  }

  @override
  void dispose() {
    _serchEditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sightBox = Hive.box<Sight>(AppStrings.boxSights);
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final filteredListOfSights = <String>[];
    final theme = Theme.of(context);

    if (arguments == null) {
      for (final item in sightBox.values) {
        filteredListOfSights.add(item.name);
      }
    } else {
      arguments as List<String>;
      filteredListOfSights.addAll(arguments);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: 152,
        centerTitle: false,
        titleSpacing: 16,
        elevation: 0,
        titleTextStyle: theme.textTheme.titleLarge,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        title: const _Text(),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SearchField(controller: _serchEditionController),
          const SizedBox(
            height: 34,
          ),
          ValueListenableBuilder(
            valueListenable: sightBox.listenable(),
            builder: (BuildContext context, Box<Sight> box, _) {
              listOfWidgets = <Widget>[
                for (var item in box.values)
                  if (cardFiltered(item) &&
                      filteredListOfSights.contains(item.name))
                    SightCard(
                      key: ValueKey(item.name),
                      cardSign: item,
                    ),
              ];
              if (listOfWidgets.isEmpty) {
                return const EmptyWidget(
                  icon: AppIcons.search,
                  subtitle: AppStrings.scrSightListScreenEmptyBodySubtitle,
                  str: AppStrings.scrSightListScreenEmptyBodySubtitle2,
                );
              }

              return Expanded(
                child: Scrollbar(
                  child: RefreshIndicator(
                    displacement: 0,
                    color: Colors.red,
                    strokeWidth: 2,
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    onRefresh: () async {
                      setState(() {
                        listOfWidgets.clear();
                        listOfWidgets = <Widget>[
                          for (var item in box.values)
                            if (cardFiltered(item) &&
                                filteredListOfSights.contains(item.name))
                              SightCard(
                                key: ValueKey(item.name),
                                cardSign: item,
                              ),
                        ];
                      });
                    },
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      children: listOfWidgets,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
      floatingActionButton: Container(
        height: 48,
        width: 177,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: AppGradients.addSightGradient,
        ),
        child: TextButton.icon(
          onPressed: () =>
              Navigator.of(context).pushNamed(AppStrings.addSightScreen),
          icon: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
          label: Text(
            AppStrings.scrAddSightScreen.toUpperCase(),
            style: AppTextStyles.button,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  bool cardFiltered(Sight item) {
    if (query.isEmpty) {
      return true;
    } else {
      // ignore: prefer-conditional-expressions
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    }
  }

  void _searchSignt() {
    query = _serchEditionController.text;
    setState(() {});
  }
}

/// Text
class _Text extends StatelessWidget {
  const _Text({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      'Список\nинтересных мест',
      style: AppBarTheme.of(context).titleTextStyle,
      textAlign: TextAlign.start,
    );
  }
}
