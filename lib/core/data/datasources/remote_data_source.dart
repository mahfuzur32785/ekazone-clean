import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ekayzone/modules/ad_details/model/ad_details_model.dart';
import 'package:ekayzone/modules/home/model/country_model.dart';
import 'package:flutter/foundation.dart';
import 'package:ekayzone/modules/home/model/category_model.dart' as CategoroyModel;
import 'package:http/http.dart' as http;
import 'package:ekayzone/modules/ad_details/model/details_response_model.dart';
import 'package:ekayzone/modules/ads/model/customer_adlist_response_model.dart';
import 'package:ekayzone/modules/chat/model/chat_model.dart';
import 'package:ekayzone/modules/dashboard/model/overview_model.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/modules/my_plans/model/plans_billing_model.dart';
import 'package:ekayzone/modules/post_ad/controller/postad_bloc.dart';
import 'package:ekayzone/modules/price_planing/model/payment_gateways_response_model.dart';
import 'package:ekayzone/modules/home/model/pricing_model.dart';
import 'package:ekayzone/modules/profile/model/public_profile_model.dart';
import 'package:ekayzone/modules/seller/model/seller_response_model.dart';
import 'package:ekayzone/modules/setting/model/setting_model.dart';
import 'package:ekayzone/modules/setting/model/user_with_country_response.dart';
import 'package:ekayzone/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/ads/model/adlist_response_model.dart';
import '../../../modules/ads/new_ad_edit/controller/new_ad_edit_bloc.dart';
import '../../../modules/authentication/models/set_password_model.dart';
import '../../../modules/authentication/models/user_login_response_model.dart';
import '../../../modules/chat/model/message_model.dart';
import '../../../modules/home/model/home_model.dart';
import '../../../modules/new_post_ad/controller/new_posted_bloc.dart';
import '../../../modules/profile/controller/change_password/change_password_cubit.dart';
import '../../../utils/k_strings.dart';
import '../../error/exception.dart';
import '../../remote_urls.dart';

abstract class RemoteDataSource {
  Future<UserLoginResponseModel> signIn(Map<String, dynamic> body);
  Future<UserWithCountryResponse> userProfile(String token);
  Future<PublicProfileModel> publicProfile(String username, String sortBy, String token);
  Future<DOverViewModel> dashboardOverview(String token);
  // Future<String> passwordChange(
  //     ChangePasswordStateModel changePassData, String token);
  // Future<String> profileUpdate(ProfileEditStateModel user, String token);

  Future<HomeModel> getHomeData(countryCode, token);
  Future<DetailsResponseModel> getAdDetails(String slug,String token, String countryCode);
  Future<String> postReport(Map<String, dynamic> body,String token);
  Future<AdListResponseModel> searchAds(Uri uri);
  Future<CustomerAdListResponseModel> customerAds(Uri uri,String token);
  Future<String> deleteMyAd(int id,String token);
  Future<SellerResponseModel> sellers(Uri uri);
  Future<String> postSellerReview(Map<String, dynamic> body,String seller,String token);

  Future<String> postAdSubmit(PostAdModalState state,String token);

  Future<AdDetails> newPostAdSubmit(NewPostAdModalState state,String token);
  Future<String> newAdEditSubmit(NewEditAdModalState state,String token,String id);

  Future<List<PlansBillingModel>> getMyPlanBillingList(String token);
  Future<PaymentGatewaysResponseModel> paymentGateways(String token);

  Future<String> sendForgotPassCode(Map<String, dynamic> body);
  Future<String> setPassword(Map<String, dynamic> body);
  Future<SettingModel> websiteSetup();
  Future<List<TopCountry>> getCountry();
  Future<String> userRegister(Map<String, dynamic> userInfo);
  Future<UserLoginResponseModel> socialLogin(Map<String, dynamic> userInfo);

  Future<ChatModel> getChatUsers(String token,{String user = ''});
  Future<List<MessageModel>> postSendMessage(String token,String body,String user);

  Future<List<AdModel>> wishList(String token);
  Future<List<AdModel>> compareList(List<dynamic> adsId);

  Future<String> addWishList(int id, String token);
  Future<String> passwordChange(ChangePasswordStateModel changePassData, String token);
  Future<Map<String, dynamic>> editProfile( Map<String,String> body, String token);
  Future<String> changePassword( Map<String,String> body, String token);
  Future<String> deleteAccount(String data, String token, String text);

  Future<String> stripePay(String token, Map<String, String> body);
  Future<String> paymentConfirmation(String token, Map<String, String> body);

