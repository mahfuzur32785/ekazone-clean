import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_auth/http_auth.dart';
import 'package:ekayzone/utils/extensions.dart';

import '../../../core/error/exception.dart';

class PaypalServices {

  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId = 'Aa8_7OJaxmCZQpkx3hbzdySDz7haM0Wu6c6MmzX5JQsaywY1i8HMJo2ddnr9-pEEoRP3qvjflrxOVoXL';
  String secret = 'ELMx8Z_ddA0Z597lD-dDPssM4VxBbnWvvoxb1mjuIiMCHLRSzbSN6owESivW4moqRPPYOTyl1J9QxSx0';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print("body $body");
        return body["access_token"];
      } else {
        throw const UnauthorisedException("Something went wrong!", 401);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    Client client = Client();
    try {
      var response = await client.post(Uri.parse("$domain/v1/payments/payment"),
          body: jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });

      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl, "accessToken": accessToken};
        }
        throw ServerResponseException(body["Service Not Available"]);
      } else {
        throw ServerResponseException(body["message"]);
      }
    } catch (e) {
      throw ServerResponseException(e.toString());
    }
  }

  // for executing the payment transaction
  Future<Map<String,dynamic>>? executePayment(url, payerId, accessToken) async {
    Client client = Client();
    try {
      var response = await client.post(Uri.parse(url),
          body: jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });

      final body = jsonDecode(response.body);
      body.toString().log();
      if (response.statusCode == 200) {
        return body;
      }
      throw const ServerResponseException("Something Went wrong!");
    } catch (e) {
      throw ServerResponseException(e.toString());
    }
  }
}