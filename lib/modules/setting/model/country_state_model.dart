import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'city_model.dart';

class CountryStateModel extends Equatable {
  final int countryId;
  final int id;
  final String name;
  final String slug;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<CityModel> cities;
  const CountryStateModel({
    required this.countryId,
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.cities,
  });

  CountryStateModel copyWith({
    int? countryId,
    int? id,
    String? name,
    String? slug,
    int? status,
    String? createdAt,
    String? updatedAt,
    final List<CityModel>? cities,
  }) {
    return CountryStateModel(
      countryId: countryId ?? this.countryId,
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cities: cities ?? this.cities,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'country_id': countryId});
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'slug': slug});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    if (cities.isNotEmpty) {
      result.addAll({'cities': cities.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory CountryStateModel.fromMap(Map<String, dynamic> map) {
    return CountryStateModel(
      countryId: map['country_id'] ?? 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      cities: map['cities'] == null
          ? []
          : List<CityModel>.from(
              map['cities']?.map((x) => CityModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryStateModel.fromJson(String source) =>
      CountryStateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CountryStateModel(countryId: $countryId, id: $id, name: $name, slug: $slug, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, cities" $cities)';
  }

  @override
  List<Object> get props {
    return [
      countryId,
      id,
      name,
      slug,
      status,
      createdAt,
      updatedAt,
      cities,
    ];
  }
}
