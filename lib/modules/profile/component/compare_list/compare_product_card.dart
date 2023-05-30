import 'package:ekayzone/core/remote_urls.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/modules/profile/controller/compare_list/compare_list_cubit.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:ekayzone/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class CompareProductCard extends StatefulWidget {
  final AdModel? adModel;
  final double? width;
  final int index;
  final dynamic userData;
  const CompareProductCard({
    Key? key,
    this.adModel,
    this.width,
    required this.userData,
    required this.index,
  }) : super(key: key);

  @override
  State<CompareProductCard> createState() => _CompareProductCardState();
}

class _CompareProductCardState extends State<CompareProductCard> {
  var box;

  @override
  Widget build(BuildContext context) {
    box = Hive.box('compareList');

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
            _buildContent(),
          ],
        ),
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
          // Positioned(
          //   top: 8,
          //   left: 8,
          //   child:
          //   FavoriteButton(productId: adModel!.id, isFav: adModel!.is_wishlist),
          // ),
        ],
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
          SizedBox(
            child: Text(
              "${widget.adModel?.title}",
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
          const SizedBox(height: 5),
          SizedBox(
            child: Text(
              "${widget.adModel?.category?.name.toString()}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold, height: 1),
            ),
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: "${widget.adModel?.price}".toString().isNotEmpty,
            child: Text(
              "\$${widget.adModel?.price}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
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
                        "Dhaka",
                        maxLines: 1,
                        style: TextStyle(color: Colors.grey.shade500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.userData != null) {
                          Navigator.pushNamed(context, RouteNames.chatDetails, arguments: widget.adModel?.customer?.username);
                        } else {
                          Utils.openSignInDialog(context);
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF198754)),
                          child: const Icon(
                            Icons.chat_outlined,
                            size: 15,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // FavoriteButton(productId: adModel!.id, isFav: adModel!.is_wishlist);
                        await box.delete(widget.index);
                        print(
                            'Compare list length ${box.length} box index ${box.keys.map((e) => e).toList()} box item ${box.values.map((e) => e).toList()}');
                        Future.microtask(() => context
                            .read<CompareListCubit>()
                            .getCompareList(
                            true, box.values.map((e) => e).toList()));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red),
                          child: const Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.white,
                          )),
                    ),
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
}
