import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'country_state_model.dart';

class CountryModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<CountryStateModel> countryStates;
  const CountryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.countryStates,
  });

  CountryModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? status,
    String? createdAt,
    String? updatedAt,
    List<CountryStateModel>? countryStates,
  }) {
    return CountryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      countryStates: countryStates ?? this.countryStates,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'slug': slug});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll(
        {'country_states': countryStates.map((x) => x.toMap()).toList()});

    return result;
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      countryStates: map['country_states'] != null
          ? List<CountryStateModel>.from(
              map['country_states']?.map((x) => CountryStateModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) =>
      CountryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CountryModel(id: $id, name: $name, slug: $slug, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, countryStates: $countryStates)';
  }

  @override
  List<Object> get props {
    return [id, name, slug, status];
  }
}
