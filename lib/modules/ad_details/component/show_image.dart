import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ekayzone/widgets/custom_image.dart';

import '../../home/model/ad_model.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({Key? key,required this.galleries, required this.initialIndex}) : super(key: key);
  final List<Gallery> galleries;
  final int initialIndex;

  @override
  ShowImageState createState() => ShowImageState();
}

class ShowImageState extends State<ShowImage> {

  @override
  void initState() {
    currentPage = widget.initialIndex;
    super.initState();
  }

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28282B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        systemOverlayStyle: Platform.isIOS ? SystemUiOverlayStyle.dark : const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      // backgroundColor: Colors.white.withOpacity(0.3),
      body: SafeArea(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget.galleries[currentPage].imageUrl),
              initialScale: PhotoViewComputedScale.contained * 1,
              heroAttributes: PhotoViewHeroAttributes(tag: widget.galleries[currentPage].id),
            );
          },
          itemCount: widget.galleries.length,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
          // backgroundDecoration: widget.backgroundDecoration,
          pageController: pageController,
          onPageChanged: (value){
            setState(() {
              currentPage = value;
            });
          },
        )
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.max,
        //   children: [
        //     Expanded(
        //       flex: 1,
        //       child: InteractiveViewer(
        //         constrained: true,
        //         scaleEnabled: true,
        //         maxScale: 3,
        //         minScale: 1,
        //         boundaryMargin: const EdgeInsets.all(0),
        //         child: Stack(
        //           children: [
        //             Container(
        //               decoration: const BoxDecoration(color: Colors.transparent),
        //               height: double.infinity,
        //               width: double.infinity,
        //               child: Center(
        //                 child: PageView.builder(
        //                     scrollBehavior: const ScrollBehavior(),
        //                     reverse: false,
        //                     pageSnapping: true,
        //
        //                     scrollDirection: Axis.horizontal,
        //                     // controller: _pageController,
        //                     onPageChanged: (value) {
        //                       setState(() {
        //                         currentPage = value;
        //                       });
        //                     },
        //                     itemCount: widget.galleries.length,
        //                     itemBuilder: (context, index) => CustomImage(path: widget.galleries[currentPage].imageUrl)
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               // bottom: 20,
        //               alignment: Alignment.bottomCenter,
        //               child: Container(
        //                 margin: const EdgeInsets.only(bottom: 20),
        //                 padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        //                 decoration: BoxDecoration(
        //                     color: Colors.grey.withOpacity(0.1),
        //                     borderRadius: BorderRadius.circular(30.0)),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     ...List.generate(widget.galleries.length,
        //                             (index) => buildDot(index))
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }

  int currentPage = 0;

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 12 : 6,
      decoration: ShapeDecoration(
          color: currentPage == index
              ? Colors.lightGreen
              : Colors.lightGreen.withOpacity(0.3),
          shape: const StadiumBorder()
      ),
    );
  }

}
