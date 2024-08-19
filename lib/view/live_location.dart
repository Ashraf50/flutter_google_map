import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveLocationView extends StatefulWidget {
  const LiveLocationView({super.key});

  @override
  State<LiveLocationView> createState() => _LiveLocationViewState();
}

class _LiveLocationViewState extends State<LiveLocationView> {
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        googleMapController = controller;
        initMapStyle();
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(31.1, 30.5),
        zoom: 10,
      ),
    );
  }
  void initMapStyle()async{ 
    var assetsMapStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_styles/night_map_style.json");
    googleMapController.setMapStyle(assetsMapStyle);
  }
}
