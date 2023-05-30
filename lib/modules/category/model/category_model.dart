import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String title;
  final List<String> subCategory;
  const CategoryModel({
    required this.id,
    required this.title,
    required this.subCategory,
  });

  CategoryModel copyWith({
    int? id,
    String? title,
    List<String>? subCategory,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subCategory: subCategory ?? this.subCategory,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'subCategory': List<dynamic>.from(subCategory.map((x) => x))});

    return result;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      subCategory: map['subCategory'] == null ? [] : List<String>.from(map["subCategory"].map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryModel(id: $id, title: $title, subCategory: $subCategory)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      subCategory,
    ];
  }
}
