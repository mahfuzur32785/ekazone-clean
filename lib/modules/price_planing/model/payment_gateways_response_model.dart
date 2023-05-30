import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentGatewaysResponseModel extends Equatable{
  const PaymentGatewaysResponseModel({
    required this.gateways,
    required this.response,
  });

  final List<String> gateways;
  final Map<String,dynamic> response;

  PaymentGatewaysResponseModel copyWith({
    List<String>? gateways,
    Map<String,dynamic>? response,
  }) =>
      PaymentGatewaysResponseModel(
        gateways: gateways ?? this.gateways,
        response: response ?? this.response,
      );

  factory PaymentGatewaysResponseModel.fromJson(String str) => PaymentGatewaysResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentGatewaysResponseModel.fromMap(Map<String, dynamic> json) => PaymentGatewaysResponseModel(
    gateways: json['data'] != null
        ? getPaymentMethods(json)
        : [],
    response: json["data"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "gateways": gateways,
    "data": response,
  };

  @override
  String toString() {
    return 'PaymentGatewaysResponseModel(gateways: $gateways, data: $response)';
  }

  @override
  List<Object?> get props {
    return [
      gateways,
      response,
    ];
  }
}

List<String> getPaymentMethods(Map<String, dynamic> map){
  List<String> payments = [];
  for(final key in map['data']?.keys){
    if (map['data'][key]['active'] == true) {
      payments.add(key);
    }
  }
  return payments;
}