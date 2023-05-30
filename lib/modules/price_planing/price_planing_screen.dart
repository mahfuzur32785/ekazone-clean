import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/dummy_data/all_dudmmy_data.dart';
import 'package:ekayzone/modules/price_planing/controller/pricing_cubit.dart';
import 'package:ekayzone/modules/home/model/pricing_model.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:ekayzone/widgets/custom_image.dart';

class PricePlaningScreen extends StatefulWidget {
  const PricePlaningScreen({Key? key}) : super(key: key);

  @override
  State<PricePlaningScreen> createState() => _PricePlaningScreenState();
}

class _PricePlaningScreenState extends State<PricePlaningScreen> {
  int _currentIndex = 0;
  final int initialPage = 0;

  String getDuration(featureAds){
    if (featureAds > 50 ) return "/Yearly";
    if (featureAds >= 10 ) return "/Monthly";
    return "/1 Day";
  }

  Map<String , dynamic>? paymentIntent;

  PricingModel? pricingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyColor,
      body: SafeArea(
        child: BlocBuilder<PricingCubit,PricingState>(
          builder: (context,state) {
            if (state is PricingStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PricingStateError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is PricingStateLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(width: double.infinity,child: Text("Choose Your Plan",textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w500),)),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: CarouselSlider(
                              options: CarouselOptions(
                                height: double.infinity,
                                viewportFraction: 0.8,
                                initialPage: initialPage,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 5),
                                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                onPageChanged: callbackFunction,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: [
                                ...List.generate(state.pricingList.length, (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          width: double.infinity,
                                          height: 16,
                                        ),
                                        CustomImage(path: plansBillingList[index].image,height: 100,width: 100,),
                                        Text('${state.pricingList[index].title}',style: const TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w600),),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        const Spacer(),
                                        RichText(
                                          text: TextSpan(
                                              text: "${Utils.formatPrice(state.pricingList[index].price)}",
                                              style: const TextStyle(color: redColor,fontSize: 30,fontWeight: FontWeight.w600),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: " ${getDuration(state.pricingList[index].orderId)}",
                                                  style: const TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w400),
                                                )
                                              ]
                                          ),
                                        ),

                                        const Spacer(),

                                        const Divider(
                                          height: 30,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 16,
                                                backgroundColor: redColor,
                                                child: Center(
                                                  child: Icon(Icons.check,color: Colors.white,size: 20,),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text("Post ${state.pricingList[index].status} Ads",style: const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 16,
                                                backgroundColor: redColor,
                                                child: Center(
                                                  child: Icon(Icons.check,color: Colors.white,size: 20,),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text("${state.pricingList[index].orderId} Feature Ads",style: const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ],
                                          ),
                                        ),
                                       /* Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor: state.pricingList[index].badge ? redColor : Colors.red,
                                                child: Center(
                                                  child: Icon(state.pricingList[index].badge ? Icons.check : Icons.close,color: Colors.white,size: 20,),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text("Special Membership Badge",style: TextStyle(color:state.pricingList[index].badge ? Colors.black54 : Colors.red,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor: state.pricingList[index].promotionDay > 0 ? redColor : Colors.red,
                                                child: Center(
                                                  child: Icon(state.pricingList[index].promotionDay > 0 ? Icons.check : Icons.close,color: Colors.white,size: 20,),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text("${state.pricingList[index].promotionDay} Business Directory",style: TextStyle(color: state.pricingList[index].promotionDay > 0 ? Colors.black54 : Colors.red,fontSize: 14,fontWeight: FontWeight.w400),),
                                            ],
                                          ),
                                        ),*/
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                          child: SizedBox(
                                            height: 48,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                                                elevation: 10,
                                                foregroundColor: Colors.black87,
                                                shadowColor: Colors.grey.withOpacity(0.2),
                                              ),
                                              onPressed: () async {
                                                Navigator.pushNamed(context, RouteNames.planDetailsScreen,arguments: state.pricingList[index]);
                                              },
                                              child: const Text("Get Now"),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  );
                                })
                              ]
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...List.generate(3, (index) {
                                  return Container(
                                    height: index == _currentIndex ? 12 : 8,
                                    width: index == _currentIndex ? 12 : 8,
                                    margin: const EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                        color: index == _currentIndex ? Colors.white : Colors.black54,
                                        shape: BoxShape.circle
                                    ),
                                  );
                                })
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          }
        ),
      ),
    );
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }


}
