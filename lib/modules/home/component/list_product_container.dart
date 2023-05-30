import 'package:flutter/material.dart';
import 'package:ekayzone/modules/home/component/list_product_card.dart';
import 'package:ekayzone/modules/home/component/product_card.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../model/product_model.dart';

class ListProductContainer extends StatefulWidget {
  const ListProductContainer({
    Key? key,
    required this.adModelList, required this.title, required this.onPressed,
  }) : super(key: key);
  final List<AdModel> adModelList;
  final String title;
  final Function onPressed;

  @override
  State<ListProductContainer> createState() => ListProductContainerState();
}

class ListProductContainerState extends State<ListProductContainer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style:
                  const TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w500),
                ),
                const SizedBox()
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverLayoutBuilder(
            builder: (context,constraints){
              if (widget.adModelList.isNotEmpty) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return  ListProductCard(adModel: widget.adModelList[index],index: index);
                  },childCount: widget.adModelList.length),
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
                          child: const Text("Product Not Found",style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),)),
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