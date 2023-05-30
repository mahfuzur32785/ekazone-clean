import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/authentication/models/user_prfile_model.dart';

class ReviewModel extends Equatable{
  const ReviewModel({
    required this.id,
    required this.sellerId,
    required this.userId,
    required this.stars,
    required this.comment,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String sellerId;
  final String userId;
  final String stars;
  final String comment;
  final String status;
  final UserProfileModel user;
  final DateTime createdAt;
  final dynamic updatedAt;

  ReviewModel copyWith({
    int? id,
    String? sellerId,
    String? userId,
    String? stars,
    String? comment,
    String? status,
    UserProfileModel? user,
    DateTime? createdAt,
    dynamic updatedAt,
  }) =>
      ReviewModel(
        id: id ?? this.id,
        sellerId: sellerId ?? this.sellerId,
        userId: userId ?? this.userId,
        stars: stars ?? this.stars,
        comment: comment ?? this.comment,
        status: status ?? this.status,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ReviewModel.fromJson(String str) => ReviewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromMap(Map<String, dynamic> json) => ReviewModel(
    id: json["id"]??0,
    sellerId: json["seller_id"]??'',
    userId: json["user_id"]??'',
    stars: json["stars"]??'',
    comment: json["comment"]??'',
    status: json["status"]??'',
    user: UserProfileModel.fromMap(json["user"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "seller_id": sellerId,
    "user_id": userId,
    "stars": stars,
    "comment": comment,
    "status": status,
    "user": user.toMap(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  @override
  String toString() {
    return 'ReviewModel(id: $id, seller_id: $sellerId, user_id: $userId, start: $stars, comment: $comment, user: $user, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      sellerId,
      userId,
      stars,
      comment,
      status,
      user,
      createdAt,
      updatedAt
    ];
  }
}