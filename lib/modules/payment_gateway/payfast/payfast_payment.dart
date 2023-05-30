import 'dart:convert';

import 'package:ekayzone/modules/ad_details/model/ad_details_model.dart';
import 'package:ekayzone/modules/authentication/controllers/login/login_bloc.dart';
import 'package:ekayzone/modules/payment_gateway/controllers/payfast/payfast_cubit.dart';
import 'package:ekayzone/modules/payment_gateway/controllers/paypal/paypal_cubit.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PayfastPaymentArguments {
  final AdDetails adDetails;
  final int id;
  final String title;
  final String price;

  PayfastPaymentArguments(this.adDetails, this.id, this.title, this.price);
}

class PayfastPayment extends StatefulWidget {
  final AdDetails adDetails;
  final int id;
  final String title;
  final String price;
  const PayfastPayment(
      {Key? key,
      required this.adDetails,
      required this.id,
      required this.title,
      required this.price})
      : super(key: key);

  @override
  State<PayfastPayment> createState() => _PayfastPaymentState();
}

class _PayfastPaymentState extends State<PayfastPayment> {
  LoginBloc? _loginBloc;
  PaypalCubit? paypalCubit;
  WebViewController? _controller;

  // var htmlWidget;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    paypalCubit = context.read<PaypalCubit>();

    context.read<PayfastCubit>().createPayfastPayment(getOrderParams(), _loginBloc?.userInfo?.accessToken);

    // makePayment();

    // print('id${widget.adId}');
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

  Future<void> makePayment(url) async {
    // String url = 'https://sandbox.payfast.co.za/eng/process';
    // String merchantId = '10029332';
    // String merchantKey = 'okxj1y6dkitnk';
    // String amount = '100.00';
    // String itemName = 'Test Payment';
    //
    // Map<String, String> headers = {
    //   'Content-Type': 'application/x-www-form-urlencoded',
    //   'Accept': 'application/json',
    // };
    //
    // Map<String, String> body = {
    //   'merchant_id':merchantId,
    //   'merchant_key': merchantKey,
    //   'amount': amount,
    //   'item_name': itemName,
    // };

    http.Response response = await http.get(Uri.parse(url));

    print("notification ${response.body}");

    // htmlWidget = response.body;

    // if (response.statusCode == 200) {
    //   print("s");
    //   // Payment was created successfully
    //   print(response.body);
    // } else {
    //   // Payment creation failed
    //   print("f ${response.statusCode}");
    //   throw Exception('Failed to create payment');
    // }
  }

  Map<String, dynamic> getOrderParams() {
    return {
      'merchant_key': 'okxj1y6dkitnk',
      'merchant_id': '10029332',
      'amount': '${widget.price}',
      'item_name': '${widget.adDetails.title}',
      'return_url': 'https://www.ekayzone.com/payfast/success/payment',
      'cancel_url': 'https://www.ekayzone.com/payfast/payment/cancle',
      'notify_url': 'https://www.ekayzone.com/notify',
    };
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payfast Payment"),
        backgroundColor: redColor,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_outlined),
          onTap: () => Navigator.pop(context),
        ),
      ),
      // body: Html(data: htmlWidget),
      body: BlocBuilder<PayfastCubit, PayfastState>(
        builder: (context, state) {
          if (state is PayfastStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PayfastStateError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is PayfastStateLoaded) {
            var htmlResult = state.message;
            return WebView(
              initialUrl: 'https://sandbox.payfast.co.za/eng/process',
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                _loadHtmlFromAssets(htmlResult);
              },
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: _onUrlChange,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  _loadHtmlFromAssets(htmlResult) async {
    // String fileText = await rootBundle.loadString(htmlResult);
    _controller?.loadUrl(Uri.dataFromString(
        htmlResult,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }

  _onUrlChange(String url) async {
    print('Page finished loading: $url');
    if (mounted) {

        if (url.contains("https://www.ekayzone.com/payfast/success/payment")) {
          print('After success');
          // makePayment('https://www.example.com/notify');
          Map<String, String> data = {
            "transaction_id": '1234',
            "payment_provider": 'Payfast',
            "promotion_id": "${widget.id}",
            "status": 'paid',
            "ad_id": "${widget.adDetails.id}",
          };
          await paypalCubit?.paymentConfirmation(data, context).then((value) {
            print("11111111111111111111111111111111 Payment Success 1111111111111111111111111111111");
            Navigator.pop(context);
          });

        } else if (url.contains("https://www.ekayzone.com/payfast/payment/cancle")) {
          print('After Cancel');
          Navigator.pop(context);
          // Navigator.pushNamed(context, "/onCancel");
        }
        else if (url.contains("https://www.ekayzone.com/notify")) {
          print('After Notify');
          // Navigator.pop(context);
        }

    }
  }
}
