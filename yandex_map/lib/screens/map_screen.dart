import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../services/location_service.dart';
import '../models/app_lat_long.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final locationService = LocationService();
  late YandexMapController _controller;

  @override
  void initState() {
    super.initState();
    locationService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Карта')),
      body: FutureBuilder<AppLatLong>(
        future: locationService.getCurrentLocation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final location = snapshot.data!;
          final point = Point(latitude: location.lat, longitude: location.long);

          return YandexMap(
            onMapCreated: (controller) {
              _controller = controller;
              _controller.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: point, zoom: 14),
                ),
              );
            },
            mapObjects: [
              PlacemarkMapObject(
                mapId: const MapObjectId('user_location'),
                point: point,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage('assets/location.png'),
                    scale: 2,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
