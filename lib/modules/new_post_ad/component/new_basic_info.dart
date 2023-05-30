import 'dart:convert';
import 'dart:io';

import 'package:ekayzone/modules/animated_splash/controller/app_setting_cubit.dart';
import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:ekayzone/modules/home/model/model_model.dart';
import 'package:ekayzone/modules/home/model/pricing_model.dart';
import 'package:ekayzone/modules/new_post_ad/component/category_fileds/education_feild.dart';
import 'package:ekayzone/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ekayzone/modules/home/model/category_model.dart';
import 'package:ekayzone/modules/new_post_ad/component/category_fileds/jobs.dart';
import 'package:ekayzone/modules/post_ad/controller/postad_bloc.dart';


import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../controller/new_posted_bloc.dart';
import 'category_fileds/electronics.dart';
import 'category_fileds/property.dart';
import 'category_fileds/service_field.dart';
import 'category_fileds/vehicles.dart';

import 'package:http/http.dart' as http;

class NewBasicInfoView extends StatefulWidget {
  const NewBasicInfoView({Key? key}) : super(key: key);

  @override
  State<NewBasicInfoView> createState() => _NewBasicInfoViewState();
}

class _NewBasicInfoViewState extends State<NewBasicInfoView> {

  bool isFeature = false;

  Brand? subCategory;

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
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
                  ///title
                  const Row(
                    children: [
                      Text("Title"),
                      Text("*",style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  const SizedBox(height: 6,),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.name != current.name,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.name,
                        // initialValue: state.name,
                        controller: postAdBloc.titleController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter title';
                          }
                          return null;
                        },
                        onChanged: (value) => postAdBloc.add(NewPostAdEventName(value)),
                        decoration: const InputDecoration(hintText: "Title"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ///sub-category
                  const Text("Sub category"),
                  const SizedBox(height: 6,),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                      buildWhen: (previous, current) => previous.subCategory != current.subCategory,
                      builder: (context, state) {
                        return DropdownButtonFormField<Brand>(
                          isExpanded: true,
                          decoration: const InputDecoration(
                            hintText: "Sub Category",
                          ),
                          value: postAdBloc.subCategory,
                          items: postAdBloc.subCategoryList.map<DropdownMenuItem<Brand>>((e) {
                            return DropdownMenuItem<Brand>(
                              value: e,
                              child: Text(e.name),
                            );
                          }).toList(),
                          // validator: (value){
                          //   if (postAdBloc.subCategoryList.isNotEmpty && value == null) {
                          //     return null;
                          //   }
                          //   return null;
                          // },
                          onChanged: (Brand? value) {
                            setState(() {
                              subCategory = null;
                            });
                            postAdBloc.add(NewPostAdEventSubCategory(value!.id.toString(),value));
                          },
                        );
                      }
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ///location
                  const Text("Location"),
                  const SizedBox(height: 6,),
                  BlocBuilder<PostAdBloc, PostAdModalState>(
                    buildWhen: (previous, current) => previous.location != current.location,
                    builder: (context, state) {
                      return TypeAheadFormField(
                        textFieldConfiguration:
                        TextFieldConfiguration(
                          // onChanged: (value){
                          //   createDirectoryBloc.add(CreateDirectoryEventLocation(value.trim()));
                          // },
                            controller: postAdBloc
                                .locationController,
                            decoration: const InputDecoration(
                                hintText: 'Your Location')),
                        suggestionsCallback: (pattern) async {
                          await getPlaces(pattern,
                              context.read<HomeControllerCubit>().updatedCountry.toString().isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() : context.read<HomeControllerCubit>().updatedCountry);
                          // getPlaces(pattern).then((value) {
                          //   placesSearchResult = value;
                          // });
                          return placesSearchResult
                              .where((element) => element.description!
                              .toLowerCase()
                              .contains(pattern
                              .toString()
                              .toLowerCase()))
                              .take(10)
                              .toList();
                          // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text("${suggestion.description.toString().trim()}"),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected:
                            (Prediction suggestion) async {
                              postAdBloc.add(NewPostAdEventLocation(suggestion.description.toString().trim().substring(0, suggestion.description.toString().trim().indexOf(','))));
                              final location = await getLocation(suggestion.description.toString().trim().substring(0, suggestion.description.toString().trim().indexOf(',')), 'locality', "AIzaSyCGYnCh2Uusd7iASDhsUCxvbFgkSifkkTM");

                              print('Lat & Lang is: ${location['lat']} ${location['lng']}');
                          postAdBloc.add(NewPostAdEventLatLng("${location['lat']}", "${location['lat']}"));
                        },
                        // validator: (value) {
                        //   if (postAdBloc.state.location ==
                        //       '') {
                        //     return 'Enter Your Location';
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        onSaved: (value) {},
                      );
                    },
                  ),

                  ///Price
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {
                      if (state.category != '2' && state.category != '10' && state.category != '9') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            const Text("Price"),
                            const SizedBox(height: 6,),
                            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                              buildWhen: (previous, current) => previous.price != current.price,
                              builder: (context, state) {
                                return TextFormField(
                                  keyboardType: TextInputType.number,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  // initialValue: state.price,
                                  controller: postAdBloc.priceController,
                                  textInputAction: TextInputAction.next,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return null;
                                  //   }
                                  //   return null;
                                  // },
                                  onChanged: (value) => postAdBloc.add(NewPostAdEventPrice(value)),
                                  decoration: const InputDecoration(hintText: "Price"),
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),

                  ///Category wise design start from here
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {
                      if (state.category == '22') {
                        return const AutoMobileField(categoryId: '22');
                      }
                      if (state.category == '9') {
                        return const PropertyField();
                      }
                      if (state.category == '7') {
                        return const ElectronicsField();
                      }
                      if (state.category == '18') {
                        return const JobsField();
                      }
                      if (state.category == '13') {
                        return const EducationField();
                      }
                      return const SizedBox();
                    },
                  ),

                  ///Description and image section

                  ///Description
                  const SizedBox(height: 16,),
                  const Row(
                    children: [
                      Text("Description"),
                      Text("*",style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) =>
                    previous.description != current.description,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        // initialValue: state.description,
                        controller: postAdBloc.descriptionController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            postAdBloc.add(NewPostAdEventDescription(value)),
                        decoration:
                        const InputDecoration(hintText: "Description"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  const Text("Featured Image"),
                  const SizedBox(
                    height: 6,
                  ),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) =>
                    previous.thumbnail != current.thumbnail,
                    builder: (context, state) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              pickImage().then((value) {
                                postAdBloc.add(NewPostAdEventFeatureImage(value ?? ''));
                              });
                            },
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueGrey.shade100,
                              ),
                              alignment: Alignment.center,
                              child: const Text("Choose File"),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          featureImage != null ? Expanded(child: SizedBox(child: Text("$base64featureImage", overflow: TextOverflow.ellipsis,),)) : Container(),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  ///Images
                  const Text("Gallery Images  (Can add up to 5 only photos)"),
                  const SizedBox(
                    height: 16,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                            onTap: () {
                              pickImages().then((value) {
                                postAdBloc.add(NewPostAdEventImages(value ?? []));
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: ashColor),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_circle_outlined,
                                  color: redColor,
                                ),
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
                              borderRadius: BorderRadius.circular(3)),
                          child: Image(
                            // image: FileImage(File(controller.images2![index].path))
                            image: FileImage(File(images![index - 1].path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: images!.length + 1,
                  ),

                  ///Contact info phone email
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            const Text("Contact information",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(
                              height: 16,
                            ),
                            ///Phone
                            Row(
                              children: [
                                BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                    buildWhen: (previous, current) => previous.isShowPhone != current.isShowPhone,
                                    builder: (context, state) {
                                      print("Show phone value ${state.isShowPhone}");
                                      return SizedBox(
                                        width: 30,
                                        height: 24,
                                        child: Checkbox(
                                            value: state.isShowPhone,
                                            onChanged: (value){
                                              postAdBloc.add(NewPostAdEventShowPhone(value!));
                                            },activeColor: const Color(0xFF0b5ed7),
                                        ),
                                      );
                                    }
                                ),
                                const SizedBox(width: 0,),
                                const Text("Show phone to public",style: TextStyle(fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                              buildWhen: (previous, current) => previous.isShowPhone != current.isShowPhone,
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Phone",style: TextStyle(fontSize: 16),),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                      buildWhen: (previous, current) => previous.phone != current.phone,
                                      builder: (context, state) {
                                        return TextFormField(
                                          keyboardType: TextInputType.number,
                                          // initialValue: state.phone,
                                          controller: postAdBloc.phoneController,
                                          textInputAction: TextInputAction.next,
                                          // validator: (value) {
                                          //   if (value == null && state.isShowPhone) {
                                          //     return "Phone field is required";
                                          //   }
                                          //   return null;
                                          // },
                                          onChanged: (value) => postAdBloc.add(NewPostAdEventPhone(value)),
                                          decoration: const InputDecoration(hintText: "Phone"),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                );
                              },
                            ),

                            ///Email
                            Row(
                              children: [
                                BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                    buildWhen: (previous, current) => previous.isShowEmail != current.isShowEmail,
                                    builder: (context, state) {
                                      print("Show Email value ${state.isShowEmail}");
                                      return SizedBox(
                                        width: 30,
                                        height: 24,
                                        child: Checkbox(
                                            value: state.isShowEmail,
                                            onChanged: (value){
                                              postAdBloc.add(NewPostAdEventShowEmail(value!));
                                            },activeColor: const Color(0xFF0b5ed7),),
                                      );
                                    }
                                ),
                                const SizedBox(width: 0,),
                                const Text("Show email to public",style: TextStyle(fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                              buildWhen: (previous, current) => previous.isShowEmail != current.isShowEmail,
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Email",style: TextStyle(fontSize: 16),),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                      buildWhen: (previous, current) => previous.email != current.email,
                                      builder: (context, state) {
                                        return TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          // initialValue: state.phone,
                                          controller: postAdBloc.emailController,
                                          textInputAction: TextInputAction.next,
                                          // validator: (value) {
                                          //   if (value == null && state.isShowEmail) {
                                          //     return "Email field is required";
                                          //   }
                                          //   return null;
                                          // },
                                          onChanged: (value) => postAdBloc.add(NewPostAdEventEmail(value)),
                                          decoration: const InputDecoration(hintText: "Email"),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                );
                              },
                            ),

                            ///Whatsapp
                            Row(
                              children: [
                                BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                    buildWhen: (previous, current) => previous.isShowWhatsapp != current.isShowWhatsapp,
                                    builder: (context, state) {
                                      print("Show Whatsapp value ${state.isShowWhatsapp}");
                                      return SizedBox(
                                        width: 30,
                                        height: 24,
                                        child: Checkbox(
                                            value: state.isShowWhatsapp,
                                            onChanged: (value){
                                              postAdBloc.add(NewPostAdEventShowWhatsapp(value!));
                                            },activeColor: const Color(0xFF0b5ed7),),
                                      );
                                    }
                                ),
                                const SizedBox(width: 0,),
                                const Text("Show Whatsapp to public",style: TextStyle(fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                              buildWhen: (previous, current) => previous.isShowWhatsapp != current.isShowWhatsapp,
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Whatsapp",style: TextStyle(fontSize: 16),),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                      buildWhen: (previous, current) => previous.whatsapp != current.whatsapp,
                                      builder: (context, state) {
                                        return TextFormField(
                                          keyboardType: TextInputType.number,
                                          // initialValue: state.phone,
                                          controller: postAdBloc.whatsappController,
                                          textInputAction: TextInputAction.next,
                                          // validator: (value) {
                                          //   if (value == null && state.isShowEmail) {
                                          //     return "Email field is required";
                                          //   }
                                          //   return null;
                                          // },
                                          onChanged: (value) => postAdBloc.add(NewPostAdEventWhatsapp(value)),
                                          decoration: const InputDecoration(hintText: "Whatsapp"),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                    },
                  ),

                  ///Website
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {
                      if (state.category != '18') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Website"),
                            const SizedBox(height: 6,),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              // initialValue: state.weChat,
                              controller: postAdBloc.webSiteController,
                              textInputAction: TextInputAction.next,
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return null;
                              //     // return 'Enter Your WeChat Number';
                              //   }
                              //   return null;
                              // },
                              onChanged: (value) => postAdBloc.add(NewPostAdEventWebsite(value)),
                              decoration: const InputDecoration(hintText: "Website"),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  ///Payment for feature ads
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300,
                    ),
                    child: Row(
                      children: [
                        Checkbox(value: postAdBloc.isPaymentChecked, onChanged: (value) {
                          setState(() {
                            postAdBloc.isPaymentChecked = !postAdBloc.isPaymentChecked;
                            print("Payment is Checked ${postAdBloc.isPaymentChecked}");
                          });
                        },activeColor: const Color(0xFF0b5ed7),),
                        const SizedBox(width: 5,),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mark as featured \$ ${postAdBloc.price}.00",style: const TextStyle(fontWeight: FontWeight.bold),),
                                const SizedBox(
                                    child: Text("Make your listing unique on home and search page!",overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                const SizedBox(height: 10,),

                                DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return null;
                                    }
                                    return null;
                                  },
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                    hintText: "Select Plan",
                                  ),
                                  items:
                                  postAdBloc.pricingList.map<DropdownMenuItem<PricingModel>>((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text("${e.title} for \$ ${e.price}.00"),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      postAdBloc.id = value!.id;
                                      postAdBloc.title = value.title;
                                      postAdBloc.price = value.price;
                                    });
                                  },
                                )

                                /*Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300)
                                  ),
                                  child: const Text("1 week for R177.00"),
                                )*/
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  bool isPayment = false;

  //.............. contacts info ....................
  List<String> featureList = [""];
  var contactController = TextEditingController();
  void addContact() {
    setState(() {
      featureList.add("");
    });
  }

  void removeContact(index) {
    setState(() {
      featureList.removeAt(index);
    });
  }

  String getPosition(index) {
    switch (index) {
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

  ///......... Location search ................
  List<Prediction> placesSearchResult = [];
  static const kGoogleApiKey = "AIzaSyCGYnCh2Uusd7iASDhsUCxvbFgkSifkkTM";
  // static const kGoogleApiKey = "AIzaSyA72zy8Wy4kFpom_brg28OqBOa8S0eXXGY";
  final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  late PlacesSearchResponse response;
  Future<List<Prediction>> getPlaces(text, countryCode) async {
    await places.autocomplete(text, types: ['locality'],components: [Component(Component.country, countryCode.toString())], radius: 1000).then((value) {
      print("Values are ${value.status}");
      placesSearchResult = value.predictions;
      print("${value.predictions.length}");
      if (value.predictions.isNotEmpty) {
        print(value.predictions.map((e) => e.description!.log()));
        placesSearchResult = value.predictions;
      }
    });

    return placesSearchResult;
  }

  /// ....................Feature Photo Picker ...................
  String? originalImage;
  String? featureImage;
  String? base64featureImage;
  pickImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalImage = value;
        File file = File(originalImage!);
        if (file != null) {
          featureImage = file.path;
          List<int> imageBytes = await file.readAsBytes();
          base64featureImage = 'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';

          print("feature image is: ${base64featureImage}");
          // context.read<AdEditProfileCubit>().base64Image = base64Image!;
        }
      }
    });
    setState(() {});
    return base64featureImage;
  }

  /// ....................Gallery Photo Picker ...................
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
      for (XFile file in images!) {
        List<int> imageBytes = await file.readAsBytes();
        print('xxxxxxxxxxx type : ${file.runtimeType} xxxxxxxxxxxxx');
        base64Images.add(
            'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}');
        print(file.path.split('.').last);
        imagePaths.add(file.path);
      }

      // images2 = await (ImagePicker.platform.pickMultiImage(imageQuality: 100));
      setState(() {});

      // return imagePaths;
      return base64Images;
    }
  }

  Future<Map<String, dynamic>> getLocation(String query, String placeType, String apiKey) async {
    final url = Uri.https('maps.googleapis.com', '/maps/api/place/textsearch/json', {
      'query': query,
      'type': placeType,
      'key': apiKey,
    });
    final response = await http.get(url);
    final body = json.decode(response.body);
    return body['results'][0]['geometry']['location'];
  }

}
