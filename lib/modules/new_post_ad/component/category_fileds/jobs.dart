import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants.dart';
import '../../../home/model/model_model.dart';
import '../../controller/new_posted_bloc.dart';

class JobsField extends StatefulWidget {
  const JobsField({Key? key}) : super(key: key);

  @override
  State<JobsField> createState() => _JobsFieldState();
}

class _JobsFieldState extends State<JobsField> {

  String jobType = jobTypeList[0];
  String education = educationList[0];
  bool applicationAlertEmail = true;
  bool applicationAlertPhone = true;

  String groupValue = '';

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const Text("Designation",style: TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
          buildWhen: (previous, current) => previous.designation != current.designation,
          builder: (context, state) {
            return DropdownButtonFormField(
              // validator: (value) {
              //   if (value == null) {
              //     return null;
              //   }
              //   return null;
              // },
              isExpanded: true,
              decoration: const InputDecoration(
                hintText: "Select Designation",
              ),
              items:
              postAdBloc.designationList.map<DropdownMenuItem<Model>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.title),
                );
              }).toList(),
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 300)).then(
                      (value2) {
                    postAdBloc.add(
                        NewPostAdEventEmployerDesignation(value!.title.toString()));
                  },
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        const Text("Job type",style: TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        DropdownButtonFormField(
          // validator: (value) {
          //   if (value == null) {
          //     return null;
          //   }
          //   return null;
          // },
          decoration: const InputDecoration(
            hintText: "Select job type",
          ),
          items: jobTypeList.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
            jobType = value!;
            postAdBloc.add(NewPostAdEventJobType(value));
          },
        ),
        const SizedBox(
          height: 16,
        ),
        const Text("How do you want to receive applications?",style: TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                buildWhen: (previous, current) => previous.receiveIsEmail != current.receiveIsEmail,
                builder: (context, state) {
                  return SizedBox(
                    width: 30,
                    height: 24,
                    child: Checkbox(
                        value: state.receiveIsEmail,
                        onChanged: (value){
                          postAdBloc.add(NewPostAdEventApplicationReceivedInEmail(value!));
                        },activeColor: const Color(0xFF0b5ed7),),
                  );
                }
            ),
            const SizedBox(width: 0,),
            const Text("Email and employer dashboard",style: TextStyle(fontSize: 16),),
          ],
        ),

        Row(
          children: [
            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                buildWhen: (previous, current) => previous.receiveIsPhone != current.receiveIsPhone,
                builder: (context, state) {
                  return SizedBox(
                    width: 30,
                    height: 24,
                    child: Checkbox(
                        value: state.receiveIsPhone,
                        onChanged: (value){
                          postAdBloc.add(NewPostAdEventApplicationReceivedInPhone(value!));
                        },activeColor: const Color(0xFF0b5ed7),),
                  );
                }
            ),
            const SizedBox(width: 0,),
            const Text("Employer Phone",style: TextStyle(fontSize: 16),),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
          buildWhen: (previous, current) => previous.receiveIsEmail != current.receiveIsEmail,
          builder: (context, state) {
            return Visibility(
              visible: state.receiveIsEmail,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn,
                opacity: state.receiveIsEmail ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Employer email",style: TextStyle(fontSize: 16),),
                    const SizedBox(
                      height: 7,
                    ),
                    BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                      buildWhen: (previous, current) => previous.email != current.email,
                      builder: (context, state) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          // initialValue: state.phone,
                          controller: postAdBloc.employerEmailController,
                          textInputAction: TextInputAction.next,
                          // validator: (value) {
                          //   if (value == null && state.isShowEmail) {
                          //     return 'Enter Email Address';
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
                ),
              ),
            );
          },
        ),
        BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
          buildWhen: (previous, current) => previous.receiveIsPhone != current.receiveIsPhone,
          builder: (context, state) {
            return Visibility(
              visible: state.receiveIsPhone,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn,
                opacity: state.receiveIsPhone ? 1 : 0,
                child: Column(
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          // initialValue: state.phone,
                          controller: postAdBloc.employerPhoneController,
                          textInputAction: TextInputAction.next,
                          // validator: (value) {
                          //   if (value == null && state.isShowPhone) {
                          //     return 'Enter Phone Number';
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
                ),
              ),
            );
          },
        ),
        const Text("Required work experience (years)",style: TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          // validator: (value) {
          //   if (value == "") {
          //     return null;
          //   }
          //   return null;
          // },
          onChanged: (value){
            postAdBloc.add(NewPostAdEventExperience(value));
          },
          decoration: const InputDecoration(
            hintText: "Years",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text("Required Education",style: TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        DropdownButtonFormField(
          // validator: (value) {
          //   if (value == null) {
          //     return null;
          //   }
          //   return null;
          // },
          decoration: const InputDecoration(
            hintText: "Select education",
          ),
          items: educationList.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
            education = value!;
            postAdBloc.add(NewPostAdEventEducations(education));
          },
        ),
        const SizedBox(
          height: 16,
        ),
        const Text("Salary per month",style: TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        const Row(
          children: [
            Expanded(
              child: Text("From",style: TextStyle(fontSize: 16),),
            ),
            Expanded(
              child: Text("To",style: TextStyle(fontSize: 16),),
            )
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                // validator: (value) {
                //   if (value == "") {
                //     return null;
                //   }
                //   return null;
                // },
                onChanged: (value){
                  postAdBloc.add(NewPostAdEventSalaryFrom(value));
                },
                decoration: const InputDecoration(
                  hintText: "From",
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                // validator: (value) {
                //   if (value == "") {
                //     return null;
                //   }
                //   return null;
                // },
                onChanged: (value){
                  postAdBloc.add(NewPostAdEventSalaryTo(value));
                },
                decoration: const InputDecoration(
                  hintText: "To",
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Text("Application deadline",style: TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.datetime,
          controller: expiryDateController,
          // validator: (value) {
          //   if (value == "") {
          //     return null;
          //   }
          //   return null;
          // },
          onChanged: (value){
            postAdBloc.add(NewPostAdEventDeadline(value));
          },
          readOnly: true,
          onTap: (){
            chooseDate(context);
          },
          decoration: const InputDecoration(
            hintText: "MM/DD/YYYY",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text("Employer Name",style: TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          controller: postAdBloc.employerNameController,
          // validator: (value) {
          //   if (value == "") {
          //     return null;
          //   }
          //   return null;
          // },
          onChanged: (value){
            postAdBloc.add(NewPostAdEventEmployerName(value));
          },
          decoration: const InputDecoration(
            hintText: "Employer Name",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text("Employer Website",style: TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.url,
          controller: postAdBloc.webSiteController,
          // validator: (value) {
          //   if (value == "") {
          //     return null;
          //   }
          //   return null;
          // },
          onChanged: (value){
            postAdBloc.add(NewPostAdEventWebsite(value));
          },
          decoration: const InputDecoration(
            hintText: "Employer Website",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: (){
                    pickImage().then((value) {
                      if (value != null) {
                        setState(() {
                          postAdBloc.add(NewPostAdEventEmployeeLogo(base64Image!));
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Attach Logo"),
            ),
              )
            ),
            Expanded(
              child: image == null ? const SizedBox() : Center(
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Image(
                    // image: FileImage(File(controller.images2![index].path))
                    image: FileImage(File(image!.path)),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  //............. Date Choose ...............
  final formatter = DateFormat('yyyy-MM-dd');
  var expiryDate;
  var expiryDateController = TextEditingController();
  DateTime expirySelectedDate = DateTime.now();
  chooseDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: expirySelectedDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2050),
        initialDatePickerMode: DatePickerMode.year,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Color(0xFF31A3DD),
                surface: Colors.white,
                onSurface: Color(0xFF000000),
              ),
              dialogBackgroundColor: const Color(0xFF31A3DD),
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      expirySelectedDate = newSelectedDate;
      expiryDateController
        ..text = formatter.format(expirySelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: expiryDateController.text.length,
            affinity: TextAffinity.upstream));
      expiryDate = expiryDateController.text;
      context.read<NewPostAdBloc>().add(NewPostAdEventDeadline(expiryDateController.text));
    }
  }

  // .................... Photo Picker ...................
  final ImagePicker picker = ImagePicker();
  XFile? image;
  String? base64Image;
  Future<String?> pickImage() async {
    String? imagePath;
    XFile? tempImage =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (tempImage == null) {
      print("Image doesn't choose!");
      return imagePath;
    } else {
      image = tempImage;
      List<int> imageBytes = await image!.readAsBytes();
      base64Image = 'data:image/${image!.path.split('.').last};base64,${base64Encode(imageBytes)}';
      // setState(() {});

      // return imagePaths;
      return base64Image;
    }
  }

}
