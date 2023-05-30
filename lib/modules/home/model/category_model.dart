import 'dart:convert';

import 'package:ekayzone/modules/home/model/brand_model.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable{
  const Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.order,
    required this.adCount,
    required this.image,
    required this.subCategoryList,
    required this.brandList,
  });

  final int id;
  final String name;
  final String slug;
  final String icon;
  final String order;
  final int adCount;
  final String image;
  final List<Brand> subCategoryList;
  final List<BrandModel> brandList;

  Category copyWith({
    int? id,
    String? name,
    String? slug,
    String? icon,
    String? order,
    int? adCount,
    String? image,
    List<Brand>? subCategoryList,
    List<BrandModel>? brandList,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        icon: icon ?? this.icon,
        order: order ?? this.order,
        adCount: adCount ?? this.adCount,
        image: image ?? this.image,
        subCategoryList: subCategoryList ?? this.subCategoryList,
        brandList: brandList ?? this.brandList,
      );

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
    icon: json["icon"] ?? '',
    order: json["order"] is int ? json["order"].toString() : json['order'] ?? '',
    adCount: json["ad_count"] ?? 0,
    image: json["image"] ?? '',
    subCategoryList: json["subcategories"] == null ? [] : List<Brand>.from(json['subcategories']
        .map((x) => Brand.fromMap(x))),
    brandList: json["brand"] == null ? [] : List<BrandModel>.from(json['brand']
        .map((x) => BrandModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "slug": slug,
    "icon": icon,
    "order": order,
    "ad_count": adCount,
    "image": image,
    "subcategories": subCategoryList,
    "brand": brandList,
  };

  @override
  String toString() {
    return 'Category(id: $id, name: $name, slug: $slug, icon: $icon, order: $order, ad_count: $adCount, image: $image,subcategories: $subCategoryList, brand:$brandList)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      slug,
      icon,
      order,
      adCount,
      image,
      subCategoryList,
      brandList,
    ];
  }
}

class Brand extends Equatable{
  const Brand({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.adCount,
    required this.status,
  });

  final int id;
  final int categoryId;
  final String name;
  final String slug;
  final int adCount;
  final int status;

  Brand copyWith({
    int? id,
    int? categoryId,
    String? name,
    String? slug,
    int? adCount,
    int? status,
  }) =>
      Brand(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        adCount: adCount ?? this.adCount,
        status: status ?? this.status,
      );

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
    id: json["id"] ?? 0,
    categoryId: json["category_id"] is String ? int.parse(json["category_id"]) : json["category_id"] ?? 0,
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
    adCount: json["ad_count"] ?? 0,
    status: json["status"] is String ? int.parse(json["status"]) : json["status"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "slug": slug,
    "ad_count": adCount,
    "status": status,
  };

  @override
  String toString() {
    return 'Brand(id: $id, category_id: $categoryId, name: $name, slug: $slug, ad_count: $adCount, status: $status)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      categoryId,
      name,
      slug,
      adCount,
      status,
    ];
  }
}