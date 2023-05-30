import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants.dart';
import '../../../../ad_details/model/ad_details_model.dart';
import '../../controller/new_ad_edit_bloc.dart';

class EditCommonField extends StatefulWidget {
  const EditCommonField({Key? key, required this.adModel, this.categoryId}) : super(key: key);
  final AdDetails adModel;
  final String? categoryId;


  @override
  State<EditCommonField> createState() => _EditCommonFieldState();
}

class _EditCommonFieldState extends State<EditCommonField> {

  int radioId = 0;
  String groupValue = '';

  @override
  void initState() {
    groupValue = widget.adModel.condition == null ? '' : widget.adModel.condition.toString().toLowerCase().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        Text("Condition",style: const TextStyle(fontSize: 16),),
        Wrap(
          alignment: WrapAlignment.start,
          // runSpacing: 12,
          // spacing: 10,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  groupValue = "new";
                  postAdBloc.add(NewEditAdEventCondition(groupValue));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "new",
                      groupValue: groupValue,
                      onChanged: (value){
                        setState(() {
                          groupValue = value.toString();
                          postAdBloc.add(NewEditAdEventCondition(groupValue));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  Text("New"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  groupValue = "used";
                  postAdBloc.add(NewEditAdEventCondition(groupValue));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "used",
                      groupValue: groupValue,
                      onChanged: (value){
                        setState(() {
                          groupValue = value.toString();
                          postAdBloc.add(NewEditAdEventCondition(groupValue));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  Text("Used"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.categoryId == "22",
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    groupValue = "reconditioned";
                    postAdBloc.add(NewEditAdEventCondition(groupValue));
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                        activeColor: redColor,
                        value: "reconditioned",
                        groupValue: groupValue,
                        onChanged: (value){
                          setState(() {
                            groupValue = value.toString();
                            // widget.onValueChanged(value.toString());
                          });
                        }),
                    const SizedBox(
                      width: 0,
                    ),
                    Text("Reconditioned"),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
