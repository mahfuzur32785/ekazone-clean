import 'dart:convert';
import 'dart:io';

import 'package:ekayzone/modules/ads/new_ad_edit/component/category_fileds/education.dart';
import 'package:ekayzone/modules/animated_splash/controller/app_setting_cubit.dart';
import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:ekayzone/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/remote_urls.dart';
import '../../../../utils/constants.dart';
// import '../../../new_post_ad/controller/new_postad_bloc.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_image.dart';
import '../../../ad_details/model/ad_details_model.dart';
import '../../../home/model/ad_model.dart';
import '../../../home/model/category_model.dart';
import '../../../new_post_ad/component/category_fileds/service_field.dart';
import '../../../post_ad/controller/postad_bloc.dart';
import '../controller/new_ad_edit_bloc.dart';
import 'category_fileds/common_fields.dart';
import 'category_fileds/electronics.dart';
import 'category_fileds/jobs.dart';
import 'category_fileds/property.dart';
import 'category_fileds/vehicles.dart';

import 'package:http/http.dart' as http;


class NewEditBasicInfoView extends StatefulWidget {
  const NewEditBasicInfoView({Key? key, required this.adModel}) : super(key: key);
  final AdDetails adModel;
  @override
  State<NewEditBasicInfoView> createState() => _NewEditBasicInfoViewState();
}

class _NewEditBasicInfoViewState extends State<NewEditBasicInfoView> {

  Brand? subCategory;

  List<Gallery> imageGallery = [];
  List<String> deletedImages = [];

  String? thumbnail;