  Future<dynamic> createPayfastPayment(Map<String, dynamic> body, String token);

}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;
  final _className = 'RemoteDataSourceImpl';

  RemoteDataSourceImpl({required this.client});

  Future<dynamic> callClientWithCatchException(
      CallClientMethod callClientMethod) async {
    try {
      final response = await callClientMethod();
      // log(response.statusCode.toString(), name: _className);
      // log(response.body, name: _className);
      if (kDebugMode) {
        print("status code : ${response.statusCode}");
        print(response.body);
      }
      return _responseParser(response);
    } on SocketException {
      log('SocketException', name: _className);
      // var text = '';
      // var connectivityResult = await (Connectivity().checkConnectivity());
      // print(connectivityResult.name);
      // if (connectivityResult == ConnectivityResult.none) {
      //   text = 'Internet Connection';
      // }  else if (connectivityResult == ConnectivityResult.mobile) {
      //   text = 'Mobile Data Connection';
      // } else if (connectivityResult == ConnectivityResult.wifi) {
      //   text = 'Wifi Connection';
      // }
      throw const NetworkException('Please check your \nInternet Connection', 10061);
    } on FormatException {
      log('FormatException', name: _className);
      throw const DataFormatException('Data format exception', 422);
    } on http.ClientException {
      ///503 Service Unavailable
      log('http ClientException', name: _className);
      throw const NetworkException('Service unavailable', 503);
    } on TimeoutException {
      log('TimeoutException', name: _className);
      throw const NetworkException('Request timeout', 408);
    }
  }

  @override
  Future<HomeModel> getHomeData(countryCode, token) async {
    final uri = Uri.parse(RemoteUrls.homeUrl(countryCode));

    print('Home Api $uri');

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    return HomeModel.fromMap(responseJsonBody["data"]);
  }

  @override
  Future<String> postAdSubmit(PostAdModalState state,String token) async {
    final headers = {'Accept': 'application/json','Content-Type': 'application/json','Authorization': 'Bearer $token'};
    // final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postAdCreate);
    Map<String, String> stringQueryParameters =
    state.toMap().map((key, value) => MapEntry(key, value!.toString()));

    var request = jsonEncode(stringQueryParameters);
    if (kDebugMode) {
      print(request);
    }

    final clientMethod = client.post(uri, headers: headers, body: request,);
    //.................
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      // final errorMsg = parsingDoseNotExist(responseJsonBody);
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }


  @override
  Future<AdDetails> newPostAdSubmit(NewPostAdModalState state,String token) async {
    final headers = {'Accept': 'application/json','Content-Type': 'application/json','Authorization': 'Bearer $token'};
    // final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postAdCreate);

    Map<String, String> stringQueryParameters =
    state.toMap().map((key, value) => MapEntry(key, value!.toString()));

    var request = jsonEncode(stringQueryParameters);
    if (kDebugMode) {
      print(request);
    }

    final clientMethod = client.post(uri, headers: headers, body: request,);
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      return AdDetails.fromMap(responseJsonBody["data"]);
    }
  }


  @override
  Future<String> newAdEditSubmit(NewEditAdModalState state,String token,String id) async {
    final headers = {'Accept': 'application/json','Content-Type': 'application/json','Authorization': 'Bearer $token'};
    // final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.adUpdate(id));

    Map<String, String> stringQueryParameters =
    state.toMap().map((key, value) => MapEntry(key, value!.toString()));

    var request = jsonEncode(stringQueryParameters);
    if (kDebugMode) {
      // print(request);
      request.log();
    }

    final clientMethod = client.post(uri, headers: headers, body: request);
    //.................
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      // final errorMsg = parsingDoseNotExist(responseJsonBody);
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<List<PlansBillingModel>> getMyPlanBillingList(String token) async {
    final uri = Uri.parse(RemoteUrls.myPlanBilling);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'}
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } {
      return List.from(responseJsonBody["data"]["data"]).map((e) => PlansBillingModel.fromMap(e)).toList();
    }
  }

  @override
  Future<PaymentGatewaysResponseModel> paymentGateways(String token) async {
    final uri = Uri.parse(RemoteUrls.paymentGateways);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'}
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } {
      return PaymentGatewaysResponseModel.fromMap(responseJsonBody);
    }
  }

  @override
  Future<DetailsResponseModel> getAdDetails(String slug,String token, String countryCode) async {
    final uri = Uri.parse(RemoteUrls.productDetail(slug, countryCode));

    print("Details url: $uri");

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    return DetailsResponseModel.fromMap(responseJsonBody["data"]);
  }

  @override
  Future<String> postReport(Map<String, dynamic> body,String token) async {
    final uri = Uri.parse(RemoteUrls.postReport);

    print("Ad Report Url $uri");

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json','Authorization': 'Bearer $token'},
      body: body,
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['data'].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody['message'];
    }

  }


  @override
  Future<AdListResponseModel> searchAds(Uri uri) async {
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    return AdListResponseModel.fromMap(responseJsonBody["data"]);
  }

  @override
  Future<CustomerAdListResponseModel> customerAds(Uri uri,String token) async {
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    return CustomerAdListResponseModel.fromMap(responseJsonBody["data"]);
  }

  @override
  Future<String> deleteMyAd(int id,String token) async {
    final uri = Uri.parse(RemoteUrls.deleteMyAd(id));
    final clientMethod = client.delete(
      uri,
      // body: {'id': '$id'},
      headers: {'Accept': 'application/json','Authorization': 'Bearer $token'},
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<SellerResponseModel> sellers(Uri uri) async {
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw DataNotFoundException(errorMsg);
    } {
      return SellerResponseModel.fromMap(responseJsonBody["data"]);
    }

  }

  @override
  Future<String> postSellerReview(Map body,String seller,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postSellerReview(seller));

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<UserLoginResponseModel> signIn(Map body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogin);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } {
      return UserLoginResponseModel.fromMap(responseJsonBody["data"]);
    }
  }

  @override
  Future<UserWithCountryResponse> userProfile(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.userProfile);

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    return UserWithCountryResponse.fromMap(responseJsonBody);
  }

  @override
  Future<PublicProfileModel> publicProfile(String username, String sortBy,  String token) async {
    final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.publicProfile(username, sortBy));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } {
      return PublicProfileModel.fromMap(responseJsonBody["data"]);
    }
  }

  @override
  Future<DOverViewModel> dashboardOverview(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.dashboardOverview);

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } {
      return DOverViewModel.fromMap(responseJsonBody["data"]);
    }
  }

  @override
  Future<String> userRegister(Map<String, dynamic> userInfo) async {
    final uri = Uri.parse(RemoteUrls.userRegister);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: userInfo,
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['data'].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody['message'];
    }
  }

  @override
  Future<UserLoginResponseModel> socialLogin(Map<String, dynamic> userInfo) async {
    final uri = Uri.parse(RemoteUrls.socialLogin);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: userInfo,
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['data'].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return UserLoginResponseModel.fromMap(responseJsonBody["data"]);
    }
  }

  @override
  Future<String> sendForgotPassCode(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.sendForgetPassword);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: body,
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> setPassword(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.storeResetPassword);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: body,
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  ///.............. App Settings Related Methods ...............
  @override
  Future<SettingModel> websiteSetup() async {
    // final uri = Uri.parse(RemoteUrls.websiteSetup);
    final uri = Uri.parse(RemoteUrls.websiteSetup);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    print(responseJsonBody['data']);

    return SettingModel.fromMap(responseJsonBody['data']);
  }

  @override
  Future<List<TopCountry>> getCountry() async {
    // final uri = Uri.parse(RemoteUrls.websiteSetup);
    final uri = Uri.parse(RemoteUrls.getCountry);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    print(responseJsonBody['data']);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['message'].toString();
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return List<dynamic>.from(responseJsonBody["data"]).map((e) => TopCountry.fromMap(e)).toList();
    }
  }


  @override
  Future<ChatModel> getChatUsers(String token,{String user = ''}) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getChatUsers(user));
    if (kDebugMode) {
      print(uri);
    }

    final clientMethod = client.get(
      uri,
      headers: headers,
    );

    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['message'].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return ChatModel.fromMap(responseJsonBody['data']);
    }
  }

  @override
  Future<List<MessageModel>> postSendMessage(String token,String body,String user) async {
    final uri = Uri.parse(RemoteUrls.getChatUsers(user));

    final clientMethod = client.post(
      uri,
      body: {"body": body},
      headers: {'Accept': 'application/json','Authorization': 'Bearer $token'},
    );

    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['message'].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return List<dynamic>.from(responseJsonBody["data"]["messages"]).map((e) => MessageModel.fromMap(e)).toList();
    }
  }


  @override
  Future<List<AdModel>> wishList(String token) async {
    final uri = Uri.parse(RemoteUrls.wishList);

    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['message'].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      final wishlist = responseJsonBody['data'] as List?;

      if (wishlist == null) {
        return [];
      } else {
        return wishlist.map((e) {
          final mapData = e['ad'] as Map<String, dynamic>;
          return AdModel.fromMap(mapData);
        }).toList();
      }
    }

  }


  @override
  Future<List<AdModel>> compareList(List<dynamic> adsId) async {
    final uri = Uri.parse(RemoteUrls.compareList);
    print("Compare List url is $uri");

    print("Body data is: ${adsId} and type ${adsId.runtimeType}");

    var data = jsonEncode({
      "compare_id": adsId
    });

    print("Body data is: ${data}");

    final headers = {'Accept': 'application/json','Content-Type': 'application/json'};
    final clientMethod = client.post(uri, headers: headers, body: data);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['message'].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["data"] == null ? [] : List<dynamic>.from(responseJsonBody["data"]).map((e) => AdModel.fromMap(e)).toList();

      // final compareList = responseJsonBody['data'] as List?;
      //
      // if (compareList == null) {
      //   return [];
      // } else {
      //   return compareList.map((e) {
      //     final mapData = e as Map<String, dynamic>;
      //     return AdModel.fromMap(mapData);
      //   }).toList();
      // }
    }
  }

  @override
  Future<String> addWishList(int id, String token) async {
    final uri = Uri.parse(RemoteUrls.addWish(id));

    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final clientMethod = client.post(uri, headers: headers);
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> passwordChange(
      ChangePasswordStateModel changePassData,
      String token,
      ) async {
    final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token' };
    final uri = Uri.parse(RemoteUrls.passwordChange);

    final clientMethod =
    client.post(uri, headers: headers, body: changePassData.toMap());
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    // if (responseJsonBody["success"] == false) {
    //   final errorMsg = parsingDoseNotExist(responseJsonBody);
    //   throw UnauthorisedException(errorMsg, 401);
    // } {
    //   return responseJsonBody["message"];
    // }
    return responseJsonBody['notification'] as String;
  }


  @override
  Future<Map<String, dynamic>> editProfile(Map<String,String> body, String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.editProfile);

    final clientMethod = client.post(uri, headers: headers, body: body);

    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    // return responseJsonBody;
    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody;
    }
  }

  @override
  Future<String> changePassword(Map<String,String> body, String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.changePassword);

    final clientMethod = client.post(uri, headers: headers, body: body);

    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    // return responseJsonBody["message"];
    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<String> deleteAccount(String data, String token, String text) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.deleteAccount(text));

    print("url is $uri");

    final clientMethod = client.delete(uri, headers: headers);

    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    // return responseJsonBody["message"];
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['message'];
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<String> stripePay(String token, Map<String, String> body) async {
    final uri = Uri.parse(RemoteUrls.paymentConfirmation);
    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json','Authorization': 'Bearer $token'},
      body: body,
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'];
  }

  @override
  Future<String> paymentConfirmation(String token, Map<String, String> body) async {
    final uri = Uri.parse(RemoteUrls.paymentConfirmation);
    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json','Authorization': 'Bearer $token'},
      body: body,
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = parsingDoseNotExist(responseJsonBody);
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }
  @override
  Future<dynamic> createPayfastPayment(Map<String, dynamic> body, String token) async {

    var htmlWidget;

    print('Body data $body');
    // print('Token data $token');
    String url = 'https://sandbox.payfast.co.za/eng/process';

    Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      };

    http.Response response = await http.post(Uri.parse(url), headers: headers, body: body);

    print("response ${response.body}");

    return htmlWidget = response.body;

    // final uri = Uri.parse("https://sandbox.payfast.co.za/eng/process");
    // final clientMethod = client.post(
    //   uri,
    //   headers: {
    //     'Content-Type': 'application/x-www-form-urlencoded',
    //     'Accept': 'application/json',
    //     // 'Authorization': 'Bearer $token'
    //   },
    //   body: body,
    // );
    //
    // final responseJsonBody =
    // await callClientWithCatchException(() => clientMethod);

    // print("Response $responseJsonBody");
    // return responseJsonBody;

    // if (responseJsonBody["success"] == false) {
    //   final errorMsg = parsingDoseNotExist(responseJsonBody);
    //   throw UnauthorisedException(errorMsg, 401);
    // } {
    //   return responseJsonBody["message"];
    // }
  }


  dynamic _responseParser(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        // if (responseJson["status"] != null) {
        //   if (responseJson["status"] == 0) {
        //     if (kDebugMode) {
        //       print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
        //     }
        //     final errorMsg = parsingDoseNotExist(responseJson["message"]);
        //     throw ServerResponseException(errorMsg, 201);
        //   }
        // }
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(response.body);
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        throw const UnauthorisedException('Request not found', 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 408:

      ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:

      /// 415 Unsupported Media Type
        throw const DataFormatException('Data format exception');

      case 422:

      ///Unprocessable Entity
        final errorMsg = parsingError(response.body);
        throw InvalidInputException(errorMsg, 422);
      case 500:

      ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        throw FetchDataException(
            'Error occurred while communication with Server',
            response.statusCode);
    }
  }
  String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }

    return 'Unknown error';
  }
  String parsingDoseNotExist(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['notification'] != null) {
        return errorsMap['notification'];
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }
    return 'Credentials does not match';
  }
}