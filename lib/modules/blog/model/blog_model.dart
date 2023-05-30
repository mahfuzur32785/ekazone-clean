import 'dart:convert';

import 'package:equatable/equatable.dart';

class BlogModel extends Equatable {
  final int id;
  final String title;
  final String category;
  final String image;
  final String summery;
  final String publishDate;
  const BlogModel({
    required this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.summery,
    required this.publishDate,
  });

  BlogModel copyWith({
    int? id,
    String? title,
    String? category,
    String? image,
    String? summery,
    String? publishDate,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      image: image ?? this.image,
      summery: summery ?? this.summery,
      publishDate: publishDate ?? this.publishDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'category': category});
    result.addAll({'image': image});
    result.addAll({'summery': summery});
    result.addAll({'publishDate': publishDate});

    return result;
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      summery: map['summery'] ?? '',
      publishDate: map['publishDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BlogModel(id: $id, title: $title, category: $category, image: $image, summery: $summery, publishDate: $publishDate)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      category,
      image,
      summery,
      publishDate,
    ];
  }
}
