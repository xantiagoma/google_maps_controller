import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Controller Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final s = "Map 2";
  GoogleMapsController controller;
  StreamSubscription<CameraPosition> subscription;
  CameraPosition position;

  @override
  void initState() {
    super.initState();

    controller = GoogleMapsController(
      initialCameraPosition: CameraPosition(
        target: LatLng(37.42796133580664, -122.085749655962),
        zoom: 14.4746,
      ),
      onTap: (latlng) {
        Circle circle;
        circle = Circle(
          circleId: CircleId(
            "ID:" + DateTime.now().millisecondsSinceEpoch.toString(),
          ),
          center: latlng,
          fillColor: Color.fromRGBO(255, 0, 0, 1),
          strokeColor: Color.fromRGBO(155, 0, 0, 1),
          radius: 5,
          onTap: () => controller.removeCircle(circle),
          consumeTapEvents: true,
        );

        controller.addCircle(circle);
      },
    );

    subscription = controller.onCameraMove$.listen((e) {
      setState(() {
        position = e;
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GoogleMaps(
            controller: controller,
          ),
        ),
        SafeArea(
          top: false,
          child: Text(position?.toString() ?? 'Move the map'),
        )
      ],
    );
  }
}
