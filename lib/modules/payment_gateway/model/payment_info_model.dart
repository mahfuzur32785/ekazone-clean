import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentInfoModel extends Equatable{
  const PaymentInfoModel({
    required this.id,
    required this.label,
    required this.price,
    required this.adLimit,
    required this.featuredLimit,
    required this.badge,
    required this.recommended,
  });

  final int id;
  final String label;
  final int price;
  final int adLimit;
  final int featuredLimit;
  final bool badge;
  final int recommended;

  PaymentInfoModel copyWith({
    int? id,
    String? label,
    int? price,
    int? adLimit,
    int? featuredLimit,
    bool? badge,
    int? recommended,
  }) =>
      PaymentInfoModel(
        id: id ?? this.id,
        label: label ?? this.label,
        price: price ?? this.price,
        adLimit: adLimit ?? this.adLimit,
        featuredLimit: featuredLimit ?? this.featuredLimit,
        badge: badge ?? this.badge,
        recommended: recommended ?? this.recommended,
      );

  factory PaymentInfoModel.fromJson(String str) => PaymentInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentInfoModel.fromMap(Map<String, dynamic> json) => PaymentInfoModel(
    id: json["id"] ?? 0,
    label: json["label"] ?? '',
    price: json["price"] ?? 0,
    adLimit: json["ad_limit"] ?? 0,
    featuredLimit: json["featured_limit"] ?? 0,
    badge: json["badge"] ?? false,
    recommended: json["recommended"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "label": label,
    "price": price,
    "ad_limit": adLimit,
    "featured_limit": featuredLimit,
    "badge": badge,
    "recommended": recommended,
  };

  @override
  String toString() {
    return 'PaymentInfoModel(id: $id, label: $label, price: $price, ad_limit: $adLimit, featured_limit: $featuredLimit, badge: $badge, recommended: $recommended)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      label,
      price,
      adLimit,
      featuredLimit,
      badge,
      recommended,
    ];
  }
}