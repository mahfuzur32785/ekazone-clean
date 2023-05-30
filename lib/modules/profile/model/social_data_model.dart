import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ekayzone/modules/profile/model/public_profile_model.dart';

class SocialDataModel extends Equatable {
  final TextEditingController controller;
  final SocialMedias socialMedia;
  final GlobalKey<FormState> formKey;
  const SocialDataModel({
    required this.controller,
    required this.socialMedia,
    required this.formKey,
  });

  SocialDataModel copyWith({
    TextEditingController? controller,
    SocialMedias? socialMedia,
    GlobalKey<FormState>? formKey,
  }) {
    return SocialDataModel(
      controller: controller ?? this.controller,
      socialMedia: socialMedia ?? this.socialMedia,
      formKey: formKey ?? this.formKey,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'controller': controller});
    result.addAll({'socialMedia': socialMedia});
    result.addAll({'formKey': formKey});

    return result;
  }

  factory SocialDataModel.fromMap(Map<String, dynamic> map) {
    return SocialDataModel(
      controller: map['controller'],
      socialMedia: SocialMedias.fromMap(map['socialMedia']),
      formKey: map['formKey'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialDataModel.fromJson(String source) =>
      SocialDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SocialNameModel(controller: $controller, socialMedia: $socialMedia, formKey: $formKey)';
  }

  @override
  List<Object> get props {
    return [
      controller,
      socialMedia,
      formKey,
    ];
  }
}
