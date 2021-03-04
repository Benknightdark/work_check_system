import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final dynamic data;
  final Function(dynamic item) onShowDetail;

  MapPage({this.data, this.onShowDetail});
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> markers = [];
  Completer<GoogleMapController> _controller = Completer();
  double lat = 0;
  double ln = 0;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) => _initData(context));
    setState(() {
      (() async {
        LocationPermission permission = await Geolocator.requestPermission();
        print(permission.index);
        LocationPermission permission2 = await Geolocator.checkPermission();
        print(permission2.index);
        EasyLoading.show(status: 'loading...');
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        lat = position.latitude;
        ln = position.longitude;

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            bearing: 20.8334901395799,
            target: LatLng(lat, ln),
            tilt: 20.440717697143555,
            zoom: 16.151926040649414)));
        EasyLoading.dismiss();
      })();
    });
    setState(() {
      print(widget.data);
      double punchLat = double.parse(widget.data["latitude"]);
      double punchln = double.parse(widget.data["longtitude"]);
      markers = [];
      LatLng tappedPoint = LatLng(punchLat, punchln);

      markers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          onTap: () {
            widget.onShowDetail(widget.data);
          }));
      print(tappedPoint.toJson());
      print("fuck");
    });
    EasyLoading.showSuccess('Use in initState');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
            target: LatLng(lat, ln),
            tilt: 20.440717697143555,
            zoom: 16.463865280151367),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        // onCameraMove: (position) => {print(position)},
        onTap: (LatLng tappedPoint) {
          setState(() {
            print(tappedPoint);
            print(tappedPoint.toString());
          });
        },
        markers: Set.from(markers),
      ),
    );
  }
}
