import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../core/remote_urls.dart';
import '../../../../../utils/constants.dart';
import '../../../../ad_details/model/ad_details_model.dart';
import '../../../../home/model/model_model.dart';
import '../../../../new_post_ad/controller/new_posted_bloc.dart';
import '../../controller/new_ad_edit_bloc.dart';

class EditJobsField extends StatefulWidget {
  const EditJobsField({Key? key, required this.adModel}) : super(key: key);
  final AdDetails adModel;

  @override
  State<EditJobsField> createState() => _EditJobsFieldState();
}

class _EditJobsFieldState extends State<EditJobsField> {
  String jobType = jobTypeList[0];
  String education = educationList[0];
  bool applicationAlertEmail = true;
  bool applicationAlertPhone = true;

  Model? designationModel;

  String? employerLogoUrl;

  @override
  void initState() {
    employerLogoUrl = widget.adModel.employerLogo == null ? null : widget.adModel.employerLogo.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Designation",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) =>
          previous.designation != current.designation,
          builder: (context, state) {
            designationModel = state.designation == ""
                ? null
                : postAdBloc.designationList.singleWhere((element) =>
            state.designation == element.title.toString());
            return DropdownButtonFormField(
              value: designationModel,
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
                Future.delayed(const Duration(milliseconds: 300))
                    .then((value2) {
                  postAdBloc
                      .add(NewEditAdEventDesignation(value!.title.toString()));
                });
              },
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Job Type",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) =>
          previous.jobType != current.jobType,
          builder: (context, state) {
            jobType = state.jobType == ""
                ? jobTypeList[0]
                : jobTypeList.singleWhere(
                    (element) => state.jobType.contains(element),
                orElse: () => jobTypeList[0]);
            return DropdownButtonFormField(
              value: jobType,
              decoration: const InputDecoration(
                hintText:
                "Select job type",
              ),
              items: jobTypeList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                jobType = value!;
                postAdBloc.add(NewEditAdEventEmploymentType(value));
              },
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "How do you want to receive applications?",
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                buildWhen: (previous, current) =>
                previous.isReceivedEmail != current.isReceivedEmail,
                builder: (context, state) {
                  return SizedBox(
                    width: 30,
                    height: 24,
                    child: Checkbox(
                        value: state.isReceivedEmail,
                        onChanged: (value) {
                          postAdBloc.add(NewEditAdEventReceivedEmail(value!));
                        }),
                  );
                }),
            const SizedBox(
              width: 0,
            ),
            const Text(
              "Email and employer dashboard",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                buildWhen: (previous, current) =>
                previous.isReceivedPhone != current.isReceivedPhone,
                builder: (context, state) {
                  return SizedBox(
                    width: 30,
                    height: 24,
                    child: Checkbox(
                        value: state.isReceivedPhone,
                        onChanged: (value) {
                          postAdBloc.add(NewEditAdEventReceivedPhone(value!));
                        }),
                  );
                }),
            const SizedBox(
              width: 0,
            ),
            const Text(
              "Phone",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) =>
          previous.isReceivedEmail != current.isReceivedEmail,
          builder: (context, state) {
            return Visibility(
              visible: state.isReceivedEmail,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn,
                opacity: state.isReceivedEmail ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                      buildWhen: (previous, current) =>
                      previous.email != current.email,
                      builder: (context, state) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          // initialValue: state.phone,
                          controller: postAdBloc.emailController,
                          textInputAction: TextInputAction.next,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return null;
                          //   }
                          //   return null;
                          // },
                          onChanged: (value) =>
                              postAdBloc.add(NewEditAdEventEmail(value)),
                          decoration: const InputDecoration(
                              hintText:
                              "Email"),
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
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) =>
          previous.isReceivedPhone != current.isReceivedPhone,
          builder: (context, state) {
            return Visibility(
              visible: state.isReceivedPhone,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn,
                opacity: state.isReceivedPhone ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Phone",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                      buildWhen: (previous, current) =>
                      previous.phone != current.phone,
                      builder: (context, state) {
                        return TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: postAdBloc.phoneController,
                          textInputAction: TextInputAction.next,

                          onChanged: (value) =>
                              postAdBloc.add(NewEditAdEventPhone(value)),
                          decoration: const InputDecoration(
                              hintText:
                              "Phone"),
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
        const Text(
          "Required work experience (years)",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          controller: postAdBloc.experienceController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == "") {
              return null;
            }
            return null;
          },
          onChanged: (value) {
            postAdBloc.add(NewEditAdEventExperience(value));
          },
          decoration: const InputDecoration(
            hintText: "Years",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Required education",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) => previous.edition != current.edition,
          builder: (context, state) {
            education = state.educations == ""
                ? educationList[0]
                : educationList.singleWhere(
                    (element) => state.educations.contains(element),
                orElse: () => educationList[0]);
            return DropdownButtonFormField(
              value: education,
              decoration: const InputDecoration(
                hintText:
                "Select education",
              ),
              items: educationList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                education = value!;
                postAdBloc.add(NewEditAdEventEducations(education));
              },
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Salary per month",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        const Row(
          children: [
            Expanded(
              child: Text(
                "From",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                "To",
                style: TextStyle(fontSize: 16),
              ),
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
                controller: postAdBloc.salaryFromController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  postAdBloc.add(NewEditAdEventSalaryFrom(value));
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
                controller: postAdBloc.salaryToController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  postAdBloc.add(NewEditAdEventSalaryTo(value));
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
        const Text(
          "Application Deadline",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.datetime,
          controller: postAdBloc.deadlineController,
          onChanged: (value) {
            postAdBloc.add(NewEditAdEventDeadline(value));
          },
          readOnly: true,
          onTap: () {
            chooseDate(context);
          },
          decoration: const InputDecoration(
            hintText: "MM/DD/YYYY",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Employer Name",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          controller: postAdBloc.employerNameController,
          onChanged: (value) {
            postAdBloc.add(NewEditAdEventEmployerName(value));
          },
          decoration: const InputDecoration(
            hintText:
            "Employer Name",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Employer Website",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.url,
          controller: postAdBloc.webSiteController,
          onChanged: (value) {
            postAdBloc.add(NewEditAdEventEmployerWebsite(value));
          },
          decoration: const InputDecoration(
            hintText:
            "Employer Website",
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
                  onPressed: () {
                    pickImage().then((value) {
                      if (value != null) {
                        setState(() {
                          postAdBloc
                              .add(NewEditAdEventEmployeeLogo(base64Image!));
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const SizedBox(child: Text("Attach Logo",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (p0, p1) {
                  if (image == null) {
                    if (employerLogoUrl != null) {
                      return Center(
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: Image(
                            image: NetworkImage(
                                "${RemoteUrls.rootUrl}$employerLogoUrl"),
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
                          image: FileImage(File(image!.path)),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
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
      context
          .read<NewPostAdBloc>()
          .add(NewPostAdEventDeadline(expiryDateController.text));
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
      base64Image =
      'data:image/${image!.path.split('.').last};base64,${base64Encode(imageBytes)}';
      // setState(() {});

      // return imagePaths;
      return base64Image;
    }
  }
}
