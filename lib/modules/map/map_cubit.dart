import 'dart:async';
import 'dart:math';

import 'package:ekayzone/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapStateInitial());

  //....................... Map ..........................
  Completer<GoogleMapController> mapController = Completer();
  CameraPosition googlePlex = const CameraPosition(
    target: LatLng(23.817206, 90.413953),
    zoom: 16,
  );

  CameraPosition getCameraPosition(lat, lon) {
    return CameraPosition(
      target: LatLng(lat, lon),
      zoom: 16,
    );
  }

  void updateLocation(LatLng latLan) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        getCameraPosition(latLan.latitude, latLan.longitude)));
  }

  //............................ Marker .........................
  Marker defaultMarker() => Marker(
      markerId: MarkerId(Random().nextInt(1000).toString()),
      draggable: true,
      onDragEnd: (latLng) {},
      // position: const LatLng(9.566842, 44.060148),
      position: const LatLng(0.0, 0.0),
  );
  Set<Marker> markers = {};
  BitmapDescriptor? myMarker;
  void setMarkerIcon(lat, lon) async {
    myMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        'assets/images/marker_red.png');
    // updateLocation(LatLng(lat, lon));
    generateMarkers(LatLng(lat, lon));
  }

  void generateMarkers(LatLng latLng) {
    var localMarkers = <Marker>{};
    localMarkers.add(Marker(
        markerId: MarkerId(Random().nextInt(1000).toString()),
        draggable: true,
        onDragEnd: (latLng) {},
        position: latLng,
        icon: myMarker!));
    markers = localMarkers;
    emit(MapStateLoaded(localMarkers));
    // if(mounted) setState(() {});
    // setState(() {});
    // updateLocation(latLng);
  }

  late Position currentPosition;
  void getCurrentLocation() async {
    emit(const MapStateLoading());
    var status = await Permission.location.status;
    if (status.isGranted) {
      Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: false)
          .then((Position position) async {
        currentPosition = position;
        if (kDebugMode) {
          print("${currentPosition.latitude}, ${currentPosition.longitude}");
        }
        setMarkerIcon(position.latitude, position.longitude);
        final GoogleMapController controller = await mapController.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
            getCameraPosition(position.latitude, position.longitude)));
        // emit(state);
        // String url = "http://maps.google.com/maps?saddr=${currentPosition.latitude},${currentPosition.longitude}&daddr=$lat,$long&mode=driving";
        // Helper.openMap(url);
        if (kDebugMode) {
          print('${currentPosition.latitude} ${currentPosition.longitude}');
        }
      }).catchError((e) {
        if (kDebugMode) {
          print(e);
        }
        emit(MapStateError(e.toString()));
      });
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      getCurrentLocation();
    }else {
      print("xxxxxxxxxxxxxxxxxxxxx general xxxxxxxxxxxxxxxxxxxxxxxxxx");
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      Future.delayed(const Duration(seconds: 1)).then((value) => getCurrentLocation());
    }


    // if (await Permission.location.serviceStatus.isEnabled) {
    //   //........... Device Location is disabled ........
    //
    // } else {
    //
    // }

  }
}
