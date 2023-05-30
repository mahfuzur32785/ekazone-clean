import 'dart:convert';

import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final int id;
  final String title;
  final List<String> subLocation;
  const LocationModel({
    required this.id,
    required this.title,
    required this.subLocation,
  });

  LocationModel copyWith({
    int? id,
    String? title,
    List<String>? subLocation,
  }) {
    return LocationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subLocation: subLocation ?? this.subLocation,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'subLocation': List<dynamic>.from(subLocation.map((x) => x))});

    return result;
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      subLocation: map['subLocation'] == null ? [] : List<String>.from(map["subLocation"].map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationModel(id: $id, title: $title, subLocation: $subLocation)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      subLocation,
    ];
  }
}
