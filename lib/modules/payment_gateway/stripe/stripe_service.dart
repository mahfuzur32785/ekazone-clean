import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';
import 'package:ekayzone/modules/payment_gateway/controllers/stripe/stripe_cubit.dart';
import 'package:ekayzone/modules/home/model/pricing_model.dart';
import 'package:ekayzone/utils/extensions.dart';

import '../../../utils/k_strings.dart';

class StripeService {
  Map<String , dynamic>? paymentIntent;
  PricingModel? pricingModel;
  Future<void> makePayment(BuildContext context,int price,String currency,final Map<String,dynamic> response, PricingModel pricingModel) async {
    this.pricingModel = pricingModel;
    Stripe.publishableKey = response["stripe"]["stripe_key"];
    Stripe.merchantIdentifier = 'any string works';
    await Stripe.instance.applySettings();
    try {
      paymentIntent = await createPaymentIntent('$price', currency,response["stripe"]["stripe_secret"]);
      "xxxxxxxxxxxxxxxxxxxxxxxxxx ${paymentIntent.toString()} xxxxxxxxxxxxxxxxxxxxxxxxxx".log();
      //Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan')).then((value){
      });


      ///now finally display payment sheeet
      displayPaymentSheet(context);
    } catch (e, s) {
      if (kDebugMode) {
        print('exception:$e$s');
      }
    }
  }

  displayPaymentSheet(BuildContext context) async {
    print("ffffffffffffffffffffffffffffffffff");
    try {
      var result = await Stripe.instance.presentPaymentSheet(
      ).then((value) async {
        
        await Stripe.instance.retrievePaymentIntent(paymentIntent!['client_secret']).then((value) async {
          "bbbbbbbbbbbbbbbbbb${value.toString()} bbbbbbbbbbbb".log();
          PaymentIntent paymentIntent = value;
          if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
            final stripeBloc = context.read<StripeCubit>();
            Map<String, String> data = {
              "plan_id": "${pricingModel?.id}",
              "status": 'success',
              "order": paymentIntent.id,
              "payment_provider": 'Stripe'
            };
            await stripeBloc.callStripe(data);
            print(data.toString());
          }
          this.paymentIntent = null;
        });
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

      }).onError((error, stackTrace){
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  Client client = Client();
  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency,var stripeKey) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await client.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $stripeKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      "Payment Intent Body->>> ${response.body.toString()}".log();
      response.body.toString().log;
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100 ;
    return calculatedAmount.toString();
  }
}