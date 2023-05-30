import 'dart:convert';

import 'package:equatable/equatable.dart';

class PricingModel extends Equatable{
  const PricingModel({
    required this.id,
    required this.title,
    required this.price,
    required this.status,
    required this.orderId,
    required this.promotionDay,
  });

  final int id;
  final String title;
  final String price;
  final String status;
  final String orderId;
  final String promotionDay;

  PricingModel copyWith({
    int? id,
    String? title,
    String? price,
    String? status,
    String? orderId,
    String? promotionDay,
  }) =>
      PricingModel(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        status: status ?? this.status,
        orderId: orderId ?? this.orderId,
        promotionDay: promotionDay ?? this.promotionDay,
      );

  factory PricingModel.fromJson(String str) => PricingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PricingModel.fromMap(Map<String, dynamic> json) => PricingModel(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    price: json["price"] is int ? json["price"].toString() : json["price"]?? '',
    status: json["status"] is int ? json["status"].toString() : json["status"]?? '',
    orderId: json["order_id"] is int ? json["order_id"].toString() : json["order_id"] ?? '',
    promotionDay: json["promotion_day"] is int ? json["promotion_day"].toString() : json["promotion_day"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "label": title,
    "title": price,
    "status": status,
    "order_id": orderId,
    "promotion_day": promotionDay,
  };

  @override
  String toString() {
    return 'PricingModel(id: $id, title: $title, price: $price, status: $status, orderId: $orderId, promotionDay: $promotionDay)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      price,
      status,
      orderId,
      promotionDay,
    ];
  }
}