import 'dart:async';

import 'package:delivery_app/services/constant.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomMapForAgentToStore extends StatefulWidget {
  final Map<String, dynamic> orderDetail;

  const CustomMapForAgentToStore({Key key, this.orderDetail}) : super(key: key);

  @override
  _CustomMapForAgentToStoreState createState() =>
      _CustomMapForAgentToStoreState();
}

class _CustomMapForAgentToStoreState extends State<CustomMapForAgentToStore> {
  static BitmapDescriptor agentIcon, storeIcon;
  static const double CAMERA_ZOOM = 12;
  static const double CAMERA_TILT = 0;
  static const double CAMERA_BEARING = 30;
  static LatLng agentLocation, storeLocation;
  final PolylinePoints polylinePoints = PolylinePoints();
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final List<LatLng> polylineCoordinatesForAgentToStore = [];
  final List<LatLng> polylineCoordinatesForStoreToCustomer = [];

  bool isMapLoading = false;

  @override
  void initState() {
    getAgentLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isMapLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(primary),
            ),
          )
        : GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            padding: EdgeInsets.all(0),
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              zoom: CAMERA_ZOOM,
              bearing: CAMERA_BEARING,
              tilt: CAMERA_TILT,
              target: agentLocation,
            ));
  }

  void _onMapCreated(GoogleMapController ctr) {
    _controller.complete(ctr);
  }

  void setSourceAndDestinationIcons() async {
    agentIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icons/agentpin.png');
    storeIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icons/storepin.png');
    setLatLng();
  }

  void setLatLng() {
    storeLocation = LatLng(widget.orderDetail['location']['latitude'],
        widget.orderDetail['location']['longitude']);
    setMapPins();
  }

  void getAgentLocation() async {
    if (mounted) {
      setState(() {
        isMapLoading = true;
      });
    }
    getCurrentPosition().then((value) {
      print('done : ${value.toString()}');
      if (mounted) {
        setState(() {
          isMapLoading = false;
          agentLocation = LatLng(value.latitude, value.longitude);
        });
      }
      setSourceAndDestinationIcons();
    }).catchError((error) {
      if (mounted) {
        setState(() {
          isMapLoading = false;
        });
      }
    });
  }

  void setMapPins() {
    if (mounted) {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('agentPin'),
          position: agentLocation,
          icon: agentIcon,
        ));
        _markers.add(Marker(
          markerId: MarkerId('storePin'),
          position: storeLocation,
          icon: storeIcon,
        ));
      });
    }
    setPolylines();
  }

  void setPolylines() async {
    List<PointLatLng> agentToStore =
        await polylinePoints?.getRouteBetweenCoordinates(
      GOOGLE_API_KEY,
      agentLocation.latitude,
      agentLocation.longitude,
      storeLocation.latitude,
      storeLocation.longitude,
    );
    if (agentToStore.isNotEmpty) {
      agentToStore.forEach((PointLatLng point) {
        polylineCoordinatesForAgentToStore
            .add(LatLng(point.latitude, point.longitude));
      });
    }

    if (mounted) {
      setState(() {
        Polyline polyline = Polyline(
            polylineId: PolylineId('polylineCoordinatesForAgentToStore'),
            color: blacka,
            width: 3,
            points: polylineCoordinatesForAgentToStore);
        _polylines.add(polyline);
      });
    }
    updatePinOnMap();
  }

  void updatePinOnMap() {
    Location.instance.onLocationChanged.listen((location) async {
      agentLocation = LatLng(location.latitude, location.longitude);
      CameraPosition cPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: agentLocation,
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
      if (mounted) {
        setState(() {
          _markers.removeWhere((m) => m.markerId.value == 'agentPin');
          _markers.add(Marker(
            markerId: MarkerId('agentPin'),
            position: agentLocation,
            icon: agentIcon,
          ));
        });
      }
      updatePloyLines();
    });
  }

  void updatePloyLines() async {
    List<PointLatLng> agentToStore =
        await polylinePoints?.getRouteBetweenCoordinates(
      GOOGLE_API_KEY,
      agentLocation.latitude,
      agentLocation.longitude,
      storeLocation.latitude,
      storeLocation.longitude,
    );
    polylineCoordinatesForAgentToStore.clear();
    _polylines.removeWhere(
        (m) => m.polylineId.value == 'polylineCoordinatesForAgentToStore');
    if (agentToStore.isNotEmpty) {
      agentToStore.forEach((PointLatLng point) {
        polylineCoordinatesForAgentToStore
            .add(LatLng(point.latitude, point.longitude));
      });
    }

    if (mounted) {
      setState(() {
        Polyline polyline = Polyline(
            polylineId: PolylineId('polylineCoordinatesForAgentToStore'),
            color: blacka,
            width: 3,
            points: polylineCoordinatesForAgentToStore);
        _polylines.add(polyline);
      });
    }
  }
}

class CustomMapForStoreToCustomer extends StatefulWidget {
  final Map<String, dynamic> orderDetail;
  final LatLng agentLocation;

  const CustomMapForStoreToCustomer(
      {Key key, this.orderDetail, this.agentLocation})
      : super(key: key);

  @override
  _CustomMapForStoreToCustomerState createState() =>
      _CustomMapForStoreToCustomerState();
}

class _CustomMapForStoreToCustomerState
    extends State<CustomMapForStoreToCustomer> {
  static BitmapDescriptor agentIcon, customerIcon;
  static const double CAMERA_ZOOM = 16;
  static const double CAMERA_TILT = 0;
  static const double CAMERA_BEARING = 30;
  static LatLng agentLocation, customerLocation;
  bool isMapLoading = false;
  final PolylinePoints polylinePoints = PolylinePoints();
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  GoogleMapController myMapController;
  final Set<Polyline> _polylines = {};
  final List<LatLng> polylineCoordinatesForStoreToCustomer = [];

  @override
  void initState() {
    getAgentLocation();
    super.initState();
  }

  @override
  void dispose() {
    myMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isMapLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(primary),
            ),
          )
        : GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            padding: EdgeInsets.all(0),
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              zoom: CAMERA_ZOOM,
              bearing: CAMERA_BEARING,
              tilt: CAMERA_TILT,
              target: agentLocation,
            ));
  }

  void _onMapCreated(GoogleMapController ctr) {
    _controller.complete(ctr);
  }

  void setSourceAndDestinationIcons() async {
    agentIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icons/agentpin.png');
    customerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icons/homepin.png');
    setLatLng();
  }

  void setLatLng() {
    customerLocation = LatLng(
      widget.orderDetail['shippingAddress']['location']['lat'],
      widget.orderDetail['shippingAddress']['location']['long'],
    );
    setMapPins();
  }

  void setMapPins() {
    if (mounted) {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('agentPin'),
          position: agentLocation,
          icon: agentIcon,
        ));
        _markers.add(Marker(
          markerId: MarkerId('customerPin'),
          position: customerLocation,
          icon: customerIcon,
        ));
      });
    }
    setPolylines();
  }

  void setPolylines() async {
    List<PointLatLng> storeToCustomer =
        await polylinePoints?.getRouteBetweenCoordinates(
      GOOGLE_API_KEY,
      agentLocation.latitude,
      agentLocation.longitude,
      customerLocation.latitude,
      customerLocation.longitude,
    );
    if (storeToCustomer.isNotEmpty) {
      storeToCustomer.forEach((PointLatLng point) {
        polylineCoordinatesForStoreToCustomer
            .add(LatLng(point.latitude, point.longitude));
      });
    }
    if (mounted) {
      setState(() {
        Polyline polyline = Polyline(
            polylineId: PolylineId('polylineCoordinatesForStoreToCustomer'),
            color: primary,
            width: 3,
            points: polylineCoordinatesForStoreToCustomer);
        _polylines.add(polyline);
      });
    }
    updatePinOnMap();
  }

  void updatePinOnMap() {
    Location.instance.onLocationChanged.listen((location) async {
      agentLocation = LatLng(location.latitude, location.longitude);
      CameraPosition cPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: agentLocation,
      );
      final GoogleMapController controller = myMapController;
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
      if (mounted) {
        setState(() {
          _markers.removeWhere((m) => m.markerId.value == 'agentPin');
          _markers.add(Marker(
            markerId: MarkerId('agentPin'),
            position: agentLocation,
            icon: agentIcon,
          ));
        });
      }
      updatePloyLines();
    });
  }

  void updatePloyLines() async {
    List<PointLatLng> agentToCustomer =
        await polylinePoints?.getRouteBetweenCoordinates(
      GOOGLE_API_KEY,
      agentLocation.latitude,
      agentLocation.longitude,
      customerLocation.latitude,
      customerLocation.longitude,
    );
    polylineCoordinatesForStoreToCustomer.clear();
    _polylines.removeWhere(
        (m) => m.polylineId.value == 'polylineCoordinatesForStoreToCustomer');
    if (agentToCustomer.isNotEmpty) {
      agentToCustomer.forEach((PointLatLng point) {
        polylineCoordinatesForStoreToCustomer
            .add(LatLng(point.latitude, point.longitude));
      });
    }

    if (mounted) {
      setState(() {
        Polyline polyline = Polyline(
            polylineId: PolylineId('polylineCoordinatesForStoreToCustomer'),
            color: primary,
            width: 3,
            points: polylineCoordinatesForStoreToCustomer);
        _polylines.add(polyline);
      });
    }
  }

  void getAgentLocation() {
    try {
      if (mounted) {
        setState(() {
          isMapLoading = true;
        });
      }
      getCurrentPosition().then((value) {
        print('done : ${value.toString()}');
        if (mounted) {
          setState(() {
            isMapLoading = false;
            agentLocation = LatLng(value.latitude, value.longitude);
          });
        }
        setSourceAndDestinationIcons();
      }).catchError((error) {
        if (mounted) {
          setState(() {
            isMapLoading = false;
          });
        }
      });
    } catch (error) {
      print(error.toString());
      if (mounted) {
        setState(() {
          isMapLoading = false;
        });
      }
    }
  }
}
