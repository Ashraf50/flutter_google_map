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
    initPolygon();
    initCircle();
  }

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  Set<Polygon> polyGons = {};
  Set<Circle> circles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            circles: circles,
            polygons: polyGons,
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

  void initPolygon() {
    var polyGon = Polygon(
      fillColor: Colors.black.withOpacity(.5),
      polygonId: const PolygonId("1"),
      holes: const [
        [
          LatLng(31.14528467619539, 30.608745526944563),
          LatLng(31.145292294037148, 30.60880997055759),
          LatLng(31.145228017458045, 30.608818017184323),
          LatLng(31.145221704577366, 30.608752303066026),
          LatLng(31.14528467619539, 30.608745526944563),
        ]
      ],
      points: const [
        LatLng(31.1492655604694, 30.61352308168096),
        LatLng(31.148859604170468, 30.602375967679798),
        LatLng(31.141552093526478, 30.60711942044625),
        LatLng(31.141349099080067, 30.617555016532446),
        LatLng(31.1492655604694, 30.61352308168096),
      ],
    );
    polyGons.add(polyGon);
  }

  void initCircle() {
    var circle = const Circle(
      circleId: CircleId("1"),
      center: LatLng(31.134327550630385, 30.645586694870236),
      radius: 1000,
    );
    circles.add(circle);
  }
}
