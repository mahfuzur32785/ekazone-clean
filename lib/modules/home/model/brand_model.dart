import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model_model.dart';

class BrandModel extends Equatable{
  const BrandModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.modelList,
  });

  final int id;
  final String categoryId;
  final String name;
  final String slug;
  final List<Model> modelList;

  BrandModel copyWith({
    int? id,
    String? categoryId,
    String? name,
    String? slug,
    List<Model>? modelList,
  }) =>
      BrandModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        modelList: modelList ?? this.modelList,
      );

  factory BrandModel.fromJson(String str) => BrandModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrandModel.fromMap(Map<String, dynamic> json) => BrandModel(
    id: json["id"] ?? 0,
    categoryId: json["category_id"] is int? json["category_id"].toString(): json["category_id"] ?? '',
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
    modelList: json['models'] == null || json['models'] == ""
        ? []
        : List<Model>.from(json['models']
        .map((x) => Model.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "slug": slug,
    "models": modelList,
  };

  @override
  String toString() {
    return 'BrandModel(id: $id, category_id: $categoryId, name: $name, slug: $slug, models: $modelList)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      categoryId,
      name,
      slug,
      modelList,
    ];
  }
}