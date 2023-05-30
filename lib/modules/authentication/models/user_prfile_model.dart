import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String? phone;
  final String? emailVerifiedAt;
  final String? web;
  final String? image;

  //no
  final String? token;
  final String? lastSeen;
  final String? authType;
  final dynamic provider;
  final dynamic providerId;
  final dynamic fcmToken;

  final String? totalAds;
  final String? address;

  //no
  final String? location;
  final String? city;
  final String? state;

  final String? zipCode;

  //no
  final String? country;
  final String? countryCode;
  final dynamic ipAddress;
  final dynamic timeZone;
  final dynamic latitude;
  final dynamic longitude;
  final dynamic device;
  final dynamic browser;
  final dynamic updatedBy;
  final dynamic createdBy;

  final String? totalReview;
  final String? averageReview;
  final String? createdAt;
  final String updatedAt;
  final String? imageUrl;
  final int? showEmail;
  final int? receiveEmail;
  final int? showPhone;
  final String? phoneCode;
  final String? iso;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final String? status;
  final int isVendor;
  final int emailVerified;
  final String? verifyToken;
  final int? adCount;
  final int? reviewCount;
  final String? avgRating;


  const UserProfileModel({
    required this.id,
    required this.name,
    required this.username,
    required this.image,
    required this.imageUrl,
    required this.email,
    required this.showEmail,
    required this.receiveEmail,
    this.phone,
    this.showPhone,
    this.phoneCode,
    this.iso,
    this.countryId,
    this.stateId,
    this.cityId,
    this.zipCode,
    this.emailVerifiedAt,
    this.web,
    required this.status,
    this.address,
    required this.isVendor,
    required this.emailVerified,
    this.verifyToken,
    required this.createdAt,
    required this.updatedAt,
    this.adCount,
    this.reviewCount,
    this.avgRating,
    this.token,
    this.lastSeen,
    this.authType,
    this.provider,
    this.providerId,
    this.fcmToken,
    required this.location,
    this.city,
    this.state,
    this.country,
    this.countryCode,
    this.ipAddress,
    this.timeZone,
    this.latitude,
    this.longitude,
    this.device,
    this.browser,
    this.updatedBy,
    this.createdBy,

    this.totalAds,
    this.totalReview,
    this.averageReview
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      username,
      image,
      imageUrl,
      email,
      showEmail,
      receiveEmail,
      phone,
      showPhone,
      phoneCode,
      iso,
      countryId,
      stateId,
      emailVerifiedAt,
      web,
      status,
      zipCode,
      address,
      isVendor,
      emailVerified,
      verifyToken,
      createdAt,
      updatedAt,
      adCount,
      reviewCount,
      avgRating,

      token,
      lastSeen,
      authType,
      provider,
      providerId,
      fcmToken,
      location,
      city,
      state,
      country,
      countryCode,
      ipAddress,
      timeZone,
      latitude,
      longitude,
      device,
      browser,
      updatedBy,
      createdBy,

      totalAds,
      totalReview,
      averageReview
    ];
  }

  UserProfileModel copyWith({
    int? id,
    String? name,
    String? username,
    String? image,
    String? imageUrl,
    String? email,
    int? showEmail,
    int? receiveEmail,
    String? phone,
    int? showPhone,
    String? phoneCode,
    String? iso,
    int? countryId,
    int? stateId,
    int? cityId,
    String? zipCode,
    String? emailVerifiedAt,
    String? web,
    String? status,
    String? address,
    int? isVendor,
    int? emailVerified,
    String? verifyToken,
    String? createdAt,
    String? updatedAt,
    int? adCount,
    int? reviewCount,
    String? avgRating,

    String? token,
    String? lastSeen,
    String? authType,
    dynamic provider,
    dynamic providerId,
    dynamic fcmToken,

    String? location,
    String? city,
    String? state,

    String? country,
    String? countryCode,
    dynamic ipAddress,
    dynamic timeZone,
    dynamic latitude,
    dynamic longitude,
    dynamic device,
    dynamic browser,
    dynamic updatedBy,
    dynamic createdBy,

    String? totalAds,
    String? totalReview,
    String? averageReview,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      email: email ?? this.email,
      showEmail: showEmail ?? this.showEmail,
      receiveEmail: receiveEmail ?? this.receiveEmail,
      phone: phone ?? this.phone,
      showPhone: showPhone ?? this.showPhone,
      phoneCode: phoneCode ?? this.phoneCode,
      iso: iso ?? this.iso,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      web: web ?? this.web,
      status: status ?? this.status,
      address: address ?? this.address,
      zipCode: zipCode ?? this.zipCode,
      isVendor: isVendor ?? this.isVendor,
      emailVerified: emailVerified ?? this.emailVerified,
      verifyToken: verifyToken ?? this.verifyToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      adCount: adCount ?? this.adCount,
      reviewCount: reviewCount ?? this.reviewCount,
      avgRating: avgRating ?? this.avgRating,

      token: token ?? this.token,
      lastSeen: lastSeen ?? this.lastSeen,
      authType: authType ?? this.authType,
      provider: provider ?? this.provider,
      providerId: providerId ?? this.providerId,
      fcmToken: fcmToken ?? this.fcmToken,

      location: location ?? this.location,
      city: city ?? this.city,
      state: state ?? this.state,

      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      ipAddress: ipAddress ?? this.ipAddress,
      timeZone: timeZone ?? this.timeZone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      device: device ?? this.device,
      browser: browser ?? this.browser,
      updatedBy: updatedBy ?? this.updatedBy,
      createdBy: createdBy ?? this.createdBy,

      totalAds: totalAds ?? this.totalAds,
      totalReview: totalReview ?? this.totalReview,
      averageReview: averageReview ?? this.averageReview,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'username': username});
    if (image != null) {
      result.addAll({'image': image});
    }
    if (image != null) {
      result.addAll({'image_url': imageUrl});
    }
    result.addAll({'email': email});
    result.addAll({'show_email': showEmail});
    result.addAll({'receive_email': receiveEmail});
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (location != null) {
      result.addAll({'location': location});
    }
    result.addAll({'show_phone': showPhone});
    if (phoneCode != null) {
      result.addAll({'phonecode': phoneCode});
    }
    if (iso != null) {
      result.addAll({'iso': iso});
    }
    if (zipCode != null) {
      result.addAll({'zip_code': zipCode});
    }
    if (countryId != null) {
      result.addAll({'country_id': countryId});
    }
    if (stateId != null) {
      result.addAll({'state_id': stateId});
    }
    if (cityId != null) {
      result.addAll({'city_id': cityId});
    }
    if (emailVerifiedAt != null) {
      result.addAll({'email_verified_at': emailVerifiedAt});
    }
    result.addAll({'web': web});
    result.addAll({'status': status});
    if (address != null) {
      result.addAll({'address': address});
    }
    result.addAll({'is_vendor': isVendor});
    result.addAll({'email_verified': emailVerified});
    if (verifyToken != null) {
      result.addAll({'verify_token': verifyToken});
    }
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll({'ad_count': adCount});
    result.addAll({'reviews_count': reviewCount});
    result.addAll({'reviews_avg_stars': avgRating});

    return result;
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      image: map['image'],
      email: map['email'] ?? '',
      imageUrl: map['image_url'] ?? '',
      showEmail: map['show_email'] is String ? int.parse(map['show_email']) : map['show_email'] ?? 0,
      receiveEmail: map['receive_email'] ?? 0,
      phone: map['phone'] ?? '',
      showPhone: map['show_phone'] is String ? int.parse(map['show_phone']) : map['show_phone'] ?? 0,
      phoneCode: map['phonecode'] ?? '',
      iso: map['iso'] ?? '',
      countryId: map['country_id'] ?? 0,
      stateId: map['state_id'] ?? 0,
      cityId: map['city_id'] ?? 0,
      zipCode: map['zip_code'] ?? '',
      emailVerifiedAt: map['email_verified_at'],
      web: map['web'] ?? '',
      status: map['status'] is int ? map['status'].toString() : map['status']  ?? '',
      address: map['address'] ?? '',
      isVendor: map['is_vendor'] != null ? int.parse("${map['is_vendor']}") : 0,
      emailVerified: map['email_verified'] != null
          ? int.parse("${map['email_verified']}")
          : 0,
      verifyToken: map['verify_token'],
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      adCount: map['ad_count'] ?? 0,
      reviewCount: map['reviews_count'] ?? 0,
      avgRating: map['reviews_avg_stars'] ?? '0',

      token: map["token"] ?? '',
      lastSeen: map["last_seen"] ?? '',
      authType: map["auth_type"]?? '' ,
      provider: map["provider"],
      providerId: map["provider_id"],
      fcmToken: map["fcm_token"],

      location: map["location"]?? '',
      city: map["city"]??'',
      state: map["state"]??'',

      country: map["country"]??'',
      countryCode: map["country_code"]??'',
      ipAddress: map["ip_address"],
      timeZone: map["time_zone"],
      latitude: map["latitude"],
      longitude: map["longitude"],
      device: map["device"],
      browser: map["browser"],
      updatedBy: map["updated_by"],
      createdBy: map["created_by"],

      totalAds: map['total_ads'] is int ? map['total_ads'].toString() : map['total_ads']  ?? '',
      totalReview: map['total_review'] is int ? map['total_review'].toString() : map['total_review']  ?? '',
      averageReview: map['average_review'] is int ? map['average_review'].toString() : map['average_review']  ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(id: $id, name: $name, username: $username, image: $image, image_url: $imageUrl, email: $email,  show_email: $showEmail, receive_email: $receiveEmail, phone: $phone, show_phone: $showPhone, phonecode: $phoneCode, iso: $iso, country_id: $countryId, state_id: $stateId, token:$token, last_seen:$lastSeen, auth_type:$authType, cityId: $cityId, email_verified_at: $emailVerifiedAt, provider:$provider,provider_id:$providerId,fcm_token:$fcmToken, device:$device, browser:$browser, updated_by:$updatedBy,created_by:$createdBy, time_zone:$timeZone,latitude:$latitude,longitude:$longitude,  country_code:$countryCode, ip_address:$ipAddress, location:$location,city:$city,state:$state,country:$country,   web: $web, status: $status, address: $address, zipCode: $zipCode, is_vendor: $isVendor, email_verified: $emailVerified, verify_token: $verifyToken, created_at: $createdAt, updated_at: $updatedAt, ad_count: $adCount, reviews_count: $reviewCount,reviews_avg_stars: $avgRating,totalAds:$totalAds, totalReview:$totalReview, averageReview:$averageReview)';
  }
}
