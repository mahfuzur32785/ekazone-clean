import 'package:flutter/material.dart';
import 'package:ekayzone/utils/k_images.dart';
import 'package:ekayzone/widgets/custom_image.dart';

import '../../../utils/constants.dart';

class AdsAppBar {
  static appBar(context){
    return SliverAppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      centerTitle: true,
      scrolledUnderElevation: 0,
      title: CustomImage(
        path: Kimages.logoColor,
        height: 50,
      ),
      leading: GestureDetector(onTap: () {
        Navigator.pop(context);
      },child: Icon(Icons.arrow_back,color: Colors.black,)),
      // floating: true,
      // snap: true,
      // pinned: false,
      // centerTitle: true,
      // leading: IconButton(
      //   onPressed: (){
      //     mainController.naveListener.add(0);
      //   },
      //   icon: const Icon(Icons.arrow_back_sharp,color: Colors.black87,),
      // ),
      // title: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     GestureDetector(
      //       onTap: (){
      //         mainController.naveListener.add(0);
      //       },
      //       child: const CustomImage(path: Kimages.logoColor,height: 50,),
      //     )
      //   ],
      // ),
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: redColor,
      //     statusBarIconBrightness: Brightness.light),
      // // flexibleSpace: SizedBox.expand(),
      // bottom: PreferredSize(
      //   preferredSize: const Size(double.infinity, 120),
      //   child: Container(
      //     decoration: const BoxDecoration(
      //         color: Colors.white,
      //         borderRadius:
      //         BorderRadius.vertical(top: Radius.circular(10))),
      //     child: Column(
      //       children: [
      //         const Divider(
      //           height: 0.5,
      //         ),
      //         Row(
      //           children: [
      //             // Expanded(
      //             //     child: Material(
      //             //       color: Colors.white,
      //             //       borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      //             //       child: InkWell(
      //             //         onTap: () {
      //             //           Navigator.pushNamed(context, RouteNames.locationSelection);
      //             //         },
      //             //         child: Container(
      //             //             height: 48,
      //             //             padding:
      //             //             const EdgeInsets.symmetric(horizontal: 16),
      //             //             child: Center(
      //             //               child: Row(
      //             //                 children: const [
      //             //                   Icon(Icons.location_on_outlined,size: 16,),
      //             //                   SizedBox(
      //             //                     width: 4,
      //             //                   ),
      //             //                   Text("Location"),
      //             //                 ],
      //             //               ),
      //             //             )
      //             //         ),
      //             //       ),
      //             //     )),
      //             // Container(
      //             //   width: 0.5,
      //             //   height: 35,
      //             //   color: Colors.grey,
      //             // ),
      //             Expanded(
      //                 child: BlocBuilder<CategoryBloc,CategoryState>(
      //                   builder: (context,state){
      //                     return Material(
      //                       color: Colors.white,
      //                       child: InkWell(
      //                         onTap: () {
      //                           Navigator.pushNamed(context, RouteNames.categorySelection);
      //                         },
      //                         child: Container(
      //                             height: 48,
      //                             padding:
      //                             const EdgeInsets.symmetric(horizontal: 16),
      //                             child: Center(
      //                               child: Row(
      //                                 children: [
      //                                   const Icon(Icons.category,size: 16,),
      //                                   const SizedBox(
      //                                     width: 4,
      //                                   ),
      //                                   Expanded(child: SizedBox(child: Text(categoryBloc.getCategoryName(context),maxLines: 1,overflow: TextOverflow.ellipsis,))),
      //                                   const Icon(Icons.arrow_drop_down)
      //                                 ],
      //                               ),
      //                             )
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                 )
      //             ),
      //             Container(
      //               width: 0.5,
      //               height: 35,
      //               color: Colors.grey,
      //             ),
      //
      //             CustomPopupMenu(
      //                 pressType: PressType.singleClick,
      //                 position: PreferredPosition.bottom,
      //                 showArrow: false,
      //                 verticalMargin: 4,
      //                 horizontalMargin: 0,
      //                 controller: menuController,
      //                 // barrierColor: Colors.transparent,
      //                 child: Material(
      //                   color: Colors.white,
      //                   borderRadius:
      //                   const BorderRadius.only(topRight: Radius.circular(10)),
      //                   child: InkWell(
      //                     onTap: () {
      //                       menuController.showMenu();
      //                     },
      //                     child: Container(
      //                         height: 48,
      //                         padding:
      //                         const EdgeInsets.symmetric(horizontal: 16),
      //                         child: const Center(
      //                             child: Icon(Icons.filter_alt_outlined))),
      //                   ),
      //                 ),
      //                 menuOnChange: (val) {},
      //                 menuBuilder: () => StatefulBuilder(
      //                     builder: (context,setState) {
      //                       return ConstrainedBox(
      //                         constraints: BoxConstraints(
      //                           minHeight: MediaQuery.of(context).size.width,
      //                         ),
      //                         child: Container(
      //                           width: double.infinity,
      //                           decoration: const BoxDecoration(
      //                             color: Colors.white,
      //                           ),
      //                           padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text("${AppLocalizations.of(context).translate("price_sorting")}",style: const TextStyle(color: redColor,fontSize: 18,fontWeight: FontWeight.w600),),
      //                               const SizedBox(
      //                                 height: 10,
      //                               ),
      //                               Wrap(
      //                                 spacing: 16,
      //                                 runSpacing: 16,
      //                                 children: [
      //                                   ...List.generate(searchAdsBloc.sortingList.length, (index) {
      //                                     return Material(
      //                                       borderRadius: BorderRadius.circular(30),
      //                                       color: searchAdsBloc.sortingText == searchAdsBloc.sortingList[index] ? redColor : Colors.transparent,
      //                                       child: InkWell(
      //                                         borderRadius: BorderRadius.circular(30),
      //                                         onTap: (){
      //                                           searchAdsBloc.sortingText = searchAdsBloc.sortingList[index];
      //                                           searchAdsBloc.add(SearchAdsEventSearch(searchCtr.text, '', '', '', '', '', categoryBloc.categorySlug, categoryBloc.subCategorySlug));
      //                                           menuController.hideMenu();
      //                                         },
      //                                         child: Container(
      //                                           padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      //                                           decoration: BoxDecoration(
      //                                             border: Border.all(color: redColor),
      //                                             borderRadius: BorderRadius.circular(30),
      //                                           ),
      //                                           child: Text(searchAdsBloc.sortingList[index],style: TextStyle(color: searchAdsBloc.sortingText == searchAdsBloc.sortingList[index] ? Colors.white : redColor),),
      //                                         ),
      //                                       ),
      //                                     );
      //                                   })
      //                                 ],
      //                               ),
      //                               const SizedBox(
      //                                 height: 24,
      //                               ),
      //                               Text("${AppLocalizations.of(context).translate("price_range")}",style: const TextStyle(color: redColor,fontSize: 18,fontWeight: FontWeight.w600),),
      //                               const SizedBox(
      //                                 height: 10,
      //                               ),
      //                               Row(
      //                                 children: [
      //                                   Text("${searchAdsBloc.rangeValues.start.round().toString()} VT",style: TextStyle(color: redColor,fontSize: 14,fontWeight: FontWeight.w400),),
      //                                   const SizedBox(
      //                                     width: 0,
      //                                   ),
      //                                   Expanded(
      //                                     child: RangeSlider(
      //                                       max: 20000,
      //                                       min: 0,
      //                                       divisions: 1000,
      //                                       inactiveColor: const Color(0xFFF4F4F4),
      //                                       activeColor: redColor,
      //                                       values: searchAdsBloc.rangeValues,
      //                                       onChanged: (val){
      //                                         setState((){
      //                                           searchAdsBloc.rangeValues = val;
      //                                         });
      //                                       },
      //                                       labels: RangeLabels(
      //                                           "${searchAdsBloc.rangeValues.start.round().toString()} VT",
      //                                           "${searchAdsBloc.rangeValues.end.round().toString()} VT"
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 0,
      //                                   ),
      //                                   Text("${searchAdsBloc.rangeValues.end.round().toString()} VT",style: const TextStyle(color: redColor,fontSize: 14,fontWeight: FontWeight.w500),),
      //                                 ],
      //                               ),
      //                               const SizedBox(
      //                                 height: 16,
      //                               ),
      //                               Align(
      //                                 alignment: Alignment.bottomRight,
      //                                 child: ConstrainedBox(
      //                                   constraints: const BoxConstraints(
      //                                       maxHeight: 40,
      //                                       maxWidth: 150
      //                                   ),
      //                                   child: ElevatedButton(
      //                                     onPressed: (){
      //                                       searchAdsBloc.add(SearchAdsEventSearch(searchCtr.text, '', '', '', '', '', categoryBloc.categorySlug, categoryBloc.subCategorySlug));
      //                                       menuController.hideMenu();
      //                                     },
      //                                     child: Text("${AppLocalizations.of(context).translate("apply")}",style: const TextStyle(color: Colors.white),),
      //                                   ),
      //                                 ),
      //                               )
      //                             ],
      //                           ),
      //                         ),
      //                       );
      //                     }
      //                 )),
      //
      //
      //           ],
      //         ),
      //         const Divider(
      //           height: 0.5,
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //                 child: Material(
      //                   color: Colors.white,
      //                   child: InkWell(
      //                     onTap: () {},
      //                     child: Container(
      //                       height: 50,
      //                       padding: const EdgeInsets.symmetric(horizontal: 0),
      //                       child: Center(
      //                         child: TextFormField(
      //                           controller: searchCtr,
      //                           keyboardType: TextInputType.name,
      //                           textInputAction: TextInputAction.search,
      //                           onChanged: (value){
      //                             searchAdsBloc.add(SearchAdsEventSearch(value,'','','','','','','',));
      //                           },
      //                           decoration: InputDecoration(
      //                               hintText: '${AppLocalizations.of(context).translate('search')}',
      //                               prefixIcon: Icon(Icons.search),
      //                               border: InputBorder.none,
      //                               enabledBorder: InputBorder.none),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 )),
      //             Container(
      //               width: 0.5,
      //               height: 35,
      //               color: Colors.grey,
      //             ),
      //             Material(
      //               color: Colors.white.withOpacity(0.7),
      //               child: InkWell(
      //                 onTap: () {},
      //                 child: Container(
      //                     height: 50,
      //                     padding:
      //                     const EdgeInsets.symmetric(horizontal: 16),
      //                     child: Center(
      //                       child: Text("${AppLocalizations.of(context).translate('search')}"),
      //                     )),
      //               ),
      //             )
      //           ],
      //         ),
      //         const Divider(
      //           height: 0.5,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}