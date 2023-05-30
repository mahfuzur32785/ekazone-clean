import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/authentication/models/user_prfile_model.dart';

import 'category_model.dart';

class AdModel extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String thumbnail;
  final String price;
  final int userId;
  final String featured;
  final bool is_wishlist;
  final String region;
  final String country;
  final String city;
  final String address;
  final String status;
  final String totalViews;
  final String createdAt;
  Category? category;
  Brand? subcategory;
  Brand? brand;
  final String imageUrl;
  UserProfileModel? customer;
  final List<AdFeature> adFeatures;
  final List<Gallery> galleries;

  AdModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.thumbnail,
    required this.price,
    required this.userId,
    required this.featured,

    required this.is_wishlist,
    required this.region,
    required this.country,
    required this.city,
    required this.address,
    required this.status,
    required this.totalViews,
    required this.createdAt,
    this.category,
    this.subcategory,
    this.brand,
    required this.imageUrl,
    this.customer,
    required this.adFeatures,
    required this.galleries,
  });

  AdModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? thumbnail,
    String? price,
    int? userId,
    String? featured,

    bool? is_wishlist,
    String? region,
    String? country,
    String? city,
    String? address,
    String? status,
    String? totalViews,
    String? createdAt,
    Category? category,
    Brand? subcategory,
    Brand? brand,
    String? imageUrl,
    UserProfileModel? customer,
    List<AdFeature>? adFeatures,
    List<Gallery>? galleries,
  }) =>
      AdModel(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        thumbnail: thumbnail ?? this.thumbnail,
        price: price ?? this.price,
        userId: userId ?? this.userId,
        featured: featured ?? this.featured,

        is_wishlist: is_wishlist ?? this.is_wishlist,
        region: region ?? this.region,
        country: country ?? this.country,
        city: city ?? this.city,
        address: address ?? this.address,
        status: status ?? this.status,
        totalViews: totalViews ?? this.totalViews,
        createdAt: createdAt ?? this.createdAt,
        category: category ?? this.category,
        subcategory: subcategory ?? this.subcategory,
        brand: brand ?? this.brand,
        imageUrl: imageUrl ?? this.imageUrl,
        customer: customer ?? this.customer,
        adFeatures: adFeatures ?? this.adFeatures,
        galleries: galleries ?? this.galleries,
      );

  factory AdModel.fromJson(String str) => AdModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdModel.fromMap(Map<String, dynamic> json) => AdModel(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    slug: json["slug"] ?? '',
    thumbnail: json["thumbnail"] ?? '',
    price: json["price"] is int ? json["price"].toString() : json["price"] ?? '',
    userId: json["user_id"] is String ? int.parse(json["user_id"]) : json["user_id"] ?? 0,
    featured: json["featured"] is int ? json["featured"].toString() : json["featured"] ?? '',
    is_wishlist: json["wishlisted"] ?? false,
    region: json["region"] ?? '',
    country: json["country"] ?? '',
    city: json["city"] ?? '',
    address: json["address"] ?? '',
    status: json["status"] ?? '',
    totalViews: json["total_views"] is int ? json["total_views"].toString() : json["total_views"] ?? '',
    createdAt: json["created_at"] is int ? json["created_at"].toString() : json["created_at"] ?? '',
    imageUrl: json["image_url"] ?? '',
    category: json["category"] == null ? null : Category.fromMap(json["category"]),
    subcategory: json["subcategory"] == null ? null : Brand.fromMap(json["subcategory"]),
    brand: json["brand"] == null ? null : Brand.fromMap(json["brand"]),
    customer: json["customer"] == null ? null : UserProfileModel.fromMap(json["customer"]),
    adFeatures: json["adFeatures"] == null ? [] : List<AdFeature>.from(json["adFeatures"].map((x) => AdFeature.fromMap(x))),
    galleries: json["galleries"] == null ? [] : List<Gallery>.from(json["galleries"].map((x) => Gallery.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "thumbnail": thumbnail,
    "price": price,
    "user_id": userId,
    "featured": featured,
    "wishlisted": is_wishlist,
    "region": region,
    "country": country,
    "city": city,
    "address": address,
    "status": status,
    "total_views": totalViews,
    "created_at": createdAt,
    "image_url": imageUrl,
    "category": category?.toMap(),
    "subcategory": subcategory?.toMap(),
    "brand": brand?.toMap(),
    "customer": customer?.toMap(),
    "adFeatures": List<dynamic>.from(adFeatures.map((x) => x.toMap())),
    "galleries": List<dynamic>.from(galleries.map((x) => x.toMap())),
  };

  @override
  String toString() {
    return 'AdModel(id: $id, title: $title, category: $category, subcategory: $subcategory, slug: $slug, thumbnail: $thumbnail, price: $price, user_id: $userId, featured: $featured, wishlisted: $is_wishlist, region: $region, city: $city, country: $country, image_url: $imageUrl,address: $address, status: $status, total_views: $totalViews,created_at: $createdAt, brand: $brand, customer: $customer, adFeatures: $adFeatures, galleries: $galleries)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      slug,
      thumbnail,
      price,
      userId,
      featured,
      is_wishlist,
      region,
      country,
      city,
      address,
      status,
      totalViews,
      createdAt,
      category,
      subcategory,
      brand,
      imageUrl,
      customer,
      adFeatures,
      galleries,
    ];
  }
}

class Gallery extends Equatable{
  const Gallery({
    required this.id,
    required this.adId,
    required this.image,
    required this.imageUrl,
  });

  final int id;
  final String adId;
  final String image;
  final String imageUrl;

  Gallery copyWith({
    int? id,
    String? adId,
    String? image,
    String? imageUrl,
  }) =>
      Gallery(
        id: id ?? this.id,
        adId: adId ?? this.adId,
        image: image ?? this.image,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory Gallery.fromJson(String str) => Gallery.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gallery.fromMap(Map<String, dynamic> json) => Gallery(
    id: json["id"] is String ? int.parse(json["id"]) : json["id"] ?? 0,
    adId: json["ad_id"] is int ? json["ad_id"].toString() : json["ad_id"] ?? '',
    image: json["image"] ?? '',
    imageUrl: json["image_url"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "ad_id": adId,
    "image": image,
    "image_url": imageUrl,
  };

  @override
  String toString() {
    return 'Gallery(id: $id, ad_id: $adId, image: $image, image_url: $imageUrl)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      adId,
      image,
      imageUrl,
    ];
  }
}

class AdFeature extends Equatable{
  const AdFeature({
    required this.id,
    required this.adId,
    required this.name,
  });

  final int id;
  final String adId;
  final String name;

  AdFeature copyWith({
    int? id,
    String? adId,
    String? name,
  }) =>
      AdFeature(
        id: id ?? this.id,
        adId: adId ?? this.adId,
        name: name ?? this.name,
      );

  factory AdFeature.fromJson(String str) => AdFeature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdFeature.fromMap(Map<String, dynamic> json) => AdFeature(
    id: json["id"] is String ? int.parse(json["id"]) : json["id"] ?? 0,
    adId: json["ad_id"] is int ? (json["ad_id"].toString()) : json['ad_id'] ?? '',
    name: json["name"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "ad_id": adId,
    "name": name,
  };

  @override
  String toString() {
    return 'AdFeature(id: $id, ad_id: $adId, name: $name)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      adId,
      name,
    ];
  }
}