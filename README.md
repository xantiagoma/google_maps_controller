# google_maps_controller

Stateful map controller for Google Maps [google_maps_flutter](https://pub.dev/packages/google_maps_flutter). Manage Markers, Circles, Polylines, and Polygons.

Inspired by [map_controller](https://pub.dev/packages/map_controller) for [flutter_map](https://pub.dev/packages/flutter_map).


## Getting Started

Follow same config steps as decirbed in google_maps_flutter
[getting-started](https://pub.dev/packages/google_maps_flutter#getting-started).

## Usage
Use `GoogleMaps` widget instead of `GoogleMap` to use auto set-up widget.

Use `GoogleMapsController` for all the actions.

Check example dir for more details.

```dart
var controller = GoogleMapsController();

// Widget
GoogleMaps(
    controller: controller,
)
```

You can also provide controller through provider / InheritedWidget / BLoC or any other state management.

```dart
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
          child: Text("$position"),
        )
      ],
    );
  }
}

```
![Demo](images/demo.gif)

## LICENSE

[MIT](./LICENSE)

## API

[Check full docs](https://pub.dev/documentation/google_maps_controller/latest/)

### GoogleMapsController

```dart
GoogleMapsController({
    void Function(GoogleMapController) onMapCreated,
    void Function() onCameraIdle,
    void Function(CameraPosition) onCameraMove,
    void Function() onCameraMoveStarted,
    void Function(LatLng) onLongPress,
    void Function(LatLng) onTap,
    CameraPosition initialCameraPosition,
    Set<Circle> initialCircles,
    Set<Marker> initialMarkers,
    Set<Polygon> initialPolygons,
    Set<Polyline> initialPolylines,
    bool buildingsEnabled,
    CameraTargetBounds cameraTargetBounds,
    bool compassEnabled,
    bool indoorViewEnabled,
    bool liteModeEnabled,
    bool zoomControlsEnabled,
    bool mapToolbarEnabled,
    MapType mapType,
    MinMaxZoomPreference minMaxZoomPreference,
    bool myLocationEnabled,
    bool myLocationButtonEnabled,
    EdgeInsets padding,
    bool rotateGesturesEnabled,
    bool scrollGesturesEnabled,
    bool tiltGesturesEnabled,
    bool trafficEnabled,
    bool zoomGesturesEnabled,
    List<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
});
```

### GoogleMaps

```dart
GoogleMaps({
    @required GoogleMapsController controller,
})
```

### Controller

#### Properties

``` dart
buildingsEnabled ↔ bool
cameraTargetBounds ↔ CameraTargetBounds
circles ↔ Set<Circle>
compassEnabled ↔ bool
context → BuildContext
controller → GoogleMapController
gestureRecognizers ↔ Set<Factory<OneSequenceGestureRecognizer>>
indoorViewEnabled ↔ bool
initialCameraPosition → CameraPosition
initted → bool
liteModeEnabled ↔ bool
mapToolbarEnabled ↔ bool
mapType ↔ MapType
markers ↔ Set<Marker>
minMaxZoomPreference ↔ MinMaxZoomPreference
myLocationButtonEnabled ↔ bool
myLocationEnabled ↔ bool
onCameraIdle → void Function()
onCameraIdle$ → Stream<void>
onCameraMove → void Function(CameraPosition)
onCameraMove$ → Stream<CameraPosition>
onCameraMoveStarted → void Function()
onCameraMoveStarted$ → Stream<void>
onLongPress → void Function(LatLng)
onLongPress$ → Stream<LatLng>
onMapCreated → void Function(GoogleMapController)
onTap → void Function(LatLng)
onTap$ → Stream<LatLng>
padding ↔ EdgeInsets
polygons ↔ Set<Polygon>
polylines ↔ Set<Polyline>
rotateGesturesEnabled ↔ bool
scrollGesturesEnabled ↔ bool
tiltGesturesEnabled ↔ bool
trafficEnabled ↔ bool
zoom → Future<double>
zoomControlsEnabled ↔ bool
zoomGesturesEnabled ↔ bool
```

#### Methods

``` dart
addCircle(Circle circle) → void
addCircles(List<Circle> circles) → void
addMarker(Marker marker) → void
addMarkers(List<Marker> markers) → void
addPolygon(Polygon polygon) → void
addPolygons(List<Polygon> polygons) → void
addPolyline(Polyline polyline) → void
addPolylines(List<Polyline> polylines) → void
animateCamera(CameraUpdate cameraUpdate) → Future<void>
clearCircles() → void
clearMarkers() → void
clearPolygons() → void
clearPolylines() → void
getLatLng(ScreenCoordinate screenCoordinate) → Future<LatLng>
getScreenCoordinate(LatLng latLng) → Future<ScreenCoordinate>
getVisibleRegion() → Future<LatLngBounds>
getZoomLevel() → Future<double>
hideMarkerInfoWindow(MarkerId markerId) → Future<double>
init(GoogleMapController controller) → void
isMarkerInfoWindowShown(MarkerId markerId) → Future<bool>
moveCamera(CameraUpdate cameraUpdate) → Future<void>
newCameraPosition(CameraPosition cameraPosition, {bool animate: false}) → Future<void>
newLatLng(LatLng latLng, {bool animate: false}) → Future<void>
newLatLngBounds(LatLngBounds bounds, double padding, {bool animate: false}) → Future<void>
newLatLngZoom(LatLng latLng, double zoom, {bool animate: false}) → Future<void>
removeCircle(Circle circle) → void
removeCircles(Iterable<Circle> circles) → void
removeMarker(Marker marker) → void
removeMarkers(Iterable<Marker> markers) → void
removePolygon(Polygon polygon) → void
removePolygons(Iterable<Polygon> polygons) → void
removePolyline(Polyline polyline) → void
removePolylines(Iterable<Polyline> polylines) → void
scrollBy(double dx, double dy, {bool animate: false}) → Future<void>
setContext(BuildContext context) → void
setMapStyle(String mapStyle) → Future<void>
showMarkerInfoWindow(MarkerId markerId) → Future<bool>
takeSnapshot() → Future<Uint8List>
updateCamera(CameraUpdate cameraUpdate, {bool animate: false}) → Future<void>
zoomBy(double amount, {Offset focus, bool animate: false}) → Future<void>
zoomIn({bool animate: false}) → Future<void>
zoomOut({bool animate: false}) → Future<void>
zoomTo(double zoom, {bool animate: false}) → Future<void>
```
