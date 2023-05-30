import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';
import '../../controller/new_posted_bloc.dart';

class PropertyField extends StatefulWidget {
  const PropertyField({Key? key}) : super(key: key);

  @override
  State<PropertyField> createState() => _PropertyFieldState();
}

class _PropertyFieldState extends State<PropertyField> {
  String groupType = '';
  List<String> fuelTypes = [];

  String size = propertySizeList[0];
  String price = propertyPriceList[0];

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Property type",
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
                  postAdBloc.add(NewPostAdEventPropertyType(groupType));
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
                          postAdBloc.add(NewPostAdEventPropertyType(groupType));
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
                  postAdBloc.add(NewPostAdEventPropertyType(groupType));
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
                          postAdBloc.add(NewPostAdEventPropertyType(groupType));
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
                  postAdBloc.add(NewPostAdEventPropertyType(groupType));
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
                          postAdBloc.add(NewPostAdEventPropertyType(groupType));
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
                  postAdBloc.add(NewPostAdEventPropertyType(groupType));
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
                          postAdBloc.add(NewPostAdEventPropertyType(groupType));
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
              child: BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                buildWhen: (previous, current) => previous.size != current.size,
                builder: (context, state) {
                  return TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    // validator: (value) {
                    //   if (value == "") {
                    //     return null;
                    //   }
                    //   return null;
                    // },
                    onChanged: (value) {
                      postAdBloc.add(NewPostAdEventSize(value));
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
                // validator: (value) {
                //   if (value == null) {
                //     return null;
                //   }
                //   return null;
                // },
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
                    postAdBloc.add(NewPostAdEventSizeType(size));
                  });
                  // widget.onValueChanged(value!.value);
                },
              ),
            ),
          ],
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
              child: BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                buildWhen: (previous, current) =>
                    previous.price != current.price,
                builder: (context, state) {
                  return TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    // validator: (value) {
                    //   if (value == "") {
                    //     return null;
                    //   }
                    //   return null;
                    // },
                    onChanged: (value) {
                      postAdBloc.add(NewPostAdEventPrice(value));
                    },
                    decoration: const InputDecoration(
                      hintText:
                          "Price",
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
                // validator: (value) {
                //   if (value == null) {
                //     return null;
                //   }
                //   return null;
                // },
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
                  postAdBloc.add(NewPostAdEventPriceType(price));
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
