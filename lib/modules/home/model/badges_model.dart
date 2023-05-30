import 'dart:convert';

class Badges {
  Badges({
    required this.featured,
  });

  final bool featured;

  Badges copyWith({
    bool? featured,
  }) =>
      Badges(
        featured: featured ?? this.featured,
      );

  factory Badges.fromJson(String str) => Badges.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory Badges.fromMap(Map<String, dynamic> json) => Badges(
    featured: json["featured"] ?? false,
  );

  Map<String, dynamic> toMap() => {
    "featured": featured,
  };
}