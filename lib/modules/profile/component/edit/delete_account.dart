import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/edit_profile/ads_edit_profile_cubit.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdEditProfileCubit>();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 5))
            ]),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text(
                    "Deactivate Account",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                )),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "By clicking below button your account will be deleted permanently. You won't able to retrieve your account anymore.",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black45),
                  ),
                )),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 48,
              child: BlocBuilder<AdEditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    if (state is EditProfileStateDeleteLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          shadowColor: ashColor,
                          side: const BorderSide(
                              color: Colors.red,
                              strokeAlign: BorderSide.strokeAlignInside),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      onPressed: () {
                        Utils.showCustomDialog(
                            context,
                            child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  height: 320,
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Type 'delete' to delete your account.",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Center(
                                        child: Text(
                                          "All contacts and other data associated with this account will be permanently deleted. This cannot be undone.",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        validator: (value) {
                                          if (value != null || value!.isNotEmpty) {
                                            setState(() {
                                              bloc.deleteController.text = value.toString();
                                              bloc.isError = false;
                                            });
                                          }
                                          setState(() {
                                            bloc.isError = true;
                                          });
                                        },
                                        controller: bloc.deleteController,
                                        decoration: const InputDecoration(
                                            hintText: "Type 'delete' to delete your account.",
                                            hintStyle: TextStyle(fontSize: 12)
                                        ),
                                      ),

                                      Visibility(visible: bloc.isError == true,child: const Align(alignment: Alignment.centerLeft,child: Column(
                                        children: [
                                          SizedBox(height: 5,),
                                          Text("This field is required",style: TextStyle(color: Colors.red),),
                                        ],
                                      ))),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: redColor),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: redColor),
                                            onPressed: () {
                                              if(bloc.deleteController.text.isNotEmpty){
                                                setState(() {
                                                  bloc.isError = false;
                                                });
                                                Navigator.pop(context);
                                                bloc.deleteAccount(bloc.deleteController.text.trim());
                                              }else{
                                                setState(() {
                                                  bloc.isError = true;
                                                });
                                                print('this filed is required ${bloc.isError}');
                                              }
                                            },
                                            child: const Text("Ok"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                            ),

                            barrierDismissible: true
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: const Text(
                        "Delete account",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w400),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
