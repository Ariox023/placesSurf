// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/strings/app_strings.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  double minRange = 0;
  double maxRange = 200;
  int counter = 0;
  List listOfFilteredSights = <String>[];
  Position _position = const Position(
    latitude: 0,
    longitude: 0,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    timestamp: null,
    speedAccuracy: 0,
  );

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
    _countSights();
  }

  @override
  Widget build(BuildContext context) {
    final listOfCategories =
        Hive.box<Category>(AppStrings.boxFiltersListCategories);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: theme.iconTheme.color,
          ),
          iconSize: 24,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              for (final i in listOfCategories.values) {
                i.chosen = false;
              }
              setState(_countSights);
            },
            child: Text(
              AppStrings.buttonClear,
              style: theme.textTheme.bodySmall,
            ),
            // style: ButtonStyle(
            //   shadowColor: MaterialStateColor.resolveWith(
            //     (states) => Colors.transparent,
            //   ),
            //   overlayColor: MaterialStateColor.resolveWith(
            //     (states) => Colors.transparent,
            //   ),
            // ),
          ),
          TextButton(
            onPressed: () {
              for (final i in listOfCategories.values) {
                i.chosen = true;
              }
              setState(_countSights);
            },
            child: Text(
              AppStrings.buttonFill,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 0, 24),
            child: Row(
              children: [
                Text(
                  AppStrings.scrFiltersScreen,
                  style: theme.textTheme.labelSmall,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 136, minHeight: 136),
        child: Stack(
          children: [
            if (_position.latitude != 0 && _position.longitude != 0)
              Positioned(
                left: 16,
                child: Text(
                  AppStrings.scrFiltersScreenRange,
                  style: theme.textTheme.labelMedium,
                ),
              ),
            if (_position.latitude != 0 && _position.longitude != 0)
              Positioned(
                right: 16,
                child: Text(
                  'от ${minRange.toStringAsFixed(1)} до ${maxRange.toStringAsFixed(1)} км',
                  textAlign: TextAlign.right,
                  style: theme.textTheme.labelMedium,
                ),
              ),
            if (_position.latitude != 0 && _position.longitude != 0)
              Positioned(
                top: 24,
                left: 0,
                width: MediaQuery.of(context).size.width,
                child: RangeSlider(
                  inactiveColor: AppColors.inactiveBlack,
                  max: 200,
                  onChanged: (value) {
                    setState(() {
                      minRange = value.start;
                      maxRange = value.end;
                      _countSights();
                    });
                  },
                  values: RangeValues(minRange, maxRange),
                ),
              ),
            Positioned(
              bottom: 8,
              left: 16,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  color: theme.buttonColor,
                ),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  splashColor: theme.buttonColor.withGreen(199),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppStrings.maingsScreen,
                      arguments: listOfFilteredSights,
                    );
                  },
                  child: SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width - 32,
                    child: Center(
                      child: Text(
                        'ПОКАЗАТЬ ($counter)',
                        style: theme.textTheme.displayMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GridView.count(
        shrinkWrap: true,
        restorationId: 'Список категорий',
        crossAxisCount: 3,
        children: listOfCategories.values
            .map<Widget>((e) => Ink(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    radius: 36,
                    child: Center(child: MyChip(cat: e)),
                    onTap: () {
                      setState(() {
                        e.chosen = !e.chosen;
                        _countSights();
                      });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  double calculateDistance(double lat, double long) {
    return Geolocator.distanceBetween(
          _position.latitude,
          _position.longitude,
          lat,
          long,
        ) /
        1000;
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      _position = permission == LocationPermission.denied
          ? const Position(
              latitude: 0,
              longitude: 0,
              accuracy: 0,
              altitude: 0,
              heading: 0,
              speed: 0,
              timestamp: null,
              speedAccuracy: 0,
            )
          : await Geolocator.getCurrentPosition();
    } else {
      _position = await Geolocator.getCurrentPosition();
      setState(() {});
    }
  }

  void _countSights() {
    counter = 0;
    listOfFilteredSights.clear();
    final listOfCategories =
        Hive.box<Category>(AppStrings.boxFiltersListCategories);
    final sightBox = Hive.box<Sight>(AppStrings.boxSights);
    for (final item in sightBox.values) {
      final range = calculateDistance(item.lat, item.lon);
      final category = listOfCategories.get(item.type);
      if (category!.chosen) {
        if (_position.latitude != 0 && _position.longitude != 0) {
          if (range >= minRange && range <= maxRange) {
            counter++;
            listOfFilteredSights.add(item.name);
          }
        } else {
          counter++;
          listOfFilteredSights.add(item.name);
        }
      }
    }
  }
}

class MyChip extends StatelessWidget {
  final Category cat;
  const MyChip({
    Key? key,
    required this.cat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(height: 92, width: 96),
      child: Stack(
        children: [
          Positioned(
            right: 16,
            height: 64,
            width: 64,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.buttonColor.withOpacity(0.16),
                borderRadius: const BorderRadius.all(Radius.circular(90)),
                // backgroundBlendMode: BlendMode.clear,
              ),
              child: SvgPicture.asset(
                cat.icon,
                color: theme.buttonColor,
                width: 32,
                height: 32,
                fit: BoxFit.none,
              ),
            ),
          ),
          if (cat.chosen)
            Positioned(
              left: 56,
              top: 40,
              width: 16,
              height: 16,
              child: Icon(
                Icons.check_circle,
                color: theme.iconTheme.color,
              ),
            ),
          Positioned(
            right: 0,
            top: 76,
            height: 16,
            width: 96,
            child: FittedBox(
              child: Text(
                cat.name,
                style: theme.textTheme.labelSmall,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
