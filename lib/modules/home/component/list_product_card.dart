import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:ekayzone/widgets/compare_button.dart';
import 'package:flutter/material.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../ads/controller/customer_ads/customer_ads_bloc.dart';
import 'dart:math' as math;

class ListProductCard extends StatefulWidget {
  final AdModel adModel;
  final int? logInUserId;
  final String? form;
  final int index;
  const ListProductCard({
    Key? key,
    required this.adModel, this.logInUserId, this.form, required this.index,
  }) : super(key: key);

  @override
  State<ListProductCard> createState() => _ListProductCardState();
}

class _ListProductCardState extends State<ListProductCard> {
  @override
  Widget build(BuildContext context) {
    final userAdBloc = context.read<CustomerAdsBloc>();
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(0, 0),
                blurRadius: 3),
          ],
          color: Colors.white),
      child: InkWell(
        onTap: () {
          if (ModalRoute.of(context)!.settings.name!.contains("adDetails")) {
            Navigator.pushReplacementNamed(context, RouteNames.adDetails,
                arguments: widget.adModel.slug);
          } else {
            Navigator.pushNamed(context, RouteNames.adDetails,
                arguments: widget.adModel.slug);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border(bottom: BorderSide(color: borderColor)),
      ),
      height: 120,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: CustomImage(
                // path: RemoteUrls.imageUrl(productModel.image),
                //   path: adModel.galleries.isNotEmpty ? adModel.galleries[0].imageUrl : null,
                path: widget.adModel.thumbnail != ''
                    ? '${RemoteUrls.rootUrl}${widget.adModel.thumbnail}'
                    : null,
                fit: BoxFit.cover),
          ),

          Visibility(
            visible: widget.adModel.featured == "1",
            child: Positioned(
              top: 17,
              left: -10,
              child: Transform.rotate(
                angle: -math.pi / 4.1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF2DBE6C),
                    borderRadius: BorderRadius.circular(10)
                    // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                  ),
                  child: Text('Featured',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.adModel.price.isNotEmpty,
            child: Text(
              "${context.read<HomeControllerCubit>().symbol} ${widget.adModel.price.toString()}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  height: 1.5, color: blackColor, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            child: Text(
              widget.adModel.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Visibility(
                  visible: widget.adModel.city.isNotEmpty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey.shade500,
                        size: 20,
                      ),
                      // Icon(Icons.location_on,color: Colors.grey.shade500,size: 16,),
                      Expanded(
                        child: Text(
                          "${widget.adModel.city}",
                          // maxLines: 1,
                          style: TextStyle(color: Colors.grey.shade500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () {
                        print("Compare");
                      },
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey.shade200,
                        child: CompareButton(
                          index: int.parse("${widget.adModel?.id}"),
                          adsUserId: widget.adModel?.customer?.id,
                          logInUserId: widget.logInUserId,
                          productId: int.parse("${widget.adModel?.id}"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.grey.shade200,
                      child: FavoriteButton(
                        productId: widget.adModel.id,
                        isFav: widget.adModel.is_wishlist,
                        adsUserId: widget.adModel.userId,
                        logInUserId: widget.logInUserId,
                        from: widget.form,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Icon(Icons.location_on_outlined,color: redColor,size: 16,),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Expanded(
          //       child: SizedBox(
          //         child: Text(adModel.address,maxLines: 1,
          //           // overflow: TextOverflow.ellipsis,
          //         ),
          //       ),
          //     ),
          //     // const Spacer(),
          //     PriceCardWidget(
          //       price: double.parse(adModel.price.toString()),
          //       offerPrice: -1,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
