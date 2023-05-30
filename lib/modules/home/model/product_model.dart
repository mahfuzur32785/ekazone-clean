import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final String category;
  final String image;
  final String model;
  final String authenticity;
  final String condition;
  final String negotiable;
  final String location;
  final double price;
  const ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.model,
    required this.authenticity,
    required this.condition,
    required this.negotiable,
    required this.location,
    required this.price,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    String? category,
    String? image,
    String? model,
    String? authenticity,
    String? condition,
    String? negotiable,
    String? location,
    double? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      image: image ?? this.image,
      model: model ?? this.model,
      authenticity: authenticity ?? this.authenticity,
      condition: condition ?? this.condition,
      negotiable: negotiable ?? this.negotiable,
      location: location ?? this.title,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'category': category});
    result.addAll({'image': image});
    result.addAll({'model': model});
    result.addAll({'authenticity': authenticity});
    result.addAll({'condition': condition});
    result.addAll({'negotiable': negotiable});
    result.addAll({'location': location});
    result.addAll({'price': price});

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      model: map['model'] ?? '',
      authenticity: map['authenticity'] ?? '',
      condition: map['condition'] ?? '',
      negotiable: map['negotiable'],
      location: map['location'] ?? '',
      price: map['price'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, category: $category, image: $image, model: $model, authenticity: $authenticity, condition: $condition, negotiable: $negotiable, location: $location, price: $price)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      category,
      image,
      model,
      authenticity,
      condition,
      negotiable,
      location,
      price,
    ];
  }
}
