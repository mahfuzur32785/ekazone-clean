import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import 'package:ekayzone/modules/profile/model/review_model.dart';

import '../../authentication/models/user_prfile_model.dart';

class PublicProfileModel extends Equatable {
  final UserProfileModel user;
  final ProfileRatingDetails ratingDetails;
  final List<AdModel> recentAds;
  final int totalActiveAds;
  final List<SocialMedias> socialMedias;
  final List<ReviewModel> reviewList;
  const PublicProfileModel({
    required this.user,
    required this.ratingDetails,
    required this.recentAds,
    required this.totalActiveAds,
    required this.socialMedias,
    required this.reviewList,
  });

  PublicProfileModel copyWith({
    UserProfileModel? user,
    ProfileRatingDetails? ratingDetails,
    List<AdModel>? recentAds,
    int? totalActiveAds,
    List<SocialMedias>? socialMedias,
    List<ReviewModel>? reviewList,
  }) {
    return PublicProfileModel(
      user: user ?? this.user,
      ratingDetails: ratingDetails ?? this.ratingDetails,
      recentAds: recentAds ?? this.recentAds,
      totalActiveAds: totalActiveAds ?? this.totalActiveAds,
      socialMedias: socialMedias ?? this.socialMedias,
      reviewList: reviewList ?? this.reviewList,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user': user.toMap()});
    result.addAll({'rating_details': ratingDetails.toMap()});
    result.addAll({'recent_ads': recentAds.map((e) => e.toMap()).toList()});
    result.addAll({'total_active_ad': totalActiveAds});
    result.addAll({'social_medias': socialMedias.map((e) => e.toMap()).toList()});
    result.addAll({'reviews': reviewList.map((e) => e.toMap()).toList()});

    return result;
  }

  factory PublicProfileModel.fromMap(Map<String, dynamic> map) {
    return PublicProfileModel(
      user: UserProfileModel.fromMap(map['user']),
      ratingDetails: ProfileRatingDetails.fromMap(map['rating_details']),
      recentAds: map["recent_ads"] == null ? [] : List<AdModel>.from(
          map['recent_ads'].map((x) => AdModel.fromMap(x))),
      totalActiveAds: map["total_active_ad"] ?? 0,
      socialMedias: map["social_medias"] == null ? [] : List<SocialMedias>.from(
          map['social_medias'].map((x) => SocialMedias.fromMap(x))),
      reviewList: map["reviews"] == null ? [] : List<ReviewModel>.from(
          map['reviews'].map((x) => ReviewModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PublicProfileModel.fromJson(String source) =>
      PublicProfileModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PublicProfileModel(user: $user, rating_details: $ratingDetails, recent_ads: $recentAds, total_active_ad: $totalActiveAds, social_medias: $socialMedias, reviews: $reviewList)';

  @override
  List<Object> get props => [user, ratingDetails, recentAds, totalActiveAds, socialMedias,reviewList];
}

class ProfileRatingDetails extends Equatable{
  const ProfileRatingDetails({
    required this.total,
    required this.rating,
    required this.average,
  });

  final int total;
  final int rating;
  final String average;

  ProfileRatingDetails copyWith({
    int? total,
    int? rating,
    String? average,
  }) =>
      ProfileRatingDetails(
        total: total ?? this.total,
        rating: rating ?? this.rating,
        average: average ?? this.average,
      );

  factory ProfileRatingDetails.fromJson(String str) => ProfileRatingDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileRatingDetails.fromMap(Map<String, dynamic> json) => ProfileRatingDetails(
    total: json["total"] ?? 0,
    rating: json["rating"] ?? 0,
    average: json["average"] ?? '0',
  );

  Map<String, dynamic> toMap() => {
    "total": total,
    "rating": rating,
    "average": average,
  };

  @override
  String toString() =>
      'ProfileRatingDetails(total: $total, rating: $rating, average: $average)';

  @override
  List<Object> get props => [total, rating, average];
}

class SocialMedias extends Equatable{
  const SocialMedias({
    required this.id,
    required this.socialMedia,
    required this.url,
  });

  final int id;
  final String socialMedia;
  final String url;

  SocialMedias copyWith({
    int? id,
    String? socialMedia,
    String? url,
  }) =>
      SocialMedias(
        id: id ?? this.id,
        socialMedia: socialMedia ?? this.socialMedia,
        url: url ?? this.url,
      );

  factory SocialMedias.fromJson(String str) => SocialMedias.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialMedias.fromMap(Map<String, dynamic> json) => SocialMedias(
    id: json["id"] ?? 0,
    socialMedia: json["social_media"] ?? '',
    url: json["url"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "social_media": socialMedia,
    "url": url,
  };

  @override
  String toString() =>
      'SocialMedias(id: $id, social_media: $socialMedia, url: $url)';

  @override
  List<Object> get props => [id, socialMedia, url];
}
