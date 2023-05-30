import 'package:flutter/material.dart';
import 'package:ekayzone/modules/ad_details/model/ad_details_model.dart';
import 'package:ekayzone/modules/home/component/price_card_widget.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../home/model/product_model.dart';

class CustomerAdCard extends StatelessWidget {
  final AdDetails adModel;
  final double? width;
  const CustomerAdCard({
    Key? key,
    required this.adModel,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: ashColor),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.adDetails,arguments: adModel.slug);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildImage()),
            const SizedBox(height: 8),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  "${adModel.category?.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: blackColor.withOpacity(.5),
                  ),
                ),
              ),
              const Spacer(),
              PriceCardWidget(
                price: double.parse(adModel.price.toString()),
                offerPrice: -1,
              ),
              // Text('${productModel.rating}'),
            ],
          ),
          const SizedBox(height: 3),
          SizedBox(
            child: Text(
              adModel.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: blackColor,fontWeight: FontWeight.w500, height: 1),
            ),
          ),
          const SizedBox(height: 3),
          const Divider(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(adModel.status,style: TextStyle(fontSize: 13),),
              const Spacer(),
              SizedBox(
                width: 70,
                height: 34,
                child: OutlinedButton(
                    onPressed: (){},
                    child: const Text("Edit",style: TextStyle(fontSize: 13),)
                ),
              ),
              const SizedBox(width: 6,)
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
                path: adModel.thumbnail != '' ? '${RemoteUrls.rootUrl}${adModel.thumbnail}' : null,
                // path: adModel.imageUrl != '' ? adModel.imageUrl : null,
                fit: BoxFit.cover
            ),
          ),
          // _buildOfferInPercentage(),
          Positioned(
            top: 8,
            left: 8,
            child: FavoriteButton(productId: adModel.id, isFav: adModel.wishListed),
          ),
        ],
      ),
    );
  }
}
