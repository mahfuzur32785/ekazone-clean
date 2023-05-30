import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/core/animation/top_bottom_animation.dart';
import 'package:ekayzone/dummy_data/all_dudmmy_data.dart';
import 'package:ekayzone/modules/category/controller/category_bloc.dart';
import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:ekayzone/modules/location/component/location_tile.dart';

import '../../utils/constants.dart';
import '../home/model/category_model.dart';
import '../location/component/back_all_location_tile.dart';
import '../location/component/color_location_tile.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedLocation = -1;

  late CategoryBloc categoryBloc;

  List<Category> categoryList = [];

  @override
  void initState() {
    super.initState();
    categoryList = context.read<HomeControllerCubit>().homeModel.categories;
  }

  @override
  Widget build(BuildContext context) {
    categoryBloc = context.read<CategoryBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        title: const Text(
          "Pick a category",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            if (selectedLocation > -1) {
              setState(() {
                selectedLocation = -1;
              });
              return;
            }
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: redColor,
            statusBarIconBrightness: Brightness.light),
      ),
      body: BlocBuilder<CategoryBloc,CategoryState>(
          builder: (context, state) {
            if (state is CategoryStateSelectCategory) {
              return CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverToBoxAdapter(
                    child: LocationTile(
                        title: "Go to all ads",
                        onPressed: () {
                          categoryBloc.add(const CategoryShowAllDataEvent());
                          Navigator.of(context).pop();
                        },
                        isShow: true),
                  ),
                  SliverToBoxAdapter(
                    child: BackAllLocationTile(
                        title: "Back To all Categories",
                        onPressed: () {
                          categoryBloc.add(const CategorySelectBackAllCategory());
                        },
                        isShow: true),
                  ),
                  SliverToBoxAdapter(
                    child: DelayedTopBottomAnimation(
                      delay: 50,
                      child: ColorLocationTile(
                          title: "${categoryBloc.category?.name}",
                          onPressed: () {

                          },
                          isShow: false),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: DelayedTopBottomAnimation(
                      delay: 50,
                      child: LocationTile(
                          title: "All Ads in ${categoryBloc.category?.name}",
                          onPressed: () {
                            categoryBloc.add(CategoryDataEvent(categoryBloc.category!));
                            Navigator.of(context).pop();
                          },
                          isShow: false),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return DelayedTopBottomAnimation(
                        delay: 50,
                        child: LocationTile(
                            title: "${categoryBloc.category?.subCategoryList[index].name}",
                            onPressed: () {
                              categoryBloc.add(CategorySubCategorySelectEvent(categoryBloc.category!.subCategoryList[index]));
                              Navigator.of(context).pop();
                            },
                            isShow: false),
                      );
                    }, childCount: categoryBloc.category?.subCategoryList.length),
                  )
                ],
              );
            }
            if (state is CategoryStateSelectSubCategory) {
              return CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverToBoxAdapter(
                    child: LocationTile(
                        title: "Go to all ads",
                        onPressed: () {
                          categoryBloc.add(const CategoryShowAllDataEvent());
                          Navigator.of(context).pop();
                        },
                        isShow: true),
                  ),
                  SliverToBoxAdapter(
                    child: BackAllLocationTile(
                        title: "Back To all Categories",
                        onPressed: () {
                          categoryBloc.add(const CategorySelectBackAllCategory());
                        },
                        isShow: true),
                  ),
                  SliverToBoxAdapter(
                    child: LocationTile(
                        title: "${categoryBloc.category?.name}",
                        onPressed: () {
                          categoryBloc.add(CategorySelectEvent(categoryBloc.category!,false));
                        },
                        isShow: false),
                  ),
                  SliverToBoxAdapter(
                    child: DelayedTopBottomAnimation(
                      delay: 50,
                      child: ColorLocationTile(
                          title: "${categoryBloc.subCategory?.name}",
                          onPressed: () {

                          },
                          isShow: false),
                    ),
                  ),
                ],
              );
            }
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverToBoxAdapter(
                  child: LocationTile(
                      title: "Go to all ads",
                      onPressed: () {
                        categoryBloc.add(const CategoryShowAllDataEvent());
                        Navigator.of(context).pop();
                      },
                      isShow: true),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return LocationTile(
                        title: categoryList[index].name,
                        onPressed: () {
                          categoryBloc.add(CategorySelectEvent(categoryList[index],false));
                        },
                        isShow: false);
                  }, childCount: categoryList.length),
                )
              ],
            );
      }),
    );
  }
}
