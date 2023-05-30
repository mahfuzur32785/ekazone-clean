import 'package:ekayzone/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:ekayzone/widgets/compare_button.dart';
import 'package:flutter/material.dart';
import 'package:ekayzone/modules/home/component/price_card_widget.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../home/model/product_model.dart';

class ProductCard extends StatefulWidget {
  final AdModel? adModel;
  final double? width;
  final String? from;
  final int? index;
  final int? myId;
  final int? sellerId;
  final int? logInUserId;

  const ProductCard({
    Key? key,
    this.adModel,
    this.width,
    this.from,
    this.index,
    this.myId,
    this.sellerId,
    this.logInUserId
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.adDetails,
              arguments: widget.adModel!.slug);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildImage()),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Visibility(visible: widget.adModel!.price.isNotEmpty,child: Text("${context.read<HomeControllerCubit>().symbol} ${widget.adModel!.price}")),
          const SizedBox(height: 2),
          SizedBox(
            child: Text(
              widget.adModel!.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: blackColor, fontWeight: FontWeight.w500, height: 1),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Visibility(
                  visible: widget.adModel!.city.isNotEmpty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey.shade500,
                        size: 16,
                      ),
                      // Icon(Icons.location_on,color: Colors.grey.shade500,size: 16,),
                      Expanded(
                        child: Text(
                          "${widget.adModel?.city}",
                          maxLines: 1,
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
                      onTap: () async{
                        print("Compare");
                      },
                      child: CircleAvatar(
                        radius: 15,
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
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey.shade200,
                      child: FavoriteButton(
                        productId: widget.adModel!.id,
                        isFav: widget.adModel!.is_wishlist,
                        from: widget.from,
                        adsUserId: widget.adModel?.customer?.id,
                        logInUserId: widget.logInUserId,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ashColor)),
      ),
      // height: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            child: CustomImage(
                // path: RemoteUrls.imageUrl(productModel.image),
                path: widget.adModel!.thumbnail != ''
                    ? '${RemoteUrls.rootUrl}${widget.adModel!.thumbnail}'
                    : null,
                // path: adModel.imageUrl != '' ? adModel.imageUrl : null,
                fit: BoxFit.cover),
          ),
          // _buildOfferInPercentage(),
          widget.from=='home'||widget.from=='public_shop'||widget.from=='ads_screen' ? Container() : Positioned(
            top: 8,
            left: 8,
            child:
            FavoriteButton(productId: widget.adModel!.id, isFav: widget.adModel!.is_wishlist),
          ),
        ],
      ),
    );
  }
}
