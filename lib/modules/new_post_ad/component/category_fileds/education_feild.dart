import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';
import '../../controller/new_posted_bloc.dart';
import 'common_fields.dart';

class EducationField extends StatefulWidget {
  const EducationField({Key? key}) : super(key: key);

  @override
  State<EducationField> createState() => _EducationFieldState();
}

class _EducationFieldState extends State<EducationField> {

  int radioId = 0;
  String groupValue = '';

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Condition
        const CommonField(),

        const SizedBox(height: 5,),

        ///Textbook Type
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
                      groupValue = "collage";
                      postAdBloc.add(NewPostAdEventTextBookType(groupValue));
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                          activeColor: redColor,
                          value: "collage",
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value.toString();
                              postAdBloc
                                  .add(NewPostAdEventTextBookType(groupValue));
                            });
                          }),
                      const Text("Collage/University"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      groupValue = "school";
                      postAdBloc.add(NewPostAdEventTextBookType(groupValue));
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                          activeColor: redColor,
                          value: "school",
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value.toString();
                              postAdBloc
                                  .add(NewPostAdEventTextBookType(groupValue));
                            });
                          }),
                      const Text("School"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      groupValue = "other";
                      postAdBloc.add(NewPostAdEventTextBookType(groupValue));
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                          activeColor: redColor,
                          value: "other",
                          groupValue: groupValue,
                          onChanged: (value){
                            setState(() {
                              groupValue = value.toString();
                              postAdBloc.add(NewPostAdEventTextBookType(groupValue));
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
        ),
      ],
    );
  }
}
