import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/utils/constants.dart';

import '../../controller/edit_profile/ads_edit_profile_cubit.dart';

class ChangePassEdit extends StatefulWidget {
  const ChangePassEdit({Key? key}) : super(key: key);

  @override
  State<ChangePassEdit> createState() => _ChangePassEditState();
}

class _ChangePassEditState extends State<ChangePassEdit> {
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
          key: bloc.chanePassFormKey,
          child: Column(
            children: [
              const Align(alignment: Alignment.centerLeft,child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    Text("Change password",textAlign: TextAlign.left,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    Text("*",style: TextStyle(color: Colors.red),)
                  ],
                ),
              )),
              const SizedBox(
                width: double.infinity,
                height: 16,
              ),
              const Align(alignment: Alignment.centerLeft,child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text("Current password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),textAlign: TextAlign.left,),
                    Text("*",style: TextStyle(color: Colors.red),)
                  ],
                ),
              )),
              TextFormField(
                controller: bloc.currentPassCtr,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter current password';
                  }else if (value.length < 8) {
                    return 'Enter Minimum 8 Character';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Current password",
                ),
              ),
              const Align(alignment: Alignment.centerLeft,child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text("New password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),textAlign: TextAlign.left,),
                    Text("*",style: TextStyle(color: Colors.red),)
                  ],
                ),
              )),
              TextFormField(
                controller: bloc.newPassCtr,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter new password';
                  }else if (value.length < 8) {
                    return 'Enter Minimum 8 Character';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "New password",
                ),
              ),
              const Align(alignment: Alignment.centerLeft,child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text("Confirm password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                    Text("*",style: TextStyle(color: Colors.red),)
                  ],
                ),
              )),
              TextFormField(
                controller: bloc.confirmPassCtr,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter confirm password';
                  }else if (value != bloc.newPassCtr.text) {
                    return 'Doesn\'t match password!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Confirm password",
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 48,
                child: BlocBuilder<AdEditProfileCubit,EditProfileState>(
                    builder: (context,state) {
                      if (state is EditProfileStatePasswordLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(foregroundColor: redColor,shadowColor: ashColor,side: const BorderSide(color: redColor,strokeAlign: BorderSide.strokeAlignInside),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      onPressed: (){
                        bloc.changePassword();
                      },
                      child: const Text("Save changes"),
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
