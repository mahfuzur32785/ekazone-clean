 import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopAdsSlider extends StatelessWidget {
   const TopAdsSlider({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return CarouselSlider.builder(itemCount: 5, itemBuilder: (context, index, realIndex) {
       return Container(
         // margin: EdgeInsets.symmetric(vertical: 10),
         padding: EdgeInsets.all(16),
         height: 100,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(5),
             color: Colors.white,
             border: Border.all(color: Colors.grey.shade300)
         ),
         child: const Text("ohifsahfjsakf asf f af ksaljfh kasklajfh lah lakfhksf af ksaljfh kasknmklnkjlkjnkjnklklajfh lah lakfhksf af ksaljfh kasklajfh lah lakfhksfjhklaf"),
       );
     }, options: CarouselOptions(
       autoPlay: true,
       scrollDirection: Axis.vertical,
       viewportFraction: 1,
       // clipBehavior: Clip.none,

     ));
   }
 }
