part of google_maps_controller;

void _voidFunction() {}
void _voidFunctionOneParameter(dynamic a) {}

/// Wrapper of [GoogleMapController] same interface
///
/// Also adds the methods, streams and utilities to interact with the map
class GoogleMapsController extends ChangeNotifier {
  final CameraPosition initialCameraPosition;

  // Events
  late final void Function() _onCameraIdle;
  late final void Function() _onCameraMoveStarted;
  late final void Function(CameraPosition) _onCameraMove;
  late final void Function(LatLng) _onLongPress;
  late final void Function(LatLng) _onTap;
  late final void Function(GoogleMapController) _onMapCreated;

  // Event getters
  void Function() get onCameraIdle => _onCameraIdle;
  void Function() get onCameraMoveStarted => _onCameraMoveStarted;
  void Function(CameraPosition) get onCameraMove => _onCameraMove;
  void Function(LatLng) get onLongPress => _onLongPress;
  void Function(LatLng) get onTap => _onTap;
  void Function(GoogleMapController) get onMapCreated => _onMapCreated;

  GoogleMapController? _googleMapController;
  BuildContext? _context;

  final _onTap$ = StreamController<LatLng>.broadcast();
  Stream<LatLng> get onTap$ => _onTap$.stream;

  final _onLongPress$ = StreamController<LatLng>.broadcast();
  Stream<LatLng> get onLongPress$ => _onLongPress$.stream;

  final _onCameraMove$ = StreamController<CameraPosition>.broadcast();
  Stream<CameraPosition> get onCameraMove$ => _onCameraMove$.stream;

  final _onCameraMoveStarted$ = StreamController<void>.broadcast();
  Stream<void> get onCameraMoveStarted$ => _onCameraMoveStarted$.stream;

  final _onCameraIdle$ = StreamController<void>.broadcast();
  Stream<void> get onCameraIdle$ => _onCameraIdle$.stream;

  GoogleMapsController({
    // Events
    void Function(GoogleMapController) onMapCreated = _voidFunctionOneParameter,
    void Function() onCameraIdle = _voidFunction,
    void Function(CameraPosition) onCameraMove = _voidFunctionOneParameter,
    void Function() onCameraMoveStarted = _voidFunction,
    void Function(LatLng) onLongPress = _voidFunctionOneParameter,
    void Function(LatLng) onTap = _voidFunctionOneParameter,

    // Initials
    CameraPosition? initialCameraPosition,
    Set<Circle>? initialCircles,
    Set<Marker>? initialMarkers,
    Set<Polygon>? initialPolygons,
    Set<Polyline>? initialPolylines,
    bool buildingsEnabled = true,
    CameraTargetBounds cameraTargetBounds = CameraTargetBounds.unbounded,
    bool compassEnabled = true,
    bool indoorViewEnabled = false,
    bool liteModeEnabled = false,
    bool zoomControlsEnabled = true,
    bool mapToolbarEnabled = true,
    MapType mapType = MapType.normal,
    MinMaxZoomPreference minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    bool myLocationEnabled = false,
    bool myLocationButtonEnabled = true,
    EdgeInsets padding = const EdgeInsets.all(0),
    bool rotateGesturesEnabled = true,
    bool scrollGesturesEnabled = true,
    bool tiltGesturesEnabled = true,
    bool trafficEnabled = false,
    bool zoomGesturesEnabled = true,
    List<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  })  : this.initialCameraPosition = initialCameraPosition ??
            const CameraPosition(
              target: LatLng(0, 0),
              zoom: 15,
            ),
        this._circles = initialCircles ?? Set(),
        this._polygons = initialPolygons ?? Set(),
        this._polylines = initialPolylines ?? Set(),
        this._markers = initialMarkers ?? Set(),
        this._buildingsEnabled = buildingsEnabled,
        this._cameraTargetBounds = cameraTargetBounds,
        this._compassEnabled = compassEnabled,
        this._indoorViewEnabled = indoorViewEnabled,
        this._liteModeEnabled = liteModeEnabled,
        this._zoomControlsEnabled = zoomControlsEnabled,
        this._mapToolbarEnabled = mapToolbarEnabled,
        this._mapType = mapType,
        this._minMaxZoomPreference = minMaxZoomPreference,
        this._myLocationEnabled = myLocationEnabled,
        this._myLocationButtonEnabled = myLocationButtonEnabled,
        this._padding = padding,
        this._rotateGesturesEnabled = rotateGesturesEnabled,
        this._scrollGesturesEnabled = scrollGesturesEnabled,
        this._tiltGesturesEnabled = tiltGesturesEnabled,
        this._trafficEnabled = trafficEnabled,
        this._gestureRecognizers = gestureRecognizers?.toSet() ??
            {
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
        this._zoomGesturesEnabled = zoomGesturesEnabled {
    this._onCameraIdle = () {
      _onCameraIdle$.add(null);
      onCameraIdle();
    };
    this._onCameraMoveStarted = () {
      _onCameraMoveStarted$.add(null);
      onCameraMoveStarted();
    };
    this._onCameraMove = (cameraPosition) {
      _onCameraMove$.add(cameraPosition);
      onCameraMove(cameraPosition);
    };
    this._onLongPress = (latlng) {
      _onLongPress$.add(latlng);
      onLongPress(latlng);
    };
    this._onTap = (latlng) {
      _onTap$.add(latlng);
      onTap(latlng);
    };
    this._onMapCreated = (googleMapsController) {
      init(googleMapsController);
      onMapCreated(googleMapsController);
    };
  }

  /// Set [BuildContext] to the controller used to perform some methods over it
  void setContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  /// Sets a pure [GoogleMapController] to [GoogleMapsController] for
  /// custom use or add functionality to pure controller.
  void init(GoogleMapController controller) {
    _googleMapController = controller;
    notifyListeners();
  }

  bool get initted => _googleMapController == null;
  GoogleMapController? get controller => _googleMapController;
  BuildContext? get context => _context;

  Set<Marker> _markers;
  Set<Marker> get markers => _markers;
  set markers(Set<Marker> markers) {
    this._markers = markers;
    notifyListeners();
  }

  Set<Circle> _circles;
  Set<Circle> get circles => _circles;
  set circles(Set<Circle> circles) {
    this._circles = circles;
    notifyListeners();
  }

  Set<Polygon> _polygons;
  Set<Polygon> get polygons => _polygons;
  set polygons(Set<Polygon> polygons) {
    this._polygons = polygons;
    notifyListeners();
  }

  Set<Polyline> _polylines;
  Set<Polyline> get polylines => _polylines;
  set polylines(Set<Polyline> polylines) {
    this._polylines = polylines;
    notifyListeners();
  }

  var _buildingsEnabled = true;
  bool get buildingsEnabled => _buildingsEnabled;
  set buildingsEnabled(bool value) {
    this._buildingsEnabled = value;
    notifyListeners();
  }

  var _cameraTargetBounds = CameraTargetBounds.unbounded;
  CameraTargetBounds get cameraTargetBounds => _cameraTargetBounds;
  set cameraTargetBounds(CameraTargetBounds value) {
    this._cameraTargetBounds = value;
    notifyListeners();
  }

  var _compassEnabled = true;
  bool get compassEnabled => _compassEnabled;
  set compassEnabled(bool value) {
    this._compassEnabled = value;
    notifyListeners();
  }

  var _indoorViewEnabled = false;
  bool get indoorViewEnabled => _indoorViewEnabled;
  set indoorViewEnabled(bool value) {
    this._indoorViewEnabled = value;
    notifyListeners();
  }

  var _liteModeEnabled = false;
  bool get liteModeEnabled => _liteModeEnabled;
  set liteModeEnabled(bool value) {
    this._liteModeEnabled = value;
    notifyListeners();
  }

  var _zoomControlsEnabled = true;
  bool get zoomControlsEnabled => _zoomControlsEnabled;
  set zoomControlsEnabled(bool value) {
    this._zoomControlsEnabled = value;
    notifyListeners();
  }

  var _mapToolbarEnabled = true;
  bool get mapToolbarEnabled => _mapToolbarEnabled;
  set mapToolbarEnabled(bool value) {
    this._mapToolbarEnabled = value;
    notifyListeners();
  }

  var _mapType = MapType.normal;
  MapType get mapType => _mapType;
  set mapType(MapType value) {
    this._mapType = value;
    notifyListeners();
  }

  var _minMaxZoomPreference = MinMaxZoomPreference.unbounded;
  MinMaxZoomPreference get minMaxZoomPreference => _minMaxZoomPreference;
  set minMaxZoomPreference(MinMaxZoomPreference value) {
    this._minMaxZoomPreference = value;
    notifyListeners();
  }

  var _myLocationEnabled = false;
  bool get myLocationEnabled => _myLocationEnabled;
  set myLocationEnabled(bool value) {
    this._myLocationEnabled = value;
    notifyListeners();
  }

  var _myLocationButtonEnabled = true;
  bool get myLocationButtonEnabled => _myLocationButtonEnabled;
  set myLocationButtonEnabled(bool value) {
    this._myLocationButtonEnabled = value;
    notifyListeners();
  }

  var _padding = const EdgeInsets.all(0);
  EdgeInsets get padding => _padding;
  set padding(EdgeInsets value) {
    this._padding = value;
    notifyListeners();
  }

  var _rotateGesturesEnabled = true;
  bool get rotateGesturesEnabled => _rotateGesturesEnabled;
  set rotateGesturesEnabled(bool value) {
    this._rotateGesturesEnabled = value;
    notifyListeners();
  }

  var _scrollGesturesEnabled = true;
  bool get scrollGesturesEnabled => _scrollGesturesEnabled;
  set scrollGesturesEnabled(bool value) {
    this._scrollGesturesEnabled = value;
    notifyListeners();
  }

  var _tiltGesturesEnabled = true;
  bool get tiltGesturesEnabled => _tiltGesturesEnabled;
  set tiltGesturesEnabled(bool value) {
    this._tiltGesturesEnabled = value;
    notifyListeners();
  }

  var _trafficEnabled = false;
  bool get trafficEnabled => _trafficEnabled;
  set trafficEnabled(bool value) {
    this._trafficEnabled = value;
    notifyListeners();
  }

  var _zoomGesturesEnabled = true;
  bool get zoomGesturesEnabled => _zoomGesturesEnabled;
  set zoomGesturesEnabled(bool value) {
    this._zoomGesturesEnabled = value;
    notifyListeners();
  }

  var _gestureRecognizers = {
    Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
  };
  Set<Factory<OneSequenceGestureRecognizer>> get gestureRecognizers =>
      _gestureRecognizers;
  set gestureRecognizers(Set<Factory<OneSequenceGestureRecognizer>> value) {
    this._gestureRecognizers = value;
    notifyListeners();
  }

  // Markers
  addMarkers(List<Marker> markers) {
    this._markers.addAll(markers);
    notifyListeners();
  }

  addMarker(Marker marker) => addMarkers([marker]);
  clearMarkers() {
    this._markers = {};
    notifyListeners();
  }

  removeMarkers(Iterable<Marker> markers) {
    this._markers.removeAll(markers);
    notifyListeners();
  }

  removeMarker(Marker marker) {
    this._markers.remove(marker);
    notifyListeners();
  }

  // Circles

  addCircles(List<Circle> circles) {
    this._circles.addAll(circles);
    notifyListeners();
  }

  addCircle(Circle circle) => addCircles([circle]);
  clearCircles() {
    this._circles = {};
    notifyListeners();
  }

  removeCircles(Iterable<Circle> circles) {
    this._circles.removeAll(circles);
    notifyListeners();
  }

  removeCircle(Circle circle) {
    this._circles.remove(circle);
    notifyListeners();
  }

  // Polygons
  addPolygons(List<Polygon> polygons) {
    this._polygons.addAll(polygons);
    notifyListeners();
  }

  addPolygon(Polygon polygon) => addPolygons([polygon]);

  clearPolygons() {
    this._polygons = {};
    notifyListeners();
  }

  removePolygons(Iterable<Polygon> polygons) {
    this._polygons.removeAll(polygons);
    notifyListeners();
  }

  removePolygon(Polygon polygon) {
    this._polygons.remove(polygon);
    notifyListeners();
  }

  // Polylines
  addPolylines(List<Polyline> polylines) {
    this._polylines.addAll(polylines);
    notifyListeners();
  }

  addPolyline(Polyline polyline) => addPolylines([polyline]);
  clearPolylines() {
    this._polylines = {};
    notifyListeners();
  }

  removePolylines(Iterable<Polyline> polylines) {
    this._polylines.removeAll(polylines);
    notifyListeners();
  }

  removePolyline(Polyline polyline) {
    this._polylines.remove(polyline);
    notifyListeners();
  }

  // Interactions

  Future<void> animateCamera(CameraUpdate cameraUpdate) async =>
      _googleMapController?.animateCamera(cameraUpdate);

  Future<LatLng?> getLatLng(ScreenCoordinate screenCoordinate) async =>
      _googleMapController?.getLatLng(screenCoordinate);

  Future<ScreenCoordinate?> getScreenCoordinate(LatLng latLng) async =>
      _googleMapController?.getScreenCoordinate(latLng);

  Future<LatLngBounds?> getVisibleRegion() async =>
      _googleMapController?.getVisibleRegion();

  Future<double?> getZoomLevel() async => _googleMapController?.getZoomLevel();

  Future<void> hideMarkerInfoWindow(MarkerId markerId) async =>
      _googleMapController?.hideMarkerInfoWindow(markerId);

  Future<bool?> isMarkerInfoWindowShown(MarkerId markerId) async =>
      _googleMapController?.isMarkerInfoWindowShown(markerId);

  Future<void> showMarkerInfoWindow(MarkerId markerId) async =>
      _googleMapController?.showMarkerInfoWindow(markerId);

  Future<Uint8List?> takeSnapshot() async =>
      _googleMapController?.takeSnapshot();

  Future<void> moveCamera(CameraUpdate cameraUpdate) async =>
      _googleMapController?.moveCamera(cameraUpdate);

  Future<void> setMapStyle(String mapStyle) async =>
      _googleMapController?.setMapStyle(mapStyle);

  Future<double?> get zoom async => _googleMapController?.getZoomLevel();

  Future<void> updateCamera(
    CameraUpdate cameraUpdate, {
    bool animate = false,
  }) async =>
      animate
          ? _googleMapController?.animateCamera(cameraUpdate)
          : _googleMapController?.moveCamera(cameraUpdate);

  Future<void> zoomIn({
    bool animate = false,
  }) =>
      updateCamera(CameraUpdate.zoomIn(), animate: animate);

  Future<void> zoomOut({
    bool animate = false,
  }) =>
      updateCamera(CameraUpdate.zoomOut(), animate: animate);

  Future<void> zoomTo(
    double zoom, {
    bool animate = false,
  }) =>
      updateCamera(CameraUpdate.zoomTo(zoom), animate: animate);

  Future<void> zoomBy(
    double amount, {
    Offset? focus,
    bool animate = false,
  }) =>
      updateCamera(CameraUpdate.zoomBy(amount, focus), animate: animate);

  Future<void> newLatLngZoom(
    LatLng latLng,
    double zoom, {
    bool animate = false,
  }) =>
      updateCamera(CameraUpdate.newLatLngZoom(latLng, zoom), animate: animate);

  Future<void> newCameraPosition(
    CameraPosition cameraPosition, {
    bool animate = false,
  }) =>
      updateCamera(CameraUpdate.newCameraPosition(cameraPosition),
          animate: animate);

  Future<void> newLatLng(
    LatLng latLng, {
    bool animate = false,
  }) =>
      updateCamera(CameraUpdate.newLatLng(latLng), animate: animate);

  Future<void> newLatLngBounds(
    LatLngBounds bounds,
    double padding, {
    bool animate = false,
  }) =>
      updateCamera(CameraUpdate.newLatLngBounds(bounds, padding),
          animate: animate);

  Future<void> scrollBy(
    double dx,
    double dy, {
    bool animate = false,
  }) =>
      updateCamera(CameraUpdate.scrollBy(dx, dy), animate: animate);
}
