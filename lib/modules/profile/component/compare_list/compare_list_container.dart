import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'compare_product_card.dart';

class CompareListContainer extends StatefulWidget {
  const CompareListContainer({
    Key? key,
    required this.adModelList, required this.onPressed,
  }) : super(key: key);
  final List<AdModel> adModelList;
  final Function onPressed;

  @override
  State<CompareListContainer> createState() => CompareListContainerState();
}

class CompareListContainerState extends State<CompareListContainer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final userData = context.read<LoginBloc>().userInfo;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      sliver: MultiSliver(
        children: [
          SliverLayoutBuilder(
            builder: (context,constraints){
              if (widget.adModelList.isNotEmpty) {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    // crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 250,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int pIndex) =>
                        CompareProductCard(adModel: widget.adModelList[pIndex], index: widget.adModelList[pIndex].id, userData: userData),
                    childCount: widget.adModelList.length,
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
                          child: const Text("Ads Not Found",style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),)),
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