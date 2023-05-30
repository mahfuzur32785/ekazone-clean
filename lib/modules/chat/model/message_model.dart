import 'dart:convert';

import 'package:equatable/equatable.dart';

class MessageModel extends Equatable{
  const MessageModel({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.body,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String fromId;
  final String toId;
  final String body;
  final String read;
  final String createdAt;
  final String updatedAt;

  MessageModel copyWith({
    int? id,
    String? fromId,
    String? toId,
    String? body,
    String? read,
    String? createdAt,
    String? updatedAt,
  }) =>
      MessageModel(
        id: id ?? this.id,
        fromId: fromId ?? this.fromId,
        toId: toId ?? this.toId,
        body: body ?? this.body,
        read: read ?? this.read,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory MessageModel.fromJson(String str) => MessageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
    id: json["id"]  ?? 0,
    fromId: json["from_id"] is int
          ? (json["from_id"] as int).toString() : json["from_id"] ?? '',
    toId: json["to_id"] is int
        ? (json["to_id"] as int).toString() : json["to_id"] ?? '',
    body: json["body"]??'',
    read: json["read"]??'',
    createdAt: json["created_at"]??'',
    updatedAt: json["updated_at"]??'',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "from_id": fromId,
    "to_id": toId,
    "body": body,
    "read": read,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  @override
  String toString() {
    return 'MessageModel(id: $id, from_id: $fromId, to_id: $toId, body: $body, read: $read, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      fromId,
      toId,
      body,
      read,
      createdAt,
      updatedAt,
    ];
  }
}