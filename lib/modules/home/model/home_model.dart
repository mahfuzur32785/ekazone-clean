import 'dart:convert';
import 'package:ekayzone/modules/home/model/pricing_model.dart';
import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/modules/home/model/category_model.dart';

import 'brand_model.dart';
import 'country_model.dart';
import 'model_model.dart';

class HomeModel extends Equatable {
  final List<Category> categories;
  // final List<BrandModel> brandList;
  final List<Model> serviceTypeList;
  final List<TopCountry> topCountries;
  final List<Model> designations;
  final List<AdModel> latestAds;
  final List<AdModel> regularAds;
  final List<AdModel> featuredAds;
  final List<PricingModel> plans;
  final String banner;
  const HomeModel({
    required this.categories,
    // required this.brandList,
    required this.serviceTypeList,
    required this.topCountries,
    required this.designations,
    required this.latestAds,
    required this.regularAds,
    required this.featuredAds,
    required this.plans,
    required this.banner,
  });

  HomeModel copyWith({
    List<Category>? categories,
    // List<BrandModel>? brandList,
    List<Model>? serviceTypeList,
    List<TopCountry>? topCountries,
    List<Model>? designations,
    List<AdModel>? latestAds,
    List<AdModel>? regularAds,
    List<AdModel>? featuredAds,
    List<PricingModel>? plans,
    String? banner,
  }) {
    return HomeModel(
      categories: categories ?? this.categories,
      // brandList: brandList ?? this.brandList,
      serviceTypeList: serviceTypeList ?? this.serviceTypeList,
      topCountries: topCountries ?? this.topCountries,
      designations: designations ?? this.designations,
      latestAds: latestAds ?? this.latestAds,
      regularAds: regularAds ?? this.regularAds,
      featuredAds: featuredAds ?? this.featuredAds,
      plans: plans ?? this.plans,
      banner: banner ?? this.banner,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'categories': categories.map((x) => x.toMap()).toList()
    });
    // result.addAll({'brands': brandList.map((x) => x.toMap()).toList()});
    result.addAll({'service_types': serviceTypeList.map((x) => x.toMap()).toList()});
    result.addAll(
        {'topCountry': topCountries.map((x) => x.toMap()).toList()});
    result.addAll(
        {'designations': designations.map((x) => x.toMap()).toList()});
    result.addAll({'latestAds': latestAds.map((x) => x.toMap()).toList()});
    result.addAll({'ads': regularAds.map((x) => x.toMap()).toList()});
    result.addAll({
      'featureAds': featuredAds.map((x) => x.toMap()).toList()
    });
    result.addAll({
      'plans': plans.map((x) => x.toMap()).toList()
    });
    result.addAll({'banner': banner});

    return result;
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      categories: map['categories'] != null
          ? List<Category>.from(map['categories']
              .map((x) => Category.fromMap(x)))
          : [],

      // brandList: map['brands'] == null || map['brands'] == ""
      //     ? []
      //     : List<BrandModel>.from(map['brands']
      //     .map((x) => BrandModel.fromMap(x))),
      serviceTypeList: map['service_types'] == null || map['service_types'] == ""
          ? []
          : List<Model>.from(map['service_types']
          .map((x) => Model.fromMap(x))),

      designations: map['designations'] == null || map['designations'] == ""
          ? []
          : List<Model>.from(map['designations']
          .map((x) => Model.fromMap(x))),

      topCountries: map['topCountry'] == null || map['topCountry'] == ""
          ? []
          : List<TopCountry>.from(map['topCountry']
          .map((x) => TopCountry.fromMap(x))),

      latestAds: map['latestAds'] != null
          ? List<AdModel>.from(
              map['latestAds'].map((x) => AdModel.fromMap(x)))
          : [],
      regularAds: map['ads'] != null
          ? List<AdModel>.from(
              map['ads'].map((x) => AdModel.fromMap(x)))
          : [],
      featuredAds: map['featureAds'] != null
          ? List<AdModel>.from(
              map['featureAds'].map((x) => AdModel.fromMap(x)))
          : [],
      plans: map['plans'] != null
          ? List<PricingModel>.from(
              map['plans'].map((x) => PricingModel.fromMap(x)))
          : [],
      banner: map["banner"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeModel(categories: $categories,/*brands: brandList,*/ service_types: $serviceTypeList, topCountry: $topCountries, designations: $designations, latestAds: $latestAds, ads: $regularAds, featureAds: $featuredAds, plans: $plans, banner: $banner)';
  }

  @override
  List<Object> get props {
    return [
      categories,
      // brandList,
      serviceTypeList,
      topCountries,
      designations,
      latestAds,
      regularAds,
      featuredAds,
      plans,
      banner,
    ];
  }
}