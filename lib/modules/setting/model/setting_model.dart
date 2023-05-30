import 'dart:convert';

import 'package:equatable/equatable.dart';

class SettingModel extends Equatable {
  final int id;
  final String topBarPhone;
  final String currencyName;
  final String currencyIcon;
  final String appName;
  final String appUrl;
  final String logoImageUrl;
  final String whiteLogoUrl;
  final String faviconImageUrl;
  final String loaderImageUrl;
  const SettingModel({
    required this.id,
    required this.topBarPhone,
    required this.currencyName,
    required this.currencyIcon,
    required this.appName,
    required this.appUrl,
    required this.logoImageUrl,
    required this.whiteLogoUrl,
    required this.faviconImageUrl,
    required this.loaderImageUrl,
  });

  SettingModel copyWith({
    int? id,
    String? topBarPhone,
    String? currencyName,
    String? currencyIcon,
    String? appName,
    String? appUrl,
    String? logoImageUrl,
    String? whiteLogoUrl,
    String? faviconImageUrl,
    String? loaderImageUrl,
  }) {
    return SettingModel(
      id: id ?? this.id,
      topBarPhone: topBarPhone ?? this.topBarPhone,
      currencyName: currencyName ?? this.currencyName,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      appName: appName ?? this.appName,
      appUrl: appUrl ?? this.appUrl,
      logoImageUrl: logoImageUrl ?? this.logoImageUrl,
      whiteLogoUrl: whiteLogoUrl ?? this.whiteLogoUrl,
      faviconImageUrl: faviconImageUrl ?? this.faviconImageUrl,
      loaderImageUrl: loaderImageUrl ?? this.loaderImageUrl,
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "topbar_phone": topBarPhone,
    "currency_name": currencyName,
    "currency_icon": currencyIcon,
    "app_name": appName,
    "app_url": appUrl,
    "logo_image_url": logoImageUrl,
    "white_logo_url": whiteLogoUrl,
    "favicon_image_url": faviconImageUrl,
    "loader_image_url": loaderImageUrl,
  };

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      id: map["id"] ?? 0,
      topBarPhone: map["topbar_phone"] ?? '',
      currencyName: map["currency_name"] ?? '',
      currencyIcon: map["currency_icon"] ?? 'VT',
      appName: map["app_name"] ?? '',
      appUrl: map["app_url"] ?? '',
      logoImageUrl: map["logo_image_url"] ?? '',
      whiteLogoUrl: map["white_logo_url"] ?? '',
      faviconImageUrl: map["favicon_image_url"] ?? '',
      loaderImageUrl: map["loader_image_url"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SettingModel(id: $id, topbar_phone: $topBarPhone, currency_name: $currencyName, currency_icon: $currencyIcon, app_name: $appName, app_url: $appUrl, logo_image_url: $logoImageUrl, white_logo_url: $whiteLogoUrl, favicon_image_url: $faviconImageUrl, loader_image_url: $loaderImageUrl)';
  }

  @override
  List<Object> get props {
    return [
      id,
      topBarPhone,
      currencyName,
      currencyIcon,
      appName,
      appUrl,
      logoImageUrl,
      whiteLogoUrl,
      faviconImageUrl,
      logoImageUrl,
    ];
  }
}
