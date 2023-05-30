import 'dart:convert';

import 'package:equatable/equatable.dart';

class Model extends Equatable{
  const Model({
    required this.id,
    required this.title,
    required this.comment,
    required this.categoryId,
    required this.subcategoryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  final int id;
  final String title;
  final dynamic comment;
  final String categoryId;
  final String subcategoryId;
  final String status;
  final dynamic createdAt;
  final dynamic updatedAt;
  final String createdBy;
  final dynamic updatedBy;

  Model copyWith({
    int? id,
    String? title,
    dynamic comment,
    String? categoryId,
    String? subcategoryId,
    String? status,
    dynamic createdAt,
    dynamic updatedAt,
    String? createdBy,
    dynamic updatedBy,
  }) =>
      Model(
        id: id ?? this.id,
        title: title ?? this.title,
        comment: comment ?? this.comment,
        categoryId: categoryId ?? this.categoryId,
        subcategoryId: subcategoryId ?? this.subcategoryId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory Model.fromJson(String str) => Model.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Model.fromMap(Map<String, dynamic> json) => Model(
    id: json["id"] is String ? int.parse(json["id"]) : json["id"] ?? 0,
    title: json["title"] ?? '',
    comment: json["comment"] ?? '',
    categoryId: json["category_id"] is int ? json["category_id"].toString() : json["category_id"] ?? '',
    subcategoryId: json["subcategory_id"] is int ? json["subcategory_id"].toString() : json["subcategory_id"] ?? '',
    status: json["status"] is int ? json["status"].toString() : json["status"] ?? '',
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    createdBy: json["created_by"] is int ? json["created_by"].toString() : json["created_by"]?? '',
    updatedBy: json["updated_by"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "comment": comment,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
  };

  @override
  String toString() {
    return 'Model(id: $id, title: $title,updated_at:$updatedAt,updated_by:$updatedBy, created_at:$createdAt, created_by:$createdBy, comment: $comment, status: $status, category_id:$categoryId, subcategory_id:$subcategoryId,  )';
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      comment,
      status,
      categoryId,
       subcategoryId,
      createdAt,
      createdBy,
      updatedAt,
      updatedBy
    ];
  }
}