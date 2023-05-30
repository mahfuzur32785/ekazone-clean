import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/ads/controller/adlist_bloc.dart';
import 'package:ekayzone/modules/category/controller/category_bloc.dart';
import 'package:ekayzone/modules/category/model/category_model.dart';
import 'package:ekayzone/modules/home/model/category_model.dart';
import 'package:ekayzone/utils/k_images.dart';
import 'package:ekayzone/widgets/custom_image.dart';

import '../../main/main_controller.dart';

class HomeCategoryCard extends StatelessWidget {
  const HomeCategoryCard({Key? key, required this.categoryModel, required this.index, required this.mainController}) : super(key: key);
  final Category categoryModel;
  final int index;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    final categoryBloc = context.read<CategoryBloc>();
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
        minWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: (){
            // categoryBloc.add(CategorySelectEvent(categoryModel,true));
            context.read<CategoryBloc>().add(CategorySelectEvent(categoryModel,true));
            mainController.naveListener.sink.add(1);
          },
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CustomImage(path: "https://www.mobiledokan.com/wp-content/uploads/2022/04/Samsung-Galaxy-A23.jpg",height: 100,width: 70,fit: BoxFit.contain,),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text("${categoryModel.name} (${categoryModel.adCount})"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
