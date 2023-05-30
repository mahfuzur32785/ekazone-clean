import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants.dart';
import '../../../../ad_details/model/ad_details_model.dart';
import '../../controller/new_ad_edit_bloc.dart';
import 'brand_field.dart';
import 'model_field.dart';

class EditEducationsField extends StatefulWidget {
  const EditEducationsField({Key? key, required this.adModel}) : super(key: key);
  final AdDetails adModel;

  @override
  State<EditEducationsField> createState() => _EditEducationsFieldState();
}

class _EditEducationsFieldState extends State<EditEducationsField> {
  String groupConditions = '';
  String groupTextBookType = '';
  String? ram;

  @override
  void initState() {
    groupConditions = widget.adModel.condition == null ? '' : widget.adModel.condition.toString().toLowerCase().toString();
    groupTextBookType = widget.adModel.textbookType == null ? '' : widget.adModel.textbookType.toString().toLowerCase().toString();
    // ram = widget.adModel.ram == null ? null : ramList.singleWhere((element) => widget.adModel.ram.toString().contains(element));
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
          'Condition',
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
                  groupConditions = "used";
                  postAdBloc.add(NewEditAdEventAuthenticity(groupConditions));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "used",
                      groupValue: groupConditions,
                      onChanged: (value) {
                        setState(() {
                          groupConditions = value.toString();
                          postAdBloc.add(NewEditAdEventAuthenticity(groupConditions));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  const Text("Used"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  groupConditions = "new";
                  postAdBloc.add(NewEditAdEventAuthenticity(groupConditions));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "new",
                      groupValue: groupConditions,
                      onChanged: (value) {
                        setState(() {
                          groupConditions = value.toString();
                          postAdBloc.add(NewEditAdEventAuthenticity(groupConditions));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  const Text(
                      "New"),
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
          "Textbook Type",
          style: TextStyle(fontSize: 16),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  groupTextBookType = "collage";
                  postAdBloc.add(NewEditAdEventTextBookType(groupTextBookType));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "collage",
                      groupValue: groupTextBookType,
                      onChanged: (value) {
                        setState(() {
                          groupTextBookType = value.toString();
                          postAdBloc
                              .add(NewEditAdEventTextBookType(groupTextBookType));
                        });
                      }),
                  const Text("Collage/University"),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  groupTextBookType = "school";
                  postAdBloc.add(NewEditAdEventTextBookType(groupTextBookType));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "school",
                      groupValue: groupTextBookType,
                      onChanged: (value) {
                        setState(() {
                          groupTextBookType = value.toString();
                          postAdBloc
                              .add(NewEditAdEventTextBookType(groupTextBookType));
                        });
                      }),
                  const Text("School"),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  groupTextBookType = "other";
                  postAdBloc.add(NewEditAdEventTextBookType(groupTextBookType));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "other",
                      groupValue: groupTextBookType,
                      onChanged: (value){
                        setState(() {
                          groupTextBookType = value.toString();
                          postAdBloc.add(NewEditAdEventTextBookType(groupTextBookType));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  const Text("Other"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
