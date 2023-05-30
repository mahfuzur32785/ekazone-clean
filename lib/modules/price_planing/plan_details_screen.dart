import 'package:ekayzone/modules/payment_gateway/payfast/payfast_payment.dart';
import 'package:ekayzone/modules/payment_gateway/paypal/paypal_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/payment_gateway/controllers/stripe/stripe_cubit.dart';
import 'package:ekayzone/modules/payment_gateway/stripe/stripe_service.dart';
import 'package:ekayzone/modules/price_planing/component/payment_card_card.dart';
import 'package:currency_converter/Currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:ekayzone/utils/utils.dart';

import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../ad_details/model/ad_details_model.dart';
import 'controller/payment_gateways/pg_cubit.dart';

class PlanDetailsScreenArguments{
  final AdDetails adDetails;
  final int id;
  final String title;
  final String price;

  PlanDetailsScreenArguments(this.adDetails, this.id, this.title, this.price);
}

class PlanDetailsScreen extends StatefulWidget {
  const PlanDetailsScreen({Key? key, required this.adDetails, required this.promotionId, required this.title, required this.price})
      : super(key: key);
  final AdDetails adDetails;
  final int promotionId;
  final String title;
  final String price;

  // final PricingModel pricingModel;
  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  late StripeService stripeService;

  @override
  void initState() {
    // TODO: implement initState
    stripeService = StripeService();
    super.initState();
    Future.microtask(
        () => context.read<PaymentGatewayCubit>().getPaymentGateways());

    print("id is details page ${widget.adDetails.id}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StripeCubit, StripeState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is StripeLoading) {
          Utils.loadingDialog(context);
        }
        if (state is StripeError) {
          Utils.closeDialog(context);
        }
        if (state is StripeLoaded) {
          Utils.closeDialog(context);
          Utils.showSnackBar(context, "Payment Successfully");
          Future.delayed(const Duration(milliseconds: 1000)).then((value) => Navigator.pop(context));
          // showDialog(
          //     context: context,
          //     builder: (_) => AlertDialog(
          //           content: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Row(
          //                 children: const [
          //                   Icon(
          //                     Icons.check_circle,
          //                     color: Colors.green,
          //                   ),
          //                   Text("Payment Successfull"),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FE),
        appBar: AppBar(
          title: const Text("Promote Your Ads"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: iconThemeColor,
            ),
          ),
        ),
        body: BlocBuilder<PaymentGatewayCubit, PaymentGatewayState>(
            builder: (context, state) {
          if (state is PaymentGatewayStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PaymentGatewayStateError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is PaymentGatewayStateLoaded) {
            print("Payment methods ${state.gatewaysResponseModel.gateways.length}");
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                ///Payment Details
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),

                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(1, 1))
                            ]),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.grey.shade300,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(flex: 5,child: SizedBox(child: Text("Ad Title:",maxLines: 1,overflow: TextOverflow.ellipsis,))),
                                    Expanded(flex: 3,child: SizedBox(child: Text(widget.adDetails.title,maxLines: 1,overflow: TextOverflow.ellipsis,)))
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(flex: 5,child: SizedBox(child: Text("Category:",maxLines: 1,overflow: TextOverflow.ellipsis,))),
                                    Expanded(flex: 3,child: SizedBox(child: Text(widget.adDetails.category!.name,maxLines: 1,overflow: TextOverflow.ellipsis,)))
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                padding: const EdgeInsets.all(10),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(flex: 5,child: SizedBox(child: Text("Request for Payment:",maxLines: 1,overflow: TextOverflow.ellipsis,))),
                                    Expanded(flex: 3,child: SizedBox(child: Text("Ad Promotion",maxLines: 1,overflow: TextOverflow.ellipsis,)))
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(flex: 5,child: SizedBox(child: Text("Duration:",maxLines: 1,overflow: TextOverflow.ellipsis,))),
                                    Expanded(flex: 3,child: SizedBox(child: Text(widget.title,maxLines: 1,overflow: TextOverflow.ellipsis,)))
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    const Expanded(flex: 5,child: SizedBox(child: Text("Amount:",maxLines: 1,overflow: TextOverflow.ellipsis,))),
                                    Expanded(flex: 3,child: SizedBox(child: Text("\$${widget.price}.00",maxLines: 1,overflow: TextOverflow.ellipsis,)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      print("Payment methods ${state.gatewaysResponseModel.gateways.length}");
                      if (state.gatewaysResponseModel.gateways[index]
                          .contains("paypal")) {
                        return PaymentMethodCard(
                          title: 'Pay with Paypal',
                          icon: Kimages.paypalIconPng,
                          press: (){
                            Navigator.pushNamed(
                                context, RouteNames.paypalScreen, arguments: PaypalPaymentArguments(widget.adDetails.id, widget.promotionId, widget.title, widget.price)).then((value) => Navigator.pop(context));
                          },
                        );
                      }
                      else if (state.gatewaysResponseModel.gateways[index]
                          .contains("payfast")) {
                        return PaymentMethodCard(
                          title: 'Pay with PayFast',
                          icon: Kimages.payFastIcon,
                          press: () {
                            Navigator.pushNamed(
                                context, RouteNames.payfastScreen, arguments: PayfastPaymentArguments(widget.adDetails, widget.promotionId, widget.title, widget.price)).then((value) => Navigator.pop(context));
                          },
                          // press: () {
                          //   stripeService.makePayment(
                          //       context,
                          //       widget.pricingModel.price,
                          //       "USD",
                          //       state.gatewaysResponseModel.response,
                          //     widget.pricingModel
                          //   );
                          // },
                        );
                      }
                      return const SizedBox();
                    },
                      childCount: state.gatewaysResponseModel.gateways.length,
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
