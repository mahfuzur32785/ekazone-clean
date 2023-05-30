import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/payment_gateway/controllers/paypal/paypal_cubit.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'paypal_service.dart';

class PaypalPaymentArguments{
  final int adId;
  final int id;
  final String title;
  final String price;

  PaypalPaymentArguments(this.adId, this.id, this.title, this.price);
}

class PaypalPayment extends StatefulWidget {
  final int adId;
  final int id;
  final String title;
  final String price;
  const PaypalPayment({super.key, required this.adId, required this.id, required this.title, required this.price});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic,dynamic> defaultCurrency = {"symbol": "USD", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL= 'cancel.example.com';

  LoginBloc? _loginBloc;


  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    Future.microtask(() => context.read<PaypalCubit>().createPaypalPayment(getOrderParams()));

    print('id${widget.adId}');
    // Future.delayed(Duration.zero, () async {
    //   try {
    //     accessToken = (await services.getAccessToken());
    //
    //     final transactions = getOrderParams();
    //     final res =
    //     await services.createPaypalPayment(transactions, accessToken);
    //     if (res != null) {
    //       setState(() {
    //         checkoutUrl = res["approvalUrl"]!;
    //         executeUrl = res["executeUrl"]!;
    //       });
    //     }
    //   } catch (e) {
    //     if (kDebugMode) {
    //       print('exception: $e');
    //     }
    //     Utils.showSnackBarWithAction(context, e.toString(), () { ScaffoldMessenger.of(context).hideCurrentSnackBar();});
    //   }
    // });
  }

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": "Promotional",
        "quantity": 1,
        "price": "${widget.price}",
        "currency": defaultCurrency["currency"]
      }
    ];


    // checkout invoice details
    String totalAmount = "${widget.price}";
    String subTotalAmount = "${widget.price}";
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = '${_loginBloc?.userInfo?.user.name}';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": "USD",
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
          },
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    final paypalBloc = context.read<PaypalCubit>();
    return BlocListener<PaypalCubit,PaypalState>(
      listenWhen: ((previous, current) => previous != current),
      listener: ((context, state) {
        if (state is PaypalStatePaymentSuccessLoaded) {
          Utils.showSnackBar(context,'Payment Successful');
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Paypal Payment"),
          backgroundColor: redColor,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_outlined),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<PaypalCubit,PaypalState>(
            builder: (context,state) {
              if (state is PaypalStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PaypalStateError) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is PaypalStateLoaded) {
                return WebView(
                  initialUrl: state.checkoutUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.contains(returnURL)) {
                      print("/////////////////$request ////////////////////////");
                      final uri = Uri.parse(request.url);
                      final payerID = uri.queryParameters['PayerID'];
                      if (payerID != null) {
                        services.executePayment(state.executeUrl, payerID, state.accessToken)?.then((body) async {
                          if (body["id"] != null) {
                            print("Transaction id${body["id"]}");

                            Map<String, String> data = {
                              "transaction_id": '${body["id"]}',
                              "payment_provider": 'Paypal',
                              "promotion_id": "${widget.id}",
                              "status": 'paid',
                              "ad_id": "${widget.adId}",
                            };
                            await paypalBloc.paymentConfirmation(data, context).then((value) {
                              print("11111111111111111111111111111111 Payment Success 1111111111111111111111111111111");
                            });
                          } else {
                            Navigator.of(context).pop();
                          }
                        });
                      } else {
                        Navigator.of(context).pop();
                      }
                    }
                    if (request.url.contains(cancelURL)) {
                      print("/////////////////$request ////////////////////////");
                      Navigator.of(context).pop();
                    }
                    return NavigationDecision.navigate;
                  },
                );
              }
            return const SizedBox();
          }
        ),
      ),
    );

    // else {
    //   return Scaffold(
    //     key: _scaffoldKey,
    //     appBar: AppBar(
    //       leading: IconButton(
    //           icon: const Icon(Icons.arrow_back),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           }),
    //       backgroundColor: Colors.black12,
    //       elevation: 0.0,
    //     ),
    //     body: const Center(child: CircularProgressIndicator()),
    //   );
    // }
  }
}