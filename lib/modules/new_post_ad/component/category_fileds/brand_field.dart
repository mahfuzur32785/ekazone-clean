import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/model/brand_model.dart';
import '../../controller/new_posted_bloc.dart';

class BrandField extends StatefulWidget {
  const BrandField({Key? key}) : super(key: key);

  @override
  State<BrandField> createState() => _BrandFieldState();
}

class _BrandFieldState extends State<BrandField> {

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Brand",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
          buildWhen: (previous, current) => previous.brandId != current.brandId,
          builder: (context, state) {
            return DropdownButtonFormField(
              isExpanded: true,
              decoration: const InputDecoration(
                hintText: "Select Brand",
              ),
              items:
                  postAdBloc.brandList.map<DropdownMenuItem<BrandModel>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.name),
                );
              }).toList(),
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 300)).then(
                  (value2) {
                    postAdBloc.add(
                        NewPostAdEventProductBrandId(value!.id.toString()));
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
