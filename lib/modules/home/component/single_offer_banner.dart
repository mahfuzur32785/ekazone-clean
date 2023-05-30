import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../model/slider_model.dart';

class SingleOfferBanner extends StatelessWidget {
  const SingleOfferBanner({
    Key? key,
    required this.slider,
  }) : super(key: key);
  final SliderModel slider;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: NetworkImage(RemoteUrls.imageUrl(slider.image)),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        color: Colors.black.withOpacity(.1),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FittedBox(
            //   child: Text(
            //     slider.title,
            //     style: GoogleFonts.poppins(
            //       height: 1.5,
            //       fontSize: 20.0,
            //       color: const Color(0xff18587A),
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 2),
            Text(
              slider.description,
              maxLines: 2,
              style: const TextStyle(
                  fontSize: 10, color: Color(0xff333333), height: 1.6),
            ),
            const SizedBox(height: 10),
            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     height: 27,
            //     width: 75,
            //     padding: const EdgeInsets.symmetric(horizontal: 8),
            //     decoration: BoxDecoration(
            //       color: redColor,
            //       borderRadius: BorderRadius.circular(4),
            //     ),
            //     alignment: Alignment.center,
            //     child: const Text(
            //       'Shop now',
            //       style: TextStyle(
            //           fontSize: 12,
            //           fontWeight: FontWeight.w500,
            //           color: Colors.white),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
