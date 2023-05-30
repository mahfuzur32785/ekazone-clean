import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';

import 'ad_details_model.dart';

class DetailsResponseModel extends Equatable {
  const DetailsResponseModel({
    required this.adDetails,
    required this.relatedAds,
  });

  final AdDetails adDetails;
  final List<AdModel> relatedAds;

  DetailsResponseModel copyWith({
    AdDetails? adDetails,
    List<AdModel>? relatedAds,
  }) =>
      DetailsResponseModel(
        adDetails: adDetails ?? this.adDetails,
        relatedAds: relatedAds ?? this.relatedAds,
      );

  factory DetailsResponseModel.fromJson(String str) => DetailsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailsResponseModel.fromMap(Map<String, dynamic> json) => DetailsResponseModel(
    adDetails: AdDetails.fromMap(json["ad_details"]),
    relatedAds: json["related_ads"] == null ? [] : List<AdModel>.from(json["related_ads"].map((x) => AdModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "ad_details": adDetails.toMap(),
    "related_ads": List<dynamic>.from(relatedAds.map((x) => x.toMap())),
  };

  @override
  String toString() {
    return 'DetailsResponseModel(ad_details: $adDetails, related_ads: $relatedAds)';
  }

  @override
  List<Object?> get props {
    return [
      adDetails,
      relatedAds,
    ];
  }
}