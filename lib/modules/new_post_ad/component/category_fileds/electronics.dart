import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';
import '../../controller/new_posted_bloc.dart';
import 'brand_field.dart';
import 'common_fields.dart';
import 'model_field.dart';

class ElectronicsField extends StatefulWidget {
  const ElectronicsField({Key? key}) : super(key: key);

  @override
  State<ElectronicsField> createState() => _ElectronicsFieldState();
}

class _ElectronicsFieldState extends State<ElectronicsField> {
  // int radioId = 0;
  String authenticityValue = '';

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Condition
        const CommonField(),
        ///Authenticity
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Authenticity",
              style: TextStyle(fontSize: 16),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      authenticityValue = "original";
                      postAdBloc.add(NewPostAdEventAuthenticity(authenticityValue));
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                          activeColor: redColor,
                          value: "original",
                          groupValue: authenticityValue,
                          onChanged: (value) {
                            setState(() {
                              authenticityValue = value.toString();
                              postAdBloc
                                  .add(NewPostAdEventAuthenticity(authenticityValue));
                            });
                          }),
                      const Text("Original"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      authenticityValue = "refurbished";
                      postAdBloc.add(NewPostAdEventAuthenticity(authenticityValue));
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                          activeColor: redColor,
                          value: "refurbished",
                          groupValue: authenticityValue,
                          onChanged: (value) {
                            setState(() {
                              authenticityValue = value.toString();
                              postAdBloc
                                  .add(NewPostAdEventAuthenticity(authenticityValue));
                            });
                          }),
                      const Text("Refurbished"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        ///Brand
        const BrandField(),
        ///Model
        const ModelField(),
        const SizedBox(
          height: 16,
        ),
        ///Editions
        const Text("Editions (Optional)"),
        const SizedBox(height: 6,),
        BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
          buildWhen: (previous, current) => previous.edition != current.edition,
          builder: (context, state) {
            return TextFormField(
              keyboardType: TextInputType.text,
              controller: postAdBloc.modelController,
              textInputAction: TextInputAction.next,
              onChanged: (value) => postAdBloc.add(NewPostAdEventEdition(value)),
              decoration: const InputDecoration(hintText: "Edition"),
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        ///Feature section
        const Text("Feature (Optional)"),
        const SizedBox(
          height: 8,
        ),
        ...List.generate(featureList.length, (index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: ashColor)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        // height: 60,
                        child: BlocBuilder<NewPostAdBloc,
                            NewPostAdModalState>(
                            buildWhen: (previous, current) =>
                            previous.features != current.features,
                            builder: (context, state) {
                              return TextFormField(
                                // validator: validator,
                                // controller: controller,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                // validator: (value) {
                                //   if (value == null ||
                                //       value.isEmpty) {
                                //     return getPosition(index + 1);
                                //   }
                                //   return null;
                                // },
                                onChanged: (value) {
                                  featureList[index] =
                                      value.toString().trim();
                                  postAdBloc.add(NewPostAdEventFeature(
                                      featureList));
                                  // if (value != "") {
                                  //   featureList[index] = value.toString();
                                  // }
                                },
                                onSaved: (String? val) {},
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 0),
                                  hintText: index == 0
                                      ? "Feature"
                                      : "Another Feature",
                                  hintStyle: const TextStyle(
                                      color: ashTextColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  // labelText: 'Email',
                                  // isDense: true,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Material(
                      color: index == featureList.length - 1
                          ? Color(0xFF157347)
                          : Color(0xFFBB2D3B),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          if (index == (featureList.length - 1)) {
                            addContact();
                          } else {
                            removeContact(index);
                          }
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: index == featureList.length - 1
                              ? const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          )
                              : const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          );
        }),
      ],
    );
  }

  //.............. contacts info ....................
  List<String> featureList = [""];
  // var contactController = TextEditingController();
  void addContact() {
    setState(() {
      featureList.add("");
    });
  }

  void removeContact(index) {
    setState(() {
      featureList.removeAt(index).trim();
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

}
