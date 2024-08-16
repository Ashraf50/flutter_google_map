import 'package:flutter/material.dart';
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
  }

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
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
    var myMarkers = const Marker(
        markerId: MarkerId("1"),
        position: LatLng(31.19992823449557, 29.919197953782454));
    markers.add(myMarkers);
  }
}
