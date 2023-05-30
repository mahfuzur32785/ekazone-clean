import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ekayzone/modules/profile/controller/edit_profile/ads_edit_profile_cubit.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/k_images.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:ekayzone/widgets/custom_image.dart';

class BasicInfoEdit extends StatefulWidget {
  const BasicInfoEdit({Key? key}) : super(key: key);

  @override
  State<BasicInfoEdit> createState() => _BasicInfoEditState();
}

class _BasicInfoEditState extends State<BasicInfoEdit> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      final bloc = context.read<AdEditProfileCubit>();
      bloc.nameCtr.text = bloc.loginBloc.userInfo!.user.name;
      bloc.usernameCtr.text = bloc.loginBloc.userInfo!.user.username;
      bloc.phoneCtr.text = "${bloc.loginBloc.userInfo!.user.phone}";
      bloc.emailCtr.text = bloc.loginBloc.userInfo!.user.email;
      bloc.locationCtr.text = "${bloc.loginBloc.userInfo!.user.location}";
      // bloc.webSiteCtr.text = "${bloc.loginBloc.userInfo!.user.web}";
    });
  }

  // ............ photo ...............
  String? originalImage;
  String? image;
  String? base64Image;
  Future<void> chooseImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalImage = value;
        CroppedFile? file = await Utils.cropper(value,1.0,1.0);
        if (file != null) {
          image = file.path;
          List<int> imageBytes = await file.readAsBytes();
          base64Image = 'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';
          context.read<AdEditProfileCubit>().base64Image = base64Image!;
        }
      }
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdEditProfileCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0,5)
            )
          ]
      ),
      child: Form(
        key: bloc.formKey,
        child: Column(
          children: [
            const Align(alignment: Alignment.centerLeft,child: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text("Account information",textAlign: TextAlign.left,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
            )),
            SizedBox(
              height: 140,
              width: 140,
              child: Stack(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white,width: 4,strokeAlign: BorderSide.strokeAlignOutside),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 0)
                          ),
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 0)
                          ),
                        ]
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LayoutBuilder(
                            builder: (context,constraints) {
                              if (image == null) {
                                return CustomImage(
                                  path: bloc.loginBloc.userInfo!.user.imageUrl == '' ? null : '${bloc.loginBloc.userInfo!.user.imageUrl}',
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.cover,
                                );
                              }
                              return Image(image: FileImage(
                                File(image!),
                              ),fit: BoxFit.cover,);
                            }
                        )

                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white,width: 4)
                      ),
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: (){
                            chooseImage();
                          },
                          child: const FaIcon(FontAwesomeIcons.camera,size: 20,),
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 16,
            ),
            const Align(alignment: Alignment.centerLeft,child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text("Full name",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  Text("*",style: TextStyle(color: Colors.red),),
                ],
              ),
            )),
            TextFormField(
              controller: bloc.nameCtr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter name';
                }
                return null;
              },
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: "Enter your name",
              ),
            ),
            const Align(alignment: Alignment.centerLeft,child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text("Username",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  Text("*",style: TextStyle(color: Colors.red),),
                ],
              ),
            )),
            TextFormField(
              controller: bloc.usernameCtr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter username';
                }
                return null;
              },
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: "Enter your user name",
              ),
            ),
            const Align(alignment: Alignment.centerLeft,child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text("Email",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  Text("*",style: TextStyle(color: Colors.red),),
                ],
              ),
            )),
            TextFormField(
              controller: bloc.emailCtr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required email';
                } else if (!Utils.isEmail(value)) {
                  return 'Enter valid email';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter your email",
              ),
            ),
            const Align(alignment: Alignment.centerLeft,child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text("Phone",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  Text("*",style: TextStyle(color: Colors.red),),
                ],
              ),
            )),
            TextFormField(
              controller: bloc.phoneCtr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter phone';
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Enter your phone",
              ),
            ),

            const Align(alignment: Alignment.centerLeft,child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Location",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
            )),
            TextFormField(
              controller: bloc.locationCtr,
              decoration: const InputDecoration(
                hintText: "Enter your location",
              ),
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 48,
              child: BlocBuilder<AdEditProfileCubit,EditProfileState>(
                builder: (context,state) {
                  if (state is EditProfileStateAccLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(foregroundColor: redColor,shadowColor: ashColor,side: const BorderSide(width: 0.5,color: redColor,strokeAlign: BorderSide.strokeAlignInside),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                    onPressed: (){
                      bloc.updateAccInfo();
                    },
                    child: const Text("Save changes",style: TextStyle(color: redColor,fontWeight: FontWeight.w400),),
                  );
                }
              ),
            )
          ],
        ),
      )
    );
  }
}