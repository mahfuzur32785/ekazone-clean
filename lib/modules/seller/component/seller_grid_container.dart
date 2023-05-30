import 'package:flutter/material.dart';
import 'package:ekayzone/modules/authentication/models/user_prfile_model.dart';
import 'package:ekayzone/modules/seller/component/seller_card.dart';

class SellerGridContainer extends StatefulWidget {
  const SellerGridContainer({
    Key? key,
    required this.sellers,
  }) : super(key: key);
  final List<UserProfileModel> sellers;

  @override
  State<SellerGridContainer> createState() => SellerGridContainerState();
}

class SellerGridContainerState extends State<SellerGridContainer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context,constraints){
              if (widget.sellers.isNotEmpty) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 280,
                  ),
                  itemBuilder: (context,index){
                    return SellerCard(seller: widget.sellers[index]);
                  },
                  itemCount: widget.sellers.length,
                );
              } else {
                return SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Center(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black54)
                        ),
                        child: const Text("Ads not found",style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),)),
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