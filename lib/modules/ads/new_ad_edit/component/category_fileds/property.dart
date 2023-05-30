import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants.dart';

import '../../../../ad_details/model/ad_details_model.dart';
import '../../controller/new_ad_edit_bloc.dart';
import 'brand_field.dart';
import 'model_field.dart';

class EditPropertyField extends StatefulWidget {
  const EditPropertyField({Key? key, required this.adModel}) : super(key: key);
  final AdDetails adModel;

  @override
  State<EditPropertyField> createState() => _EditPropertyFieldState();
}

class _EditPropertyFieldState extends State<EditPropertyField> {
  String groupType = '';
  List<String> fuelTypes = [];

  String size = propertySizeList[0];
  String price = propertyPriceList[0];

  @override
  void initState() {
    size = widget.adModel.propertyUnit == null ? propertySizeList[0] : widget.adModel.propertyUnit.toString().toLowerCase().toString();
    price = widget.adModel.propertyPriceType == null ? propertyPriceList[0] : widget.adModel.propertyPriceType.toString().toLowerCase().toString();
    groupType = widget.adModel.propertyType == null ? '' : widget.adModel.propertyType.toString().toLowerCase().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Property Type",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          // runSpacing: 12,
          // spacing: 10,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  groupType = "agricultural";
                  postAdBloc.add(NewEditAdEventPropertyType(groupType));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "agricultural",
                      groupValue: groupType,
                      onChanged: (value) {
                        setState(() {
                          groupType = value.toString();
                          postAdBloc.add(NewEditAdEventPropertyType(groupType));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  const Text(
                      "Agricultural"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  groupType = "residential";
                  postAdBloc.add(NewEditAdEventPropertyType(groupType));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "residential",
                      groupValue: groupType,
                      onChanged: (value) {
                        setState(() {
                          groupType = value.toString();
                          postAdBloc.add(NewEditAdEventPropertyType(groupType));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  const Text(
                      "Residential"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  groupType = "commercial";
                  postAdBloc.add(NewEditAdEventPropertyType(groupType));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "commercial",
                      groupValue: groupType,
                      onChanged: (value) {
                        setState(() {
                          groupType = value.toString();
                          postAdBloc.add(NewEditAdEventPropertyType(groupType));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  const Text(
                      "Commercial"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  groupType = "others";
                  postAdBloc.add(NewEditAdEventPropertyType(groupType));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "others",
                      groupValue: groupType,
                      onChanged: (value) {
                        setState(() {
                          groupType = value.toString();
                          postAdBloc.add(NewEditAdEventPropertyType(groupType));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  const Text("Others"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Size",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                buildWhen: (previous, current) => previous.size != current.size,
                builder: (context, state) {
                  return TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    initialValue: state.size,
                    validator: (value) {
                      if (value == "") {
                        return null;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      postAdBloc.add(NewEditAdEventSize(value));
                    },
                    decoration: const InputDecoration(
                      hintText:
                          "Size",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: ashColor),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(4))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ashColor),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(4))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ashColor),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(4))),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField(
                value: size,
                isExpanded: true,
                validator: (value) {
                  if (value == null) {
                    return null;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  fillColor: ashColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(4))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(4))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(4))),
                ),
                items: propertySizeList.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    size = value!;
                  });
                  postAdBloc.add(NewEditAdEventSizeType(size));
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Property location')}",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) =>
              previous.property_location != current.property_location,
          builder: (context, state) {
            return TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              initialValue: state.property_location,
              validator: (value) {
                if (value == "") {
                  return null;
                }
                return null;
              },
              onChanged: (value) {
                postAdBloc.add(NewEditAdEventPropertyLocation(value));
              },
              decoration: const InputDecoration(
                hintText:
                    "Enter the street, house number, and/or post code",
              ),
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Price",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
                buildWhen: (previous, current) =>
                    previous.price != current.price,
                builder: (context, state) {
                  return TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    initialValue: state.price,
                    validator: (value) {
                      if (value == "") {
                        return null;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      postAdBloc.add(NewEditAdEventPrice(value));
                    },
                    decoration: const InputDecoration(
                      hintText:
                          "Price')",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: ashColor),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(4))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ashColor),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(4))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ashColor),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(4))),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField(
                value: price,
                isExpanded: true,
                validator: (value) {
                  if (value == null) {
                    return null;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  fillColor: ashColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(4))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(4))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(4))),
                ),
                items: propertyPriceList.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    price = value!;
                  });
                  postAdBloc.add(NewEditAdEventPriceType(price));
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
}
