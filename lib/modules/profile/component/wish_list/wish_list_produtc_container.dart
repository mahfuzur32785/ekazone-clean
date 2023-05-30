import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/modules/profile/component/wish_list/wishlist_product_card.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class WishListProductContainer extends StatefulWidget {
  const WishListProductContainer({
    Key? key,
    required this.adModelList, required this.onPressed, this.form,
  }) : super(key: key);
  final List<AdModel> adModelList;
  final Function onPressed;
  final String? form;

  @override
  State<WishListProductContainer> createState() => WishListProductContainerState();
}

class WishListProductContainerState extends State<WishListProductContainer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 16,right: 16, bottom: 12,top: 5),
      sliver: MultiSliver(
        children: [

          SliverLayoutBuilder(
            builder: (context,constraints){
              if (widget.adModelList.isNotEmpty) {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 250,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int pIndex) =>
                        WishListProductCard(adModel: widget.adModelList[pIndex],form: widget.form,),
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
                          child: Text("Ads Not Found",style: const TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),)),
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