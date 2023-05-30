import 'package:ekayzone/modules/ads/new_ad_edit/component/category_fileds/common_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants.dart';
import '../../../../ad_details/model/ad_details_model.dart';
import '../../controller/new_ad_edit_bloc.dart';
import 'authenticity_feild.dart';
import 'brand_field.dart';
import 'model_field.dart';

class EditElectronicsField extends StatefulWidget {
  const EditElectronicsField({Key? key, required this.adModel}) : super(key: key);
  final AdDetails adModel;

  @override
  State<EditElectronicsField> createState() => _EditElectronicsFieldState();
}

class _EditElectronicsFieldState extends State<EditElectronicsField> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featureList.addAll(widget.adModel.adFeatures.map((e) => e.name).toList());
    print('feature is : ${featureList.length}');
  }

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditCommonField(adModel: widget.adModel),
        EditAuthenticityField(adModel: widget.adModel),
        const EditBrandField(),
        const EditModelField(),
        const SizedBox(height: 16),
        const Text("Editions (Optional)"),
        const SizedBox(height: 6),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) => previous.edition != current.edition,
          builder: (context, state) {
            return TextFormField(
              keyboardType: TextInputType.text,
              controller: postAdBloc.trimEditionController,
              textInputAction: TextInputAction.next,
              onChanged: (value) => postAdBloc.add(NewEditAdEventEdition(value)),
              decoration: const InputDecoration(hintText: "Edition"),
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
                        child: BlocBuilder<NewEditAdBloc,
                            NewEditAdModalState>(
                            buildWhen: (previous, current) =>
                            previous.features != current.features,
                            builder: (context, state) {
                              return TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                initialValue: featureList[index].trim(),
                                onChanged: (value) {
                                  featureList[index] = value.toString().trim();
                                  postAdBloc.add(NewEditAdEventFeature(featureList));
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
                          ? redColor
                          : ashTextColor,
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
