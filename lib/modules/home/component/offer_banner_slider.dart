import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ekayzone/modules/home/component/single_offer_banner.dart';
import 'package:ekayzone/modules/home/model/slider_model.dart';

class OfferBannerSlider extends StatefulWidget {
  const OfferBannerSlider({
    Key? key,
    required this.sliders,
  }) : super(key: key);

  final List<SliderModel> sliders;

  @override
  State<OfferBannerSlider> createState() => _OfferBannerSliderState();
}

class _OfferBannerSliderState extends State<OfferBannerSlider> {
  final double height = 144;
  final int initialPage = 0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16,left: 16,right: 16),
      height: height,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1,
              initialPage: initialPage,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.sliders
                .map((i) => SingleOfferBanner(slider: i))
                .toList(),
          ),
          Positioned(
            left: 36,
            bottom: 4,
            child: DotsIndicator(
              dotsCount: widget.sliders.length,
              key: UniqueKey(),
              decorator: DotsDecorator(
                activeColor: const Color(0xff18587A),
                color: Colors.white,
                activeSize: const Size(14.0, 4.0),
                size: const Size(14.0, 4.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              position: _currentIndex.toDouble(),
            ),
          )
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
