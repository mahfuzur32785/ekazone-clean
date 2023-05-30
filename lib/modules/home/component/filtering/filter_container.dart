import 'package:flutter/material.dart';

import '../../../../core/router_name.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/custom_textfeild.dart';

class FilterContainer extends StatelessWidget {
  FilterContainer({Key? key, this.selectedCity,this.locationController,this.searchController,this.selectedCategory}) : super(key: key);

  String? selectedCategory;
  TextEditingController? searchController;
  TextEditingController? locationController;
  String? selectedCity;


  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return Container(
    //       padding: const EdgeInsets.only(
    //           left: 14, right: 14, top: 14, bottom: 14),
    //       margin: const EdgeInsets.only(bottom: 40),
    //       decoration: const BoxDecoration(
    //         color: Color(0XFFF7E7F3),
    //       ),
    //       child: Container(
    //         decoration: BoxDecoration(
    //             border:
    //             Border.all(color: Colors.black12, width: 8),
    //             borderRadius: BorderRadius.circular(8)),
    //         child: Column(
    //           children: [
    //             Container(
    //               color: Colors.white,
    //               padding: const EdgeInsets.symmetric(
    //                   horizontal: 18),
    //               height: 48,
    //               child: DropdownButtonHideUnderline(
    //                   child: DropdownButton<dynamic>(
    //                     hint: const Text('Select category',
    //                         style: TextStyle(color: Colors.black)),
    //                     isDense: true,
    //                     isExpanded: true,
    //                     onChanged: (dynamic value) {
    //                       selectedCategory = value;
    //                       print(selectedCategory);
    //                       setState(() {
    //
    //                       });
    //                     },
    //                     value: selectedCategory,
    //                     items: state.homeModel.categories.map((item) {
    //                       return DropdownMenuItem(
    //                         value: item.slug,
    //                         child: Text(item.name),
    //                       );
    //                     }).toList(),
    //                   )),
    //             ),
    //             CstmTextFeild(
    //               isObsecure: false,
    //               controller: searchController,
    //               hintext: "What are you looking for?",
    //             ),
    //             CstmTextFeild(
    //               isObsecure: false,
    //               controller: locationController,
    //               hintext: "Location",
    //             ),
    //             Container(
    //               color: Colors.white,
    //               padding: const EdgeInsets.symmetric(
    //                   horizontal: 18),
    //               height: 48,
    //               child: DropdownButtonHideUnderline(
    //                   child: DropdownButton<String>(
    //                     hint: const Text('Entire city',
    //                         style: TextStyle(color: Colors.black)),
    //                     isDense: true,
    //                     isExpanded: true,
    //                     onChanged: (dynamic value) {
    //                       selectedCity = value;
    //                       print(selectedCity);
    //                       setState(() {
    //
    //                       });
    //                     },
    //                     value: selectedCity,
    //                     items: dropDownListData.map((location) {
    //                       return DropdownMenuItem(
    //                         value: location,
    //                         child: Text(location),
    //                       );
    //                     }).toList(),
    //                   )),
    //             ),
    //             SizedBox(
    //               height: 48,
    //               child: ElevatedButton(
    //                 onPressed: () {
    //                   Navigator.pushNamed(context, RouteNames.adsScreen, arguments: [
    //                     selectedCategory, searchController!.text, locationController!.text, selectedCity
    //                   ],
    //                   );
    //                 },
    //                 style: ElevatedButton.styleFrom(
    //                     shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.zero),
    //                     backgroundColor:
    //                     const Color(0xFF212d6e)),
    //                 child: const Text("Find it"),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
  }
}
