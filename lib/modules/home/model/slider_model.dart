import 'dart:convert';

import 'package:equatable/equatable.dart';

class SliderModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String image;
  final String link;
  final int status;
  final int serial;
  final String? sliderLocation;
  final String createdAt;
  final String updatedAt;
  const SliderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.link,
    required this.status,
    required this.serial,
    required this.createdAt,
    this.sliderLocation,
    required this.updatedAt,
  });

  SliderModel copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    String? link,
    int? status,
    int? serial,
    String? sliderLocation,
    String? createdAt,
    String? updatedAt,
  }) {
    return SliderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      link: link ?? this.link,
      status: status ?? this.status,
      serial: serial ?? this.serial,
      sliderLocation: sliderLocation ?? this.sliderLocation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'image': image});
    result.addAll({'link': link});
    result.addAll({'status': status});
    result.addAll({'serial': serial});
    if (sliderLocation != null) {
      result.addAll({'slider_location': sliderLocation});
    }
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      link: map['link'] ?? '',
      status: map['status'] ?? 0,
      serial: map['serial'] ?? 0,
      sliderLocation: map['slider_location'],
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderModel.fromJson(String source) =>
      SliderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SliderModel(id: $id, title: $title, description: $description, image: $image, link: $link, status: $status, serial: $serial, slider_location: $sliderLocation, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      image,
      link,
      status,
      serial,
      createdAt,
      updatedAt,
    ];
  }
}
