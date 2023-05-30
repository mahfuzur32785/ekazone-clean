import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/model/model_model.dart';
import '../../controller/new_ad_edit_bloc.dart';

class EditModelField extends StatefulWidget {
  const EditModelField({Key? key}) : super(key: key);

  @override
  State<EditModelField> createState() => _EditModelFieldState();
}

class _EditModelFieldState extends State<EditModelField> {

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          "Model",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) =>
          previous.model != current.model,
          builder: (context, state) {
            return TextFormField(
              keyboardType: TextInputType.text,
              controller: postAdBloc.modelController,
              textInputAction: TextInputAction.next,
              onChanged: (value) => postAdBloc.add(NewEditAdEventProductModel(value)),
              decoration: const InputDecoration(hintText: "Model"),
            );
          },
        ),
      ],
    );
  }
}
