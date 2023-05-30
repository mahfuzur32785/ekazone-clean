import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants.dart';
import '../../../../ad_details/model/ad_details_model.dart';
import '../../controller/new_ad_edit_bloc.dart';

class EditAuthenticityField extends StatefulWidget {
  const EditAuthenticityField({Key? key, required this.adModel}) : super(key: key);
  final AdDetails adModel;

  @override
  State<EditAuthenticityField> createState() => _EditAuthenticityFieldState();
}

class _EditAuthenticityFieldState extends State<EditAuthenticityField> {

  String groupValue = '';

  @override
  void initState() {
    groupValue = widget.adModel.authenticity == null ? '' : widget.adModel.authenticity.toString().toLowerCase().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        Text("Authenticity",style: const TextStyle(fontSize: 16),),
        Wrap(
          alignment: WrapAlignment.start,
          // runSpacing: 12,
          // spacing: 10,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  groupValue = "original";
                  postAdBloc.add(NewEditAdEventAuthenticity(groupValue));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "original",
                      groupValue: groupValue,
                      onChanged: (value){
                        setState(() {
                          groupValue = value.toString();
                          postAdBloc.add(NewEditAdEventAuthenticity(groupValue));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  Text("Original"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  groupValue = "refurbished";
                  postAdBloc.add(NewEditAdEventAuthenticity(groupValue));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "refurbished",
                      groupValue: groupValue,
                      onChanged: (value){
                        setState(() {
                          groupValue = value.toString();
                          postAdBloc.add(NewEditAdEventAuthenticity(groupValue));
                        });
                      }),
                  const SizedBox(
                    width: 0,
                  ),
                  Text("Refurbished"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: (){
            //     setState(() {
            //       groupValue = "gently_used";
            //       postAdBloc.add(NewEditAdEventCondition(groupValue));
            //     });
            //   },
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Radio(
            //           activeColor: redColor,
            //           value: "gently_used",
            //           groupValue: groupValue,
            //           onChanged: (value){
            //             setState(() {
            //               groupValue = value.toString();
            //               // widget.onValueChanged(value.toString());
            //             });
            //           }),
            //       const SizedBox(
            //         width: 0,
            //       ),
            //       Text("${AppLocalizations.of(context).translate('gently_used')}"),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
