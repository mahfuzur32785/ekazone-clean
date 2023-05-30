import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ekayzone/modules/home/component/product_card.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../core/router_name.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../main/main_controller.dart';
import '../model/product_model.dart';

class GridProductContainer extends StatefulWidget {
  const GridProductContainer({
    Key? key,
    required this.adModelList, this.from,required this.title, required this.onPressed,
  }) : super(key: key);
  final List<AdModel> adModelList;
  final String title;
  final Function onPressed;
  final String? from;

  @override
  State<GridProductContainer> createState() => GridProductContainerState();
}

class GridProductContainerState extends State<GridProductContainer> {

  final MainController mainController = MainController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logInBloc = context.read<LoginBloc>();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(
            child: Visibility(
              visible: widget.title != "",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style:
                    const TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(child: const Text("View all>>"),
                  onTap: () {

                    // mainController.naveListener.sink.add(1);

                    Navigator.pushNamed(context, RouteNames.adsScreen, arguments: [
                    '', '', '', ''
                    ]);
                  },
                  )
                  // const SizedBox()
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverLayoutBuilder(
            builder: (context,constraints){
              if (widget.adModelList.isNotEmpty) {
                // final List<AdModel> adList = widget.adModelList.where((element) => element.country == homeBloc.country).toList();
                // if(adList.isNotEmpty) {

                  return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 250,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int pIndex) =>
                              ProductCard(adModel: widget.adModelList[pIndex],from: widget.from,index: pIndex, logInUserId: logInBloc.userInfo?.user.id),
                      childCount: widget.adModelList.length,
                    ),
                  );
                // }else{
                //   return SliverToBoxAdapter(
                //     child: SizedBox(
                //       height: 150,
                //       width: double.infinity,
                //       child: Center(
                //         child: Container(
                //             padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(6),
                //                 border: Border.all(color: Colors.black54)
                //             ),
                //             child: Text("${AppLocalizations.of(context).translate('ads')} ${AppLocalizations.of(context).translate('not_found_title')}",style: const TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),)),
                //       ),
                //     ),
                //   );
                // }
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
                          child: Text("Ads not found",style: const TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),)),
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