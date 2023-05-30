import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/model/model_model.dart';
import '../../controller/new_ad_edit_bloc.dart';

class EditPropertyField extends StatefulWidget {
  const EditPropertyField({Key? key}) : super(key: key);

  @override
  State<EditPropertyField> createState() => _EditPropertyFieldState();
}

class _EditPropertyFieldState extends State<EditPropertyField> {

  List<String> brandList = ["Apple","Samsung","Oppo","Nokia","BMW","Nissan",];

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Service type",style: const TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) => previous.service_type_id != current.service_type_id,
          builder: (context, state) {
            return DropdownButtonFormField(
              validator: (value) {
                if (value == null) {
                  return null;
                }
                return null;
              },
              isExpanded: true,
              decoration: const InputDecoration(
                hintText: "Select Service Type",
              ),
              items: postAdBloc.serviceTypeList.map<DropdownMenuItem<Model>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.title),
                );
              }).toList(),
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 300)).then((value2) {
                  // postAdBloc.add(NewEditAdEventServiceTypeId(value!.id.toString()));
                });
              },
            );
          },
        ),

        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
