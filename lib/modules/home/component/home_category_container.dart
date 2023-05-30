import 'package:flutter/material.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/dummy_data/all_dudmmy_data.dart';
import 'package:ekayzone/modules/category/model/category_model.dart';
import 'package:ekayzone/modules/home/component/home_category_card.dart';
import 'package:ekayzone/modules/home/component/product_card.dart';
import 'package:ekayzone/modules/main/main_controller.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

class HomeCategoryContainer extends StatefulWidget {
  const HomeCategoryContainer({
    Key? key,
    required this.categoryList, required this.title, required this.onPressed,
  }) : super(key: key);
  final List<Category> categoryList;
  final String title;
  final Function onPressed;

  @override
  State<HomeCategoryContainer> createState() => HomeCategoryContainerState();
}

class HomeCategoryContainerState extends State<HomeCategoryContainer> {

  @override
  void initState() {
    super.initState();
  }

  MainController mainController = MainController();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      sliver: MultiSliver(
        children: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style:
                    const TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox()
                  // TextButton(
                  //   onPressed: (){
                  //     widget.onPressed();
                  //   },
                  //   child: const Text("See All",style: TextStyle(color: redColor,fontWeight: FontWeight.w300,fontSize: 13),),
                  // )
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverLayoutBuilder(
            builder: (context,constraints){
              if (widget.categoryList.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 120,
                            minHeight: 110,
                          ),
                          child: ListView.separated(
                              clipBehavior: Clip.none,
                              addAutomaticKeepAlives: true,
                              shrinkWrap: true,
                              // padding: const EdgeInsets.symmetric(horizontal: 16),
                              addRepaintBoundaries: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                if (widget.categoryList[index].id != 0) {
                                  return HomeCategoryCard(categoryModel: widget.categoryList[index], index: index,mainController: mainController,);
                                } else {
                                  return const SizedBox();
                                }

                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 16,
                                );
                              },
                              itemCount: widget.categoryList.length
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Center(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.black54)
                          ),
                          child: const Text("Category Not Found",style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),)),
                    ),
                  ),
                );
              }
            },
          )

        ],
      ),
    );
  }
}