part of google_maps_controller;

/// Wraps [GoogleMap] to add specific logic and delegate it to [GoogleMapsController]
class GoogleMaps extends StatelessWidget {
  final GoogleMapsController controller;

  const GoogleMaps({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<GoogleMapsController>(
        builder: (
          BuildContext context,
          GoogleMapsController controller,
          Widget? _,
        ) {
          return GoogleMap(
            // Initialize
            initialCameraPosition: controller.initialCameraPosition,
            onMapCreated: controller._onMapCreated,

            // Events
            onCameraIdle: controller.onCameraIdle,
            onCameraMove: controller.onCameraMove,
            onCameraMoveStarted: controller.onCameraMoveStarted,
            onLongPress: controller.onLongPress,
            onTap: controller.onTap,

            // Elements
            markers: controller.markers,
            circles: controller.circles,
            polygons: controller.polygons,
            polylines: controller.polylines,

            //Settings
            buildingsEnabled: controller.buildingsEnabled,
            cameraTargetBounds: controller.cameraTargetBounds,
            compassEnabled: controller.compassEnabled,
            indoorViewEnabled: controller.indoorViewEnabled,
            mapToolbarEnabled: controller.mapToolbarEnabled,
            mapType: controller.mapType,
            minMaxZoomPreference: controller.minMaxZoomPreference,
            myLocationEnabled: controller.myLocationEnabled,
            myLocationButtonEnabled: controller.myLocationButtonEnabled,
            padding: controller.padding,
            rotateGesturesEnabled: controller.rotateGesturesEnabled,
            scrollGesturesEnabled: controller.scrollGesturesEnabled,
            tiltGesturesEnabled: controller.tiltGesturesEnabled,
            trafficEnabled: controller.trafficEnabled,
            zoomGesturesEnabled: controller.zoomGesturesEnabled,
            gestureRecognizers: controller.gestureRecognizers,
            liteModeEnabled: controller.liteModeEnabled,
            zoomControlsEnabled: controller.zoomControlsEnabled,
          );
        },
      ),
    );
  }
}
