// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_map_iframe/google_map_iframe.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/strings/app_strings.dart';

class GooglMap extends StatefulWidget {
  const GooglMap({Key? key}) : super(key: key);

  @override
  State<GooglMap> createState() => _GooglMapState();
}

class _GooglMapState extends State<GooglMap> {
  LatLng position = LatLng(47.026455, 28.840455);

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listOfSights = Hive.box<Sight>(AppStrings.boxSights);
    final setOfMarkers = listOfSights.values
        .map(
          (e) => Marker(
            markerId: MarkerId(
              e.name,
            ),
            infoWindow: InfoWindow(title: e.name),
            position: LatLng(e.lat, e.lon),
            draggable: true,
            onDrag: (pos) {
              setState(() {
                listOfSights.get(e.name)!
                  ..lat = pos.latitude
                  ..lon = pos.longitude
                  ..save();
              });
            },
          ),
        )
        .toSet()
      ..add(
        Marker(
          markerId: MarkerId('Мое местоположение'),
          infoWindow: InfoWindow(title: 'Мое местоположение'),
          icon: BitmapDescriptor.defaultMarkerWithHue(100),
          position: position,
          draggable: true,
          onDrag: (pos) {
            setState(() {
              position = pos;
            });
          },
        ),
      );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            indoorViewEnabled: true,
            // границы за которые нельзя скролить карту
            // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            //   northeast: const LatLng(47.026499, 28.840499),
            //   southwest: const LatLng(47.026455, 28.840455),
            // )),

            // отступы для кнопок зум.
            // padding: const EdgeInsets.all(50),

            // Тип отрысовываемой карты(Фото города или схематический рисунок)
            // mapType: MapType.hybrid,
            markers: setOfMarkers,
            initialCameraPosition: CameraPosition(
              target: position,
              zoom: 14.0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.of(context).pop(position);
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              // color: selectedCategory.isNotEmpty
              //     ? theme.buttonColor
              //     : theme.cardColor,
            ),
            child: Center(
              child: Text(
                AppStrings.buttonSave.toUpperCase(),
                // style: selectedCategory.isNotEmpty
                //     ? AppTextStyles.button
                //     : AppTextStyles.button.copyWith(
                //         color: AppColors.inactiveBlack.withOpacity(0.56),
                //       ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission;
    Position myPosition;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      myPosition = permission == LocationPermission.denied
          ? const Position(
              latitude: 47.026455,
              longitude: 28.840455,
              accuracy: 0,
              altitude: 0,
              heading: 0,
              speed: 0,
              timestamp: null,
              speedAccuracy: 0,
            )
          : await Geolocator.getCurrentPosition();
    } else {
      myPosition = await Geolocator.getCurrentPosition();
    }
    setState(() {
      position = LatLng(myPosition.latitude, myPosition.longitude);
    });
  }
}
