import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/model/brand_model.dart';
import '../../controller/new_ad_edit_bloc.dart';

class EditBrandField extends StatefulWidget {
  const EditBrandField({Key? key}) : super(key: key);

  @override
  State<EditBrandField> createState() => _EditBrandFieldState();
}

class _EditBrandFieldState extends State<EditBrandField> {

  BrandModel? brand;

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Brand",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
          buildWhen: (previous, current) => previous.brandId != current.brandId,
          builder: (context, state) {
            brand = state.brandId == ""
                ? null
                : postAdBloc.brandList
                .singleWhere((element) => state.brandId == element.id.toString(),);
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
              value: postAdBloc.brandModel,
              onChanged: (value) {
                setState(() {
                  // brand = null;
                });
                Future.delayed(const Duration(milliseconds: 300)).then(
                      (value2) {
                    postAdBloc.add(NewEditAdEventProductBrandId(value!.id.toString()));
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
