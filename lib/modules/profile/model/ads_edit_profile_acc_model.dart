import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../authentication/models/user_prfile_model.dart';

class ProfileAccModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String image;
  const ProfileAccModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.image,
  });

  factory ProfileAccModel.init(UserProfileModel user) {
    return ProfileAccModel(
      email: user.email,
      image: '',
      name: user.name,
      phone: user.phone ?? '',
    );
  }

  ProfileAccModel copyWith({
    String? name,
    String? phone,
    String? image,
    String? email,
  }) {
    return ProfileAccModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  Map<String, String> toMap() {
    final result = <String, String>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'image': image});

    return result;
  }

  factory ProfileAccModel.fromMap(Map<String, dynamic> map) {
    return ProfileAccModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileAccModel.fromJson(String source) =>
      ProfileAccModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileAccModel(name: $name, email: $email, phone: $phone, image: $image)';
  }

  @override
  List<Object> get props {
    return [
      name,
      phone,
      image,
      email,
    ];
  }
}
