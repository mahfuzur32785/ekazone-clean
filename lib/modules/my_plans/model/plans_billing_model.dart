import 'dart:convert';

import 'package:ekayzone/modules/authentication/models/user_prfile_model.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/modules/home/model/pricing_model.dart';

class PlansBillingModel {
  PlansBillingModel({
    required this.id,
    required this.orderId,
    required this.transactionId,
    required this.paymentProvider,
    required this.planType,
    required this.amount,
    required this.paymentStatus,
    required this.createdAt,
    required this.adTitle,
    required this.categoryName,
    this.customer,
    this.adModel,
    this.promotion,
  });

  final int id;
  final String transactionId;
  final String orderId;
  final String paymentProvider;
  final String planType;
  final String paymentStatus;
  final String amount;
  final String createdAt;
  final String adTitle;
  final String categoryName;
  final UserProfileModel? customer;
  final AdModel? adModel;
  final PricingModel? promotion;
  PlansBillingModel copyWith({
    int? id,
    String? transactionId,
    String? orderId,
    String? paymentProvider,
    String? planType,
    String? paymentStatus,
    String? amount,
    String? createdAt,
    String? adTitle,
    String? categoryName,
    UserProfileModel? customer,
    AdModel? adModel,
    PricingModel? promotion,
  }) =>
      PlansBillingModel(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        orderId: orderId ?? this.orderId,
        paymentProvider: paymentProvider ?? this.paymentProvider,
        planType: planType ?? this.planType,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        adTitle: adTitle ?? this.adTitle,
        categoryName: categoryName ?? this.categoryName,
        customer: customer ?? this.customer,
        adModel:  adModel ?? this.adModel,
        promotion:  promotion ?? this.promotion,
      );

  factory PlansBillingModel.fromJson(String str) => PlansBillingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlansBillingModel.fromMap(Map<String, dynamic> json) => PlansBillingModel(
    id: json["id"],
    transactionId: json["transaction_id"] ?? '',
    orderId: json["order_id"] ?? '',
    paymentProvider: json["payment_provider"] ?? '',
    planType: json["plan_type"] ?? '',
    paymentStatus: json["payment_status"] ?? '',
    amount: json["amount"] ?? '',
    createdAt: json["created_at"] ?? '',
    adTitle: json["ad_title"] ?? '',
    categoryName: json["category_name"] ?? '',
    customer: json["customer"] == null ? null : UserProfileModel.fromMap(json["customer"]),
    adModel: json["belongs_to_ad"] == null ? null : AdModel.fromMap(json["belongs_to_ad"]),
    promotion: json["promotion"] == null ? null : PricingModel.fromMap(json["promotion"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "transaction_id": transactionId,
    "order_id": orderId,
    "payment_provider": paymentProvider,
    "plan_type": planType,
    "payment_status": paymentStatus,
    "amount": amount,
    "created_at": createdAt,
    "ad_title": adTitle,
    "category_name": categoryName,
    "customer": customer?.toMap(),
    "belongs_to_ad": adModel?.toMap(),
    "promotion": adModel?.toMap(),
  };
}