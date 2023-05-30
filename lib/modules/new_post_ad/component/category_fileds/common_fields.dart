import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';
import '../../controller/new_posted_bloc.dart';

class CommonField extends StatefulWidget {
  const CommonField({Key? key, this.categoryId}) : super(key: key);
  final String? categoryId;

  @override
  State<CommonField> createState() => _CommonFieldState();
}

class _CommonFieldState extends State<CommonField> {

  int radioId = 0;
  String conditionsValue = '';

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 16,
        ),
        const Text("Condition",style: TextStyle(fontSize: 16),),
        Wrap(
          alignment: WrapAlignment.start,
          // runSpacing: 12,
          // spacing: 10,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  conditionsValue = "new";
                  postAdBloc.add(NewPostAdEventCondition(conditionsValue));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "new",
                      groupValue: conditionsValue,
                      onChanged: (value){
                        setState(() {
                          conditionsValue = value.toString();
                          postAdBloc.add(NewPostAdEventCondition(conditionsValue));
                        });
                      },
                  ),
                  const Text("New"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  conditionsValue = "used";
                  postAdBloc.add(NewPostAdEventCondition(conditionsValue));
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: redColor,
                      value: "used",
                      groupValue: conditionsValue,
                      onChanged: (value){
                        setState(() {
                          conditionsValue = value.toString();
                          postAdBloc.add(NewPostAdEventCondition(conditionsValue));
                        });
                      }),
                  const Text("Used"),
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
                    conditionsValue = "reconditioned";
                    postAdBloc.add(NewPostAdEventCondition(conditionsValue));
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                        activeColor: redColor,
                        value: "reconditioned",
                        groupValue: conditionsValue,
                        onChanged: (value){
                          setState(() {
                            conditionsValue = value.toString();
                            postAdBloc.add(NewPostAdEventCondition(conditionsValue));
                          });
                        }),
                    const SizedBox(
                      width: 0,
                    ),
                    const Text("Reconditioned"),
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
