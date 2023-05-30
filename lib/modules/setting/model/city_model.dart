import 'dart:convert';

import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final int countryStateId;
  final int id;
  final String name;
  final String slug;
  final int status;
  final String createdAt;
  final String updatedAt;
  const CityModel({
    required this.countryStateId,
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  CityModel copyWith({
    int? countryStateId,
    int? id,
    String? name,
    String? slug,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return CityModel(
      countryStateId: countryStateId ?? this.countryStateId,
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'country_state_id': countryStateId});
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'slug': slug});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      countryStateId: map['country_state_id'] != null ? int.parse("${map['country_state_id']}") : 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] != null ? int.parse("${map['status']}") : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CityModel(countryStateId: $countryStateId, id: $id, name: $name, slug: $slug, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      countryStateId,
      id,
      name,
      slug,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
