import 'package:ekayzone/modules/map/map_cubit.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppMapView extends StatefulWidget {
  const AppMapView({Key? key}) : super(key: key);

  @override
  State<AppMapView> createState() => _AppMapViewState();
}

class _AppMapViewState extends State<AppMapView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit,MapState>(
      builder: (context,state){
        if (state is MapStateLoaded) {
          if (kDebugMode) {
            print("............... loaded ..................");
          }
          return GoogleMap(
            mapType: MapType.normal,
            scrollGesturesEnabled: true,
            indoorViewEnabled: false,
            buildingsEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            // tiltGesturesEnabled: false,
            compassEnabled: true,
            markers: state.markers,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer(),),
            },
            initialCameraPosition: context.read<MapCubit>().googlePlex,
            onMapCreated: (GoogleMapController mapController) async {
              if (!context.read<MapCubit>().mapController.isCompleted) {
                context.read<MapCubit>().mapController.complete(mapController);
              }
              // context.read<CheckoutCubit>().generateMarkers();
            },
            onTap: (latLan){
              context.read<MapCubit>().setMarkerIcon(latLan.latitude,latLan.longitude);
              // setState(() {
              //   // generateMarkers(latLan);
              //   context.read<MapCubit>().setMarkerIcon(latLan.latitude,latLan.longitude);
              // });
              // context.read<CheckoutCubit>().updateLocation(latLan);
            },
          );
        } else if (state is MapStateLoading) {
          return const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: redColor,),
            ),
          );
        } else if (state is MapStateError) {
          return const Center(
            child: SizedBox(
              child: Text("Need App Location Permission. \nOther wise proceed manual Address"),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
