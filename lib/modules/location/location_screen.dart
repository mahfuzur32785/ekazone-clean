import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ekayzone/core/animation/top_bottom_animation.dart';
import 'package:ekayzone/dummy_data/all_dudmmy_data.dart';
import 'package:ekayzone/modules/location/component/location_tile.dart';
import 'package:ekayzone/modules/location/component/static_widgets.dart';
import 'package:ekayzone/modules/location/component/use_current_location_btn.dart';

import '../../utils/constants.dart';
import 'component/back_all_location_tile.dart';
import 'component/color_location_tile.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int selectedLocation = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        title: const Text(
          "Pick a location",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            if (selectedLocation > -1) {
              setState(() {
                selectedLocation = -1;
              });
              return;
            }
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: redColor,
            statusBarIconBrightness: Brightness.light),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (selectedLocation > -1) {
          return CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverToBoxAdapter(
                child: LocationTile(
                    title: locationList[0].title,
                    onPressed: () {

                    },
                    isShow: true),
              ),
              SliverToBoxAdapter(
                child: BackAllLocationTile(
                    title: "Back To all Location",
                    onPressed: () {
                      setState(() {
                        selectedLocation = -1;
                      });
                    },
                    isShow: true),
              ),
              SliverToBoxAdapter(
                child: DelayedTopBottomAnimation(
                  delay: 50,
                  child: ColorLocationTile(
                      title: locationList[selectedLocation].title,
                      onPressed: () {

                      },
                      isShow: false),
                ),
              ),
              SliverToBoxAdapter(
                child: DelayedTopBottomAnimation(
                  delay: 50,
                  child: LocationTile(
                      title: "All Ads in ${locationList[selectedLocation].title}",
                      onPressed: () {

                      },
                      isShow: false),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return DelayedTopBottomAnimation(
                    delay: 50,
                    child: LocationTile(
                        title: locationList[selectedLocation].subLocation[index],
                        onPressed: () {},
                        isShow: false),
                  );
                }, childCount: locationList[selectedLocation].subLocation.length),
              )
            ],
          );
        } else {
          return CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              const UseCurrentLocationBtn(),
              StaticWidgets().orSelectLocation(),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return LocationTile(
                      title: locationList[index].title,
                      onPressed: () {
                        if (index != 0) {
                          setState(() {
                            selectedLocation = index;
                          });
                        }
                      },
                      isShow: index == 0);
                }, childCount: locationList.length),
              )
            ],
          );
        }
      }),
    );
  }
}
