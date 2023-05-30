import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/new_posted_bloc.dart';

class ModelField extends StatefulWidget {
  const ModelField({Key? key}) : super(key: key);

  @override
  State<ModelField> createState() => _ModelFieldState();
}

class _ModelFieldState extends State<ModelField> {

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
          "Model",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
          buildWhen: (previous, current) => previous.model != current.model,
          builder: (context, state) {
            return TextFormField(
              keyboardType: TextInputType.text,
              controller: postAdBloc.editionController,
              textInputAction: TextInputAction.next,
              onChanged: (value) => postAdBloc.add(NewPostAdEventProductModel(value)),
              decoration: const InputDecoration(hintText: "Model"),
            );
          },
        ),
      ],
    );
  }
}
