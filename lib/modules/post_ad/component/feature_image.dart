import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ekayzone/dummy_data/all_dudmmy_data.dart';
import 'package:ekayzone/modules/location/model/location_model.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:ekayzone/utils/utils.dart';

import '../controller/postad_bloc.dart';

class FeatureImageView extends StatefulWidget {
  const FeatureImageView({Key? key}) : super(key: key);

  @override
  State<FeatureImageView> createState() => _FeatureImageViewState();
}

class _FeatureImageViewState extends State<FeatureImageView> {

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<PostAdBloc>();
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: postAdBloc.featureFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Description*"),
                  const SizedBox(height: 6,),
                  BlocBuilder<PostAdBloc, PostAdModalState>(
                    buildWhen: (previous, current) => previous.description != current.description,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        // initialValue: state.description,
                        controller: postAdBloc.descriptionController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Description';
                          }
                          return null;
                        },
                        onChanged: (value) => postAdBloc.add(PostAdEventDescription(value)),
                        decoration: const InputDecoration(hintText: "Description"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Feature *"),
                  const SizedBox(
                    height: 8,
                  ),
                  ...List.generate(featureList.length, (index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: ashColor )
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  // height: 60,
                                  child: BlocBuilder<PostAdBloc, PostAdModalState>(
                                      buildWhen: (previous, current) => previous.features != current.features,
                                      builder: (context, state) {
                                      return TextFormField(
                                        // validator: validator,
                                        // controller: controller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return getPosition(index+1);
                                          }
                                          return null;
                                        },
                                        onChanged: (value){
                                          featureList[index] = value.toString();
                                          postAdBloc.add(PostAdEventFeature(featureList));
                                          // if (value != "") {
                                          //   featureList[index] = value.toString();
                                          // }
                                        },
                                        onSaved: (String? val) {

                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                          hintText: index == 0 ? "Feature" : "Another Feature",
                                          hintStyle: const TextStyle(color: ashTextColor,fontWeight: FontWeight.w400,fontSize: 14),
                                          // labelText: 'Email',
                                          // isDense: true,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                        ),
                                      );
                                    }
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Material(
                                color: index == featureList.length -1 ? redColor : ashTextColor,
                                shape: const CircleBorder(),
                                child: InkWell(
                                  onTap: (){
                                    if (index == (featureList.length-1)) {
                                      addContact();
                                    } else {
                                      removeContact(index);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: index == featureList.length -1
                                        ? const Icon(Icons.add,size: 20,color: Colors.white,)
                                        : const Icon(Icons.close,size: 20,color: Colors.white,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16,)
                      ],
                    );
                  }),

                  BlocBuilder<PostAdBloc, PostAdModalState>(
                      buildWhen: (previous, current) => previous.location != current.location,
                      builder: (context, state) {
                      return TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: postAdBloc.locationController,
                            decoration: const InputDecoration(
                                labelText: 'Your Location'
                            )
                        ),
                        suggestionsCallback: (pattern) {
                          getPlaces(pattern).then((value) {
                            placesSearchResult = value;
                          });
                          return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                          // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion.name),
                          );
                        },
                        transitionBuilder: (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (PlacesSearchResult suggestion) {
                          postAdBloc.add(PostAdEventLocation(suggestion.name));
                        },
                        validator: (value) {
                          if (postAdBloc.state.location == '') {
                            return 'Enter Your Location';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {

                        },
                      );
                    }
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: (){
                        getCurrentLocation();
                      },
                      icon: const Icon(Icons.location_on_outlined),
                      label: const Text("Use My Current Location"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: ashColor),
                    ),
                      child: const Text("You must upload at least 1 to 5 images.Image must be in jpg, jpeg, png format *",style: TextStyle(color: ashTextColor),)),
                  const SizedBox(
                    height: 16,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(3),
                            onTap: (){
                              pickImages().then((value) {
                                postAdBloc.add(PostAdEventImages(value ?? []));
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: ashColor),
                              ),
                              child: const Center(
                                child: Icon(Icons.add_circle_outlined,color: redColor,),
                              ),
                            ),
                          ),
                        );
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: ashTextColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Image(
                            // image: FileImage(File(controller.images2![index].path))
                              image: FileImage(File(images![index-1].path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: images!.length+1,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  //.............. contacts info ....................
  List<String> featureList = [""];
  var contactController = TextEditingController();
  void addContact(){
    setState(() {
      featureList.add("");
    });
  }
  void removeContact(index){
    setState(() {
      featureList.removeAt(index);
    });
  }

  String getPosition(index){
    switch(index) {
      case 1:
        return "Enter 1st Feature";
      case 2:
        return "Enter 2nd Feature";
      case 3:
        return "Enter 3rd Feature";
      default:
        return "Enter ${index}th Feature";
    }

  }

  // .................... Photo Picker ...................
  final ImagePicker picker = ImagePicker();
  List<XFile>? images = [];
  List<String> base64Images = [];

  Future<List<String>?> pickImages() async {
    List<String> imagePaths = [];
    List<XFile>? tempImages = await picker.pickMultiImage();
    if (tempImages == null) {
      print("Image doesn't choose!");
      return imagePaths;
    } else {
      images = tempImages;
      base64Images = [];
      for(XFile file in images!){
        List<int> imageBytes = await file.readAsBytes();
        print('xxxxxxxxxxx type : ${file.runtimeType} xxxxxxxxxxxxx');
        base64Images.add('data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}');
        print(file.path.split('.').last);
        imagePaths.add(file.path);
      }

      // images2 = await (ImagePicker.platform.pickMultiImage(imageQuality: 100));
      setState(() {

      });

      // return imagePaths;
      return base64Images;
    }
  }

  //......... Location search ................
  List<PlacesSearchResult> placesSearchResult = [];
  static const kGoogleApiKey = "AIzaSyATgI95Rp6YpYchbA6c8rD-3tC9xRIc96c";
  final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  late PlacesSearchResponse response;
  Future<List<PlacesSearchResult>> getPlaces(text) async {
    await places.searchByText(text).then((value){
      print(value.status);
      print("${value.results.length}");
      if (value.results.isNotEmpty) {
        return value.results;
      }
    });

    return placesSearchResult;
  }

  //........... Use Current Location ............
  late Position currentPosition;
  String? currentAddress;
  String? fullAddress;
  void getCurrentLocation() async {
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: false)
          .then((Position position) {
        currentPosition = position;
        getAddressFromLatLng();
        print('${currentPosition.latitude} ${currentPosition.longitude}');
      }).catchError((e) {
        print(e);
        Utils.showSnackBar(context,'Please Turn On Your Mobile Location');
      });
    }  else if (status.isPermanentlyDenied) {
      await openAppSettings();
      getCurrentLocation();
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      Future.delayed(const Duration(seconds: 1)).then((value) => getCurrentLocation());
    }
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = placemarks[0];

      /// postal code, locality, country
      Placemark place1 = placemarks[1];

      /// street name block - D
      Placemark place2 = placemarks[2];

      /// name holding no 21,
      Placemark place4 = placemarks[4];

      /// name banani model town
      ///
      /// 358/A, Ahmed Nagar, Mirpur-1, Dhaka 1216-984378349,789392454 next target
      currentAddress = place1.toString();
      fullAddress = '${place1.street}, ${place4.name} - ${place.postalCode}. ${place.locality}, ${place.country}';
      final bloc = context.read<PostAdBloc>();
      bloc.locationController.text = '$fullAddress';
      bloc.add(PostAdEventLocation(bloc.locationController.text));
      if (kDebugMode) {
        print('$fullAddress');
      }
    } on PermissionDeniedException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Utils.showSnackBar(context,'$e');
    } on LocationServiceDisabledException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Utils.showSnackBar(context,'$e');
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
      Utils.showSnackBar(context,'$e');
    }
  }
}
