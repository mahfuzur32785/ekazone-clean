import 'package:ekayzone/modules/home/model/pricing_model.dart';
import 'package:ekayzone/modules/price_planing/plan_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/ads/controller/customer_ads/customer_ads_bloc.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:ekayzone/widgets/custom_image.dart';
import 'package:intl/intl.dart';

import 'dart:math' as math;

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../ad_details/model/ad_details_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomerAdListCard extends StatefulWidget {
  final AdDetails adModel;
  final Function deleteAd;
  const CustomerAdListCard({
    Key? key,
    required this.adModel,
    required this.deleteAd,
  }) : super(key: key);

  @override
  State<CustomerAdListCard> createState() => _CustomerAdListCardState();
}

class _CustomerAdListCardState extends State<CustomerAdListCard> {

  late CustomerAdsBloc customerAdsBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerAdsBloc = context.read<CustomerAdsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final userAdBloc = context.read<CustomerAdsBloc>();

    return GestureDetector(
      // onTap: (){
      //   Navigator.pushNamed(context, RouteNames.adDetails,arguments: adModel.slug).then((value) {
      //
      //   });
      // },
      // child: Container(
      //   margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      //   padding: EdgeInsets.only(right: 10,),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(16),
      //     color: Colors.white,
      //   ),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       IntrinsicHeight(
      //         child: Row(
      //           crossAxisAlignment: CrossAxisAlignment.stretch,
      //           children: [
      //             ClipRRect(
      //               borderRadius: BorderRadius.circular(16),
      //               child: Container(
      //                 width: 120,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(16)
      //                 ),
      //                 child: CustomImage(
      //                   width: 120,
      //                   fit: BoxFit.cover,
      //                   path: adModel.thumbnail != '' ? '${RemoteUrls.rootUrl}${adModel.thumbnail}' : null,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(width: 10,),
      //             Expanded(
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   SizedBox(
      //                     height: 8,
      //                   ),
      //                   SizedBox(
      //                       child: Text(adModel.title,
      //                         maxLines: 2,
      //                         style: TextStyle(fontSize: 16),overflow: TextOverflow.ellipsis,)),
      //                   SizedBox(child: PriceCardWidget(
      //                     price: double.parse(adModel.price.toString()),
      //                     offerPrice: -1,
      //                   ),),
      //                   SizedBox(child: Text('${AppLocalizations.of(context).translate(adModel.status)}')),
      //                   SizedBox(
      //                     height: 8,
      //                   ),
      //                   Row(
      //                     children: [
      //                       Expanded(
      //                         child: SizedBox(
      //                           height: 38,
      //                           child: OutlinedButton(
      //                             style: OutlinedButton.styleFrom(foregroundColor: Colors.black87,side: BorderSide(color: Colors.black87)),
      //                               onPressed: (){
      //                                 Navigator.pushNamed(context, RouteNames.adEditScreen,arguments: adModel);
      //                               },
      //                               child: Text("${AppLocalizations.of(context).translate("edit")}",style: TextStyle(fontSize: 13),)
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         width: 10,
      //                       ),
      //                       Expanded(
      //                         child: SizedBox(
      //                           height: 38,
      //                           child: OutlinedButton(
      //                               style: OutlinedButton.styleFrom(foregroundColor: Colors.black87,side: BorderSide(color: Colors.black87)),
      //                               onPressed: () async {
      //                                 Utils.loadingDialog(context);
      //                                 final result = await userAdBloc.deleteMyAd(adModel.id);
      //                                 result.fold((error) {
      //                                   Utils.closeDialog(context);
      //                                   Utils.showSnackBar(context, error.message);
      //                                 }, (data) {
      //                                   Utils.closeDialog(context);
      //                                   deleteAd();
      //                                   Utils.showSnackBar(context, data);
      //                                 }
      //                                 );
      //                               },
      //                               child: Text("${AppLocalizations.of(context).translate("delete")}",style: TextStyle(fontSize: 13),)
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     height: 8,
      //                   ),
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      onTap: () {
        Navigator.pushNamed(context, RouteNames.adDetails,
                arguments: widget.adModel.slug)
            .then((value) {});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(height: 0),
            _buildContent(context, userAdBloc),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(context,userAdBloc) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.only(top: 5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: Border.fromBorderSide(
              BorderSide(color: Color(0xffd5d2d2), width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Cattegory Name
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.layers_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    "${widget.adModel.category?.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                ),
                // Text('${productModel.rating}'),
              ],
            ),
          ),
          const SizedBox(height: 6),
          //Post Title
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    widget.adModel.title,
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
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Active status and date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.adModel.status == "active" ? const Color(0xFF198754) : widget.adModel.status == "sold" ? const Color(0xFF0DCAF0) : const Color(0xFFFFC107),
                  ),
                  child: Text(
                    widget.adModel.status,
                    style: TextStyle(
                        color: widget.adModel.status == "active" ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  DateFormat('d MMM yyyy').format(DateTime.parse("${widget.adModel.createdAt}")),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          const Divider(
            color: Color(0xffd5d2d2),
          ),

          //Price and Edit delete option
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: widget.adModel.price.isNotEmpty,
                  child: Text(
                    'R${widget.adModel.price}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                  child: Row(
                    children: [

                      Visibility(
                        visible: widget.adModel.featured != "1",
                        child: GestureDetector(
                          onTap: () {
                            print('Promoted ads');
                            showPromoteDialog(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFF198754)),
                            child: const FaIcon(
                              FontAwesomeIcons.moneyBill,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.adEditScreen,
                              arguments: widget.adModel);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF198754)),
                          // child: Text('${adModel.galleries.length}'),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          Utils.showCustomDialog(
                              context,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Are you sure?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Center(
                                      child: Text(
                                        "Do you want to delete this ad?",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              foregroundColor: redColor),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              foregroundColor: redColor),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            Utils.loadingDialog(context);
                                            final result = await userAdBloc.deleteMyAd(widget.adModel.id);
                                            result.fold((error) {
                                              Utils.closeDialog(context);
                                              Utils.showSnackBar(context, error.message);
                                            }, (data) {
                                              Utils.closeDialog(context);
                                              widget.deleteAd();
                                              Utils.showSnackBar(context, data);
                                            });
                                          },
                                          child: const Text("Ok"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                              )
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     Utils.loadingDialog(context);
                      //     final result = await userAdBloc.deleteMyAd(widget.adModel.id);
                      //     result.fold((error) {
                      //       Utils.closeDialog(context);
                      //       Utils.showSnackBar(context, error.message);
                      //     }, (data) {
                      //       Utils.closeDialog(context);
                      //       widget.deleteAd();
                      //       Utils.showSnackBar(context, data);
                      //     });
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.all(5),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       color: Colors.red,
                      //     ),
                      //     child: const Icon(
                      //       Icons.delete_outline,
                      //       color: Colors.white,
                      //       size: 15,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Container(
              width: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              child: CustomImage(
                width: 120,
                fit: BoxFit.cover,
                path: widget.adModel.thumbnail != ''
                    ? '${RemoteUrls.rootUrl}${widget.adModel.thumbnail}'
                    : null,
              ),
            ),
          ),
          Visibility(
            visible: widget.adModel.featured == "1",
            child: Positioned(
              top: 17,
              left: -10,
              child: Transform.rotate(
                angle: -math.pi / 4.1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  decoration: BoxDecoration(
                      color: const Color(0xFF2DBE6C),
                      borderRadius: BorderRadius.circular(10)
                    // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                  ),
                  child: const Text('Featured',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showPromoteDialog(context) {
    showModalBottomSheet(context: context, isDismissible: true, builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: () => Navigator.pop(context),icon: const Icon(Icons.close,size: 25,)),
                ),
                const Row(
                  children: [
                    Text('Promotion Package ',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16),),
                    Text('*',style: TextStyle(color: Colors.red, fontSize: 14,fontWeight: FontWeight.bold),)
                  ],
                ),
                const SizedBox(height: 15),

                DropdownButtonFormField(
                  isExpanded: true,
                  decoration: const InputDecoration(
                    hintText: "Select Plan",
                  ),
                  items:
                  customerAdsBloc.pricingList.map<DropdownMenuItem<PricingModel>>((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text("${e.title} for R${e.price}.00"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      customerAdsBloc.id = value!.id;
                      customerAdsBloc.price = value.price;
                      customerAdsBloc.title = value.title;
                    });
                  },
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                    onPressed: (){
                      if(customerAdsBloc.price.isNotEmpty) {
                        print("Redirect in payment screen");
                        Navigator.pushNamed(context, RouteNames.planDetailsScreen, arguments: PlanDetailsScreenArguments(widget.adModel, customerAdsBloc.id, customerAdsBloc.title, customerAdsBloc.price)).then((value){
                          Navigator.pop(context);
                        });
                      }else{
                        Navigator.pop(context);
                        Utils.showSnackBar(context, "Select Your Plan");
                      }
                      // Navigator.pushNamed(context, RouteNames.privacyPolicyScreen);
                    },
                    child: const Text('Promote',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),);
        },
      );
    },).then((value){
      setState(() {
        customerAdsBloc.price = '';
      });
    });
  }
}