  @override
  void initState() {
    super.initState();
    imageGallery = widget.adModel.galleries.isEmpty ? [] : widget.adModel.galleries;
    print('Image Galary: ${imageGallery.length}');

    thumbnail = widget.adModel.thumbnail == '' ? '' : widget.adModel.thumbnail;
    print('Image thumbnil is : ${thumbnail?.isNotEmpty}');
  }

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
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
                  ///TITLE
                  const Row(
                    children: [
                      Text("Title"),
                      Text("*",style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  const SizedBox(height: 6,),
                  BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                    buildWhen: (previous, current) => previous.title != current.title,
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
                        onChanged: (value) => postAdBloc.add(NewEditAdEventName(value)),
                        decoration: const InputDecoration(hintText: "Title"),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  ///SUB CATEGORY
                  const Text("Sub Category"),
                  const SizedBox(height: 6,),
                  BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
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
                            postAdBloc.add(NewEditAdEventSubCategory(value!.id.toString(),value));
                          },
                        );
                      }
                  ),
                  const SizedBox(height: 16),

                  ///location
                  const Text("Location"),
                  const SizedBox(height: 6),
                  BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
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
                            (Prediction suggestion) async{
                          postAdBloc.add(NewEditAdEventLocation(suggestion.description.toString().trim().substring(0, suggestion.description.toString().trim().indexOf(','))));
                          final location = await getLocation(suggestion.description.toString().trim().substring(0, suggestion.description.toString().trim().indexOf(',')), 'locality', "AIzaSyCGYnCh2Uusd7iASDhsUCxvbFgkSifkkTM");
                          print('Lat & Lang is: ${location['lat']} ${location['lng']}');
                          // postAdBloc.add(NewPostAdEventLatLng('${suggestion.geometry?.location.lat}', '${suggestion.geometry?.location.lng}'));
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

                  ///PRICE
                  BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                    buildWhen: (previous, current) => previous.price != current.price,
                    builder: (context, state) {
                      if (state.category != '9') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            const Text("Price"),
                            const SizedBox(height: 6,),
                            BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => postAdBloc.add(NewEditAdEventPrice(value)),
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
                  const SizedBox(
                    height: 16,
                  ),

                  // const Text("Category*"),
                  // const SizedBox(height: 6,),
                  // BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                  //     buildWhen: (previous, current) => previous.category != current.category,
                  //     builder: (context, state) {
                  //     return DropdownButtonFormField<Category>(
                  //       isExpanded: true,
                  //       decoration: const InputDecoration(
                  //         hintText: "Category",
                  //       ),
                  //       items: postAdBloc.categoryList.map<DropdownMenuItem<Category>>((e) {
                  //         return DropdownMenuItem<Category>(
                  //           value: e,
                  //           child: Text(e.name),
                  //         );
                  //     }).toList(),
                  //       validator: (value){
                  //         if (value == null) {
                  //           return "Select Category";
                  //         }
                  //       },
                  //       onChanged: (Category? value) {
                  //         // setState(() {
                  //         //   subCategory = null;
                  //         //   postAdBloc.subCategoryList = [];
                  //         // });
                  //         Future.delayed(const Duration(milliseconds: 300)).then((value2) {
                  //           postAdBloc.add(NewEditAdEventCategory(value!.id.toString()));
                  //           if (value.haseCustomField) {
                  //             postAdBloc.customFieldDataModel = null;
                  //             postAdBloc.add(NewEditAdEventGetCustomFieldData(value.slug));
                  //           }
                  //         });
                  //       },
                  //     );
                  //   }
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),

                  ///Category wise design start from here
                  BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {

                      print("Category id is: ${state.category}");

                      if (state.category == '22') {
                        return EditAutomobileField(adModel: widget.adModel, categoryId: '22');
                      }
                      if (state.category == '9') {
                        return EditPropertyField(adModel: widget.adModel,);
                      }

                      if (state.category == '13') {
                        return EditEducationsField(adModel: widget.adModel,);
                      }
                      if (state.category == '7') {
                        return EditElectronicsField(adModel: widget.adModel,);
                      }
                      if (state.category == '18') {
                        return EditJobsField(adModel: widget.adModel);
                      }
                      return const SizedBox();
                    },
                  ),


                  ///DESCRIPTIONS
                  const Row(
                    children: [
                      Text("Description"),
                      Text("*",style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  const SizedBox(height: 6),
                  BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
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
                            postAdBloc.add(NewEditAdEventDescription(value)),
                        decoration:
                        const InputDecoration(hintText: "Description"),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  ///Featured Image
                  const Text("Featured Image"),
                  const SizedBox(height: 6),
                  BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                    buildWhen: (previous, current) =>
                    previous.thumbnail != current.thumbnail,
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                pickImage().then((value) {
                                  postAdBloc.add(NewEditAdEventFeatureImage(value ?? ''));
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
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (p0, p1) {
                                if (featureImage == null) {
                                  if (thumbnail != null) {
                                    return Center(
                                      child: SizedBox(
                                        height: 70,
                                        width: 70,
                                        child: Image(
                                          image: NetworkImage(
                                              "${RemoteUrls.rootUrl}$thumbnail"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                } else {
                                  return Center(
                                    child: SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: Image(
                                        // image: FileImage(File(controller.images2![index].path))
                                        image: FileImage(File("$featureImage")),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          // featureImage != null ? Expanded(child: SizedBox(child: Text("$base64featureImage", overflow: TextOverflow.ellipsis,),)) : Container(),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  /// ............. I M A G E ...............
                  const Text("Gallery Images  (Can add up to 5 only photos)"),
                  const SizedBox(height: 16),
                  ///.............. Old Images ..............
                  Visibility(
                    visible: imageGallery.isNotEmpty,
                    // visible: true,
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (_, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    color: ashTextColor.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(3)
                                ),
                                child: CustomImage(
                                  path: "${RemoteUrls.rootUrl}${imageGallery[index].image}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.black87.withOpacity(0.6),
                              shape: const CircleBorder(),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: (){
                                  deletedImages.add(imageGallery[index].id.toString());
                                  postAdBloc.add(NewEditAdEventDeleteImage(deletedImages));
                                  setState(() {
                                    imageGallery.removeAt(index);
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.delete,size: 24,color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: imageGallery.length,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                                postAdBloc.add(NewEditAdEventImages(value ?? []));
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

                  ///Contact Information's
                  BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {
                      if (state.category != '10') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            const Text("Contact Information",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

                            const SizedBox(height: 7),
                            ///Phone
                            Row(
                              children: [
                                BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                                    buildWhen: (previous, current) => previous.isShowPhone != current.isShowPhone,
                                    builder: (context, state) {
                                      print("Show phone value ${state.isShowPhone}");
                                      return SizedBox(
                                        width: 30,
                                        height: 24,
                                        child: Checkbox(
                                          value: state.isShowPhone,
                                          onChanged: (value){
                                            postAdBloc.add(NewEditAdEventShowPhone(value!));
                                          },activeColor: const Color(0xFF0b5ed7),),
                                      );
                                    }
                                ),
                                const SizedBox(width: 0,),
                                const Text("Show phone to public",style: TextStyle(fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
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
                                    BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                                      buildWhen: (previous, current) => previous.phone != current.phone,
                                      builder: (context, state) {
                                        return TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          controller: postAdBloc.phoneController,
                                          textInputAction: TextInputAction.next,
                                          onChanged: (value) => postAdBloc.add(NewEditAdEventPhone(value)),
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
                                BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                                    buildWhen: (previous, current) => previous.isShowEmail != current.isShowEmail,
                                    builder: (context, state) {
                                      return SizedBox(
                                        width: 30,
                                        height: 24,
                                        child: Checkbox(
                                            value: state.isShowEmail,
                                            onChanged: (value){
                                              postAdBloc.add(NewEditAdEventShowEmail(value!));
                                            },activeColor: const Color(0xFF0b5ed7)),
                                      );
                                    }
                                ),
                                const SizedBox(width: 0,),
                                const Text("Show email to public",style: TextStyle(fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
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
                                    BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                                      buildWhen: (previous, current) => previous.email != current.email,
                                      builder: (context, state) {
                                        return TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          controller: postAdBloc.emailController,
                                          textInputAction: TextInputAction.next,
                                          onChanged: (value) => postAdBloc.add(NewEditAdEventEmail(value)),
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
                                BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                                    buildWhen: (previous, current) => previous.isShowWhatsapp != current.isShowWhatsapp,
                                    builder: (context, state) {
                                      return SizedBox(
                                        width: 30,
                                        height: 24,
                                        child: Checkbox(
                                            value: state.isShowWhatsapp,
                                            onChanged: (value){
                                              postAdBloc.add(NewEditAdEventShowWhatsapp(value!));
                                            },activeColor: const Color(0xFF0b5ed7)),
                                      );
                                    }
                                ),
                                const SizedBox(width: 0,),
                                const Text("Show Whatsapp to Public",style: TextStyle(fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                              buildWhen: (previous, current) => previous.whatsapp != current.whatsapp,
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Whatsapp",style: TextStyle(fontSize: 16),),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      // initialValue: state.weChat,
                                      controller: postAdBloc.whatsappController,
                                      textInputAction: TextInputAction.next,
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return null;
                                      //     // return 'Enter Your WeChat Number';
                                      //   }
                                      //   return null;
                                      // },
                                      onChanged: (value) => postAdBloc.add(NewEditAdEventWhatsapp(value)),
                                      decoration: const InputDecoration(hintText: "Whatsapp"),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),

                  const SizedBox(height: 16),

                  ///Website
                  BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {
                      if (state.category != '18') {

                        print('CategoryId is: ${state.category}');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Website"),
                            const SizedBox(height: 6,),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.url,
                              controller: postAdBloc.webSiteController,
                              onChanged: (value) {
                                postAdBloc.add(NewEditAdEventWebsiteValue(value));
                              },
                              decoration: const InputDecoration(
                                hintText:
                                "Website",
                              ),
                            ),

                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 16),

                  Visibility(
                    visible: widget.adModel.status == 'active',
                    //visible: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Status",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                          buildWhen: (previous, current) =>
                          previous.status != current.status,
                          builder: (context, state) {
                            return DropdownButtonFormField(
                              value: statusEditType,
                              decoration: const InputDecoration(
                                hintText:
                                "Select One",
                              ),
                              items: statusTypeEditList.map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem(
                                  value: e['value'],
                                  child: Text("${e['title']}"),
                                );
                              }).toList(),
                              onChanged: (value) {
                                statusEditType = value!;
                                postAdBloc.add(NewEditAdEventStatusType(value));
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
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

  String? statusEditType;



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

  /// .................... Photo Picker ...................
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
