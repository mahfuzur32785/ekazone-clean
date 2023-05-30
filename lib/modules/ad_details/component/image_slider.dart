import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ekayzone/core/remote_urls.dart';
import 'package:ekayzone/modules/ad_details/component/show_image.dart';
import 'package:ekayzone/modules/ad_details/component/show_single_image.dart';
import 'package:ekayzone/modules/ad_details/model/ad_details_model.dart';
import 'package:ekayzone/modules/home/component/single_offer_banner.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/modules/home/model/slider_model.dart';
import 'package:ekayzone/utils/extensions.dart';
import 'package:ekayzone/utils/k_images.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:ekayzone/widgets/custom_image.dart';
import 'dart:math' as math;


import '../../../widgets/favorite_button.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    Key? key,
    required this.gallery, required this.height, required this.adDetails,
  }) : super(key: key);

  final List<Gallery> gallery;
  final double height;
  final AdDetails adDetails;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  // final double height = 144;
  final int initialPage = 0;
  int _currentIndex = 0;

  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16,left: 16,right: 16),
      height: widget.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              height: widget.height,
              viewportFraction: 1,
              initialPage: initialPage,
              enableInfiniteScroll: widget.gallery.length > 1,
              reverse: false,
              autoPlay: widget.gallery.length > 1,
              // autoPlay: false,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.gallery.isNotEmpty ? widget.gallery
                .map((i) => GestureDetector(
              onTap: (){
                // Navigator.push(
                //     context,
                //     Utils.createPageRouteTop(context,ShowImage(
                //       galleries: widget.gallery,
                //       initialIndex: _currentIndex,
                //     )));
                Navigator.push(
                    context,
                    Utils.createPageRouteTop(context,ShowSingleImage(
                        imageUrl: widget.gallery[_currentIndex].imageUrl
                    )));
              },
                  child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  // image: DecorationImage(
                  //   image: NetworkImage(i.imageUrl),
                  //   fit: BoxFit.cover,
                  // ),
              ),
                    child: CustomImage(path: i.imageUrl,fit: BoxFit.cover,),
            ),
                ))
                .toList() : [
              GestureDetector(
                onTap: widget.adDetails.thumbnail != '' ? (){
                  Navigator.push(
                      context,
                      Utils.createPageRouteTop(context,ShowSingleImage(
                        imageUrl: '${RemoteUrls.rootUrl}${widget.adDetails.thumbnail}'
                      )));
                } : null,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    // image: DecorationImage(
                    //   image: NetworkImage(i.imageUrl),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: CustomImage(path: widget.adDetails.thumbnail != '' ? '${RemoteUrls.rootUrl}${widget.adDetails.thumbnail}' : null,fit: BoxFit.cover,),
                ),
              ),
            ] ,
          ),
          // Positioned(
          //   right: 4,
          //   top: 4,
          //   child: FavoriteButton(
          //     productId: widget.adDetails.id,
          //     isFav: widget.adDetails.wishListed,
          //   ),
          // ),
          // Positioned(
          //   left: 30,
          //   bottom: 4,
          //   child: LayoutBuilder(
          //     builder: (context,constraints) {
          //       if (widget.gallery.isEmpty) {
          //         return const SizedBox();
          //       }
          //       return DotsIndicator(
          //         dotsCount: widget.gallery.length,
          //         key: UniqueKey(),
          //         decorator: DotsDecorator(
          //           activeColor: const Color(0xff18587A),
          //           color: Colors.white,
          //           activeSize: const Size(14.0, 4.0),
          //           size: const Size(14.0, 4.0),
          //           activeShape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(5.0)),
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(5.0)),
          //         ),
          //         position: _currentIndex.toDouble(),
          //       );
          //     }
          //   ),
          // ),
          // Positioned(
          //   right: 36,
          //   bottom: 4,
          //   child: Text( widget.gallery.isEmpty ? "0/0" : "${_currentIndex+1}/${widget.gallery.length}",style: const TextStyle(color: Color(0xff18587A),fontWeight: FontWeight.w600),),
          // )

          // Positioned(child: child),
          Visibility(
            visible: widget.adDetails.featured == "1",
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
          ),

          Positioned(top: 0,bottom: 0,right: 0,child: GestureDetector(onTap: () {
            carouselController.nextPage();
          },child: const Icon(Icons.arrow_forward_ios, color: Colors.blue,)),),
          Positioned(top: 0,bottom: 0,left: 0,child: GestureDetector(onTap: () {
            carouselController.previousPage();
          },child: const Icon(Icons.arrow_back_ios, color: Colors.blue)),)
        ],
      ),
    );
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }
}
