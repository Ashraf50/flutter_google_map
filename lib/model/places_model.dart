import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({
    required this.id,
    required this.latLng,
    required this.name,
  });
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: "Desouk",
    latLng: const LatLng(31.134184517111297, 30.639489652321505),
  ),
  PlaceModel(
    id: 2,
    name: "Damanhour",
    latLng: const LatLng(31.04270848941701, 30.465092572131734),
  ),
  PlaceModel(
    id: 3,
    name: "Alexandria",
    latLng: const LatLng(31.200402917427667, 29.90266198851971),
  )
];
