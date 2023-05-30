import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardCardModel extends Equatable {
  final int id;
  final String title;
  final int value;
  final IconData image;
  const DashboardCardModel({
    required this.id,
    required this.title,
    required this.value,
    required this.image,
  });

  DashboardCardModel copyWith({
    int? id,
    String? title,
    int? value,
    IconData? image,
  }) {
    return DashboardCardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'value': value});
    result.addAll({'image': image});

    return result;
  }

  factory DashboardCardModel.fromMap(Map<String, dynamic> map) {
    return DashboardCardModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      value: map['value'] ?? 0,
      image: map['image'] ?? Icons.adb_sharp,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardCardModel.fromJson(String source) =>
      DashboardCardModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DashboardCardModel(id: $id, title: $title, value: $value, image: $image)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      value,
      image,
    ];
  }
}
