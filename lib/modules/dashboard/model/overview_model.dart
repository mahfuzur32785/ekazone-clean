import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/ads/model/adlist_response_model.dart';

import '../../home/model/ad_model.dart';

class DOverViewModel extends Equatable {
  const DOverViewModel({
    required this.adsCount,
    required this.monthWiseViews,
    this.plan,
    required this.activities,
    required this.recentAds,
  });

  final AdsCount adsCount;
  final List<int> monthWiseViews;
  final Plan? plan;
  final List<ActivityLog> activities;
  final AdListResponseModel recentAds;

  DOverViewModel copyWith({
    AdsCount? adsCount,
    List<int>? monthWiseViews,
    Plan? plan,
    List<ActivityLog>? activities,
    AdListResponseModel? recentAds,
  }) =>
      DOverViewModel(
        adsCount: adsCount ?? this.adsCount,
        monthWiseViews: monthWiseViews ?? this.monthWiseViews,
        plan: plan ?? this.plan,
        activities: activities ?? this.activities,
        recentAds: recentAds ?? this.recentAds,
      );

  factory DOverViewModel.fromJson(String str) => DOverViewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DOverViewModel.fromMap(Map<String, dynamic> json) => DOverViewModel(
    adsCount: AdsCount.fromMap(json['ads_count']),
    monthWiseViews: json["month_wise_views"] == null ? [] : List<int>.from(json["month_wise_views"]!.map((x) => x)),
    plan: json["plan"] == null ? null : Plan.fromMap(json["plan"]),
    activities: json["actovity_log"] == null ? [] : List<ActivityLog>.from(json["actovity_log"].map((x) => ActivityLog.fromJson(x))),
    recentAds: AdListResponseModel.fromMap(json["recent_ads"]),
  );

  Map<String, dynamic> toMap() => {
    "ads_count": adsCount,
    "month_wise_views": List<dynamic>.from(monthWiseViews.map((x) => x)),
    "plan": plan == null ? null : plan?.toMap(),
    "actovity_log": List<dynamic>.from(activities.map((x) => x.toJson())),
    "recent_ads": recentAds,
  };

  @override
  String toString() {
    return 'DOverViewModel(ads_count: $adsCount, plan:$plan, month_wise_views: $monthWiseViews, actovity_log: $activities, recent_ads: $recentAds)';
  }

  @override
  List<Object> get props {
    return [
      adsCount,
      monthWiseViews,
      // plan,
      activities,
      recentAds,
    ];
  }
}

class AdsCount extends Equatable{
  const AdsCount({
    required this.postedAdsCount,
    required this.activeAdsCount,
    required this.expireAdsCount,
    required this.pendingAdsCount,
    required this.favouriteAdsCount,
  });

  final int postedAdsCount;
  final int activeAdsCount;
  final int expireAdsCount;
  final int pendingAdsCount;
  final int favouriteAdsCount;

  AdsCount copyWith({
    int? postedAdsCount,
    int? activeAdsCount,
    int? expireAdsCount,
    int? pendingAdsCount,
    int? favouriteAdsCount,
  }) =>
      AdsCount(
        postedAdsCount: postedAdsCount ?? this.postedAdsCount,
        activeAdsCount: activeAdsCount ?? this.activeAdsCount,
        expireAdsCount: expireAdsCount ?? this.expireAdsCount,
        pendingAdsCount: pendingAdsCount ?? this.pendingAdsCount,
        favouriteAdsCount: favouriteAdsCount ?? this.favouriteAdsCount,
      );

  factory AdsCount.fromJson(String str) => AdsCount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdsCount.fromMap(Map<String, dynamic> json) => AdsCount(
    postedAdsCount: json["posted_ads_count"] ?? 0,
    activeAdsCount: json["active_ads_count"] ?? 0,
    expireAdsCount: json["expire_ads_count"] ?? 0,
    pendingAdsCount: json["pending_ads_count"] ?? 0,
    favouriteAdsCount: json["favourite_ads_count"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "posted_ads_count": postedAdsCount,
    "active_ads_count": activeAdsCount,
    "expire_ads_count": expireAdsCount,
    "pending_ads_count": pendingAdsCount,
    "favourite_ads_count": favouriteAdsCount,
  };

  @override
  String toString() {
    return 'AdsCount(posted_ads_count: $postedAdsCount, active_ads_count: $activeAdsCount, expire_ads_count: $expireAdsCount, pending_ads_count:$pendingAdsCount, favourite_ads_count: $favouriteAdsCount )';
  }

  @override
  List<Object> get props {
    return [
      postedAdsCount,
      activeAdsCount,
      activeAdsCount,
      pendingAdsCount,
      favouriteAdsCount
    ];
  }
}

class Plan extends Equatable{
  const Plan({
    required this.adLimit,
    required this.featuredLimit,
    required this.badge,
  });

  final int adLimit;
  final int featuredLimit;
  final bool badge;

  Plan copyWith({
    int? adLimit,
    int? featuredLimit,
    bool? badge,
  }) =>
      Plan(
        adLimit: adLimit ?? this.adLimit,
        featuredLimit: featuredLimit ?? this.featuredLimit,
        badge: badge ?? this.badge,
      );

  factory Plan.fromJson(String str) => Plan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Plan.fromMap(Map<String, dynamic> json) => Plan(
    adLimit: json["ad_limit"],
    featuredLimit: json["featured_limit"],
    badge: json["badge"],
  );

  Map<String, dynamic> toMap() => {
    "ad_limit": adLimit,
    "featured_limit": featuredLimit,
    "badge": badge,
  };

  @override
  String toString() {
    return 'Plan(ad_limit: $adLimit, featured_limit: $featuredLimit, badge: $badge)';
  }

  @override
  List<Object> get props {
    return [
      adLimit,
      featuredLimit,
      badge,
    ];
  }
}

class ActivityLog extends Equatable{
  const ActivityLog({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String type;
  final String notifiableType;
  final int notifiableId;
  final LogData data;
  final dynamic readAt;
  final String createdAt;
  final String updatedAt;

  ActivityLog copyWith({
    String? id,
    String? type,
    String? notifiableType,
    int? notifiableId,
    LogData? data,
    dynamic readAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      ActivityLog(
        id: id ?? this.id,
        type: type ?? this.type,
        notifiableType: notifiableType ?? this.notifiableType,
        notifiableId: notifiableId ?? this.notifiableId,
        data: data ?? this.data,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ActivityLog.fromJson(Map<String, dynamic> json) => ActivityLog(
    id: json["id"],
    type: json["type"],
    notifiableType: json["notifiable_type"],
    notifiableId: json["notifiable_id"],
    data: LogData.fromJson(json["data"]),
    readAt: json["read_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "data": data.toJson(),
    "read_at": readAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  @override
  String toString() {
    return 'DOverViewModel(id: $id, type: $type, notifiable_type: $notifiableType, notifiable_id: $notifiableId, data: $data, read_at: $readAt, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      type,
      notifiableType,
      notifiableId,
      data,
      readAt,
      createdAt,
      updatedAt,
    ];
  }
}

class LogData extends Equatable{
  const LogData({
    required this.msg,
    required this.type,
  });

  final String msg;
  final String type;

  LogData copyWith({
    String? msg,
    String? type,
  }) =>
      LogData(
        msg: msg ?? this.msg,
        type: type ?? this.type,
      );

  factory LogData.fromJson(Map<String, dynamic> json) => LogData(
    msg: json["msg"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "type": type,
  };

  @override
  String toString() {
    return 'LogData(msg: $msg, type: $type)';
  }

  @override
  List<Object> get props {
    return [
      msg,
      type,
    ];
  }
}