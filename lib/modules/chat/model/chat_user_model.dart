import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChatUsersModel extends Equatable{
  const ChatUsersModel({
    required this.id,
    required this.name,
    required this.username,
    required this.image,
    required this.imageUrl,
    required this.lastMsg,
    required this.lastUpdatedAt,
  });

  final int id;
  final String name;
  final String username;
  final String image;
  final String imageUrl;
  final String lastMsg;
  final String lastUpdatedAt;

  ChatUsersModel copyWith({
    int? id,
    String? name,
    String? username,
    String? image,
    String? imageUrl,
    String? lastMsg,
    String? lastUpdatedAt,
  }) =>
      ChatUsersModel(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        image: image ?? this.image,
        imageUrl: imageUrl ?? this.imageUrl,
        lastMsg: lastMsg ?? this.lastMsg,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      );

  factory ChatUsersModel.fromJson(String str) => ChatUsersModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatUsersModel.fromMap(Map<String, dynamic> json) => ChatUsersModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    username: json["username"] ?? '',
    image: json["image"] ?? '',
    imageUrl: json["image_url"] ?? '',
    lastMsg: json["body"] ?? '',
    lastUpdatedAt: json["created_at"] ?? DateTime.now().toString(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "username": username,
    "image": image,
    "image_url": imageUrl,
    "body": lastMsg,
    "created_at": lastUpdatedAt,
  };

  @override
  String toString() {
    return 'ChatUsersModel(id: $id, name: $name, username: $username, image: $image, image_url: $imageUrl, body: $lastMsg, created_at: $lastUpdatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      username,
      image,
      imageUrl,
      lastMsg,
      lastUpdatedAt,
    ];
  }
}