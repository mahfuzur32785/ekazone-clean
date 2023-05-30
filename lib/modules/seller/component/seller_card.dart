import 'package:flutter/material.dart';
import 'package:ekayzone/modules/authentication/models/user_prfile_model.dart';
import 'package:ekayzone/modules/home/component/price_card_widget.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../home/model/product_model.dart';

class SellerCard extends StatelessWidget {
  final UserProfileModel seller;
  final double? width;
  const SellerCard({
    Key? key,
    required this.seller,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          Navigator.pushNamed(context, RouteNames.publicProfile,arguments: seller.username);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildImage()),
            const SizedBox(height: 8),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Text(
              seller.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: blackColor,fontSize: 15,fontWeight: FontWeight.w500, height: 1),
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "${seller.avgRating?.substring(0,1)} Star rating \n( ${seller.reviewCount} Review)",
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      // height: 150,
      child: CircleAvatar(
        radius: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CustomImage(
            // path: RemoteUrls.imageUrl(productModel.image),
              path: seller.image != '' ? '${RemoteUrls.rootUrl}${seller.image}' : null,
              fit: BoxFit.cover
          ),
        ),
      ),
    );
  }
}
