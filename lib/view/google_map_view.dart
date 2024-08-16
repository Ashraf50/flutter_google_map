import 'package:flutter/material.dart';
import 'package:flutter_google_map/model/places_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  @override
  void initState() {
    super.initState();
    initMarkers();
    initPolyLines();
  }

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            polylines: polyLines,
            markers: markers,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapStyle();
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(31.1, 30.5),
              zoom: 10,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 130,
            child: ElevatedButton(
              onPressed: () {
                googleMapController.animateCamera(
                  CameraUpdate.newLatLng(
                    const LatLng(31.19992823449557, 29.919197953782454),
                  ),
                );
              },
              child: const Text("Change Location"),
            ),
          )
        ],
      ),
    );
  }

  void initMapStyle() async {
    var assetsMapStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_styles/night_map_style.json");
    googleMapController.setMapStyle(assetsMapStyle);
  }

  void initMarkers() {
    var myMarkers = places
        .map((placeModel) => Marker(
              infoWindow: InfoWindow(title: placeModel.name),
              markerId: MarkerId(placeModel.id.toString()),
              position: placeModel.latLng,
            ))
        .toSet();

    markers.addAll(myMarkers);
  }

  void initPolyLines() {
    Polyline polyLine = const Polyline(
      color: Colors.red,
      polylineId: PolylineId("1"),
      points: [
        LatLng(31.1331515435719, 30.639067008632633),
        LatLng(31.043864122956517, 30.47134021420016),
        LatLng(31.199092634111146, 29.922828264839914),
      ],
    );
    polyLines.add(polyLine);
  }
}
