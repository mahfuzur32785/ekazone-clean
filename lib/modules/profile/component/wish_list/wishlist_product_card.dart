import 'package:ekayzone/core/remote_urls.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:ekayzone/widgets/custom_image.dart';
import 'package:ekayzone/widgets/favorite_button.dart';
import 'package:flutter/material.dart';

class WishListProductCard extends StatelessWidget {
  final AdModel? adModel;
  final double? width;
  final String? form;
  const WishListProductCard({
    Key? key,
    this.adModel,
    this.width, this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.adDetails,
              arguments: adModel!.slug);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildImage()),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.layers_outlined,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  "${adModel?.category?.name.toString()}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
              ),
              // Text('${productModel.rating}'),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  "${adModel?.title}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                    color: paragraphColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(visible: adModel!.price.isNotEmpty,child: Text("\$${adModel!.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),
              SizedBox(
                child: Text(
                  Utils.dateFormat("${adModel?.createdAt}"),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: blackColor, fontWeight: FontWeight.w600, height: 1),
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
                path: adModel!.thumbnail != ''
                    ? '${RemoteUrls.rootUrl}${adModel!.thumbnail}'
                    : null,
                // path: adModel.imageUrl != '' ? adModel.imageUrl : null,
                fit: BoxFit.cover),
          ),
          // _buildOfferInPercentage(),
          Positioned(
            top: 8,
            left: 8,
            child:
            FavoriteButton(productId: adModel!.id, isFav: adModel!.is_wishlist,from: form,),
          ),
        ],
      ),
    );
  }
}
