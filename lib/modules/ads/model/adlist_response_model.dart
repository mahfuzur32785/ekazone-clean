import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/home/model/ad_model.dart';
import '../../home/model/product_model.dart';

class AdListResponseModel extends Equatable {
  final List<AdModel> adList;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;
  final String prevPageUrl;
  final String? nextPageUrl;
  const AdListResponseModel({
    required this.adList,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
    required this.prevPageUrl,
    required this.nextPageUrl,
  });

  AdListResponseModel copyWith({
    List<AdModel>? adList,
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
    int? from,
    int? to,
    String? prevPageUrl,
    String? nextPageUrl,
  }) {
    return AdListResponseModel(
      adList: adList ?? this.adList,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      from: from ?? this.from,
      to: to ?? this.to,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': adList.map((x) => x.toMap()).toList()});
    result.addAll({'current_page': currentPage});
    result.addAll({'last_page': lastPage});
    result.addAll({'per_page': perPage});
    result.addAll({'total': total});
    result.addAll({'from': from});
    result.addAll({'to': to});
    result.addAll({'prev_page_url': prevPageUrl});
    result.addAll({'next_page_url': nextPageUrl});

    return result;
  }

  factory AdListResponseModel.fromMap(Map<String, dynamic> map) {
    return AdListResponseModel(
      adList: map['data'] != null
          ? List<AdModel>.from(
              map['data']?.map((x) => AdModel.fromMap(x)))
          : [],
      currentPage: map['current_page']?.toInt() ?? 0,
      lastPage: map['last_page']?.toInt() ?? 0,
      perPage: map['per_page'] != null ? int.parse("${map['per_page']}") : 0,
      total: map['total']?.toInt() ?? 0,
      from: map['from']?.toInt() ?? 0,
      to: map['to']?.toInt() ?? 0,
      prevPageUrl: map['prev_page_url'] ?? '',
      nextPageUrl: map['next_page_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdListResponseModel.fromJson(String source) =>
      AdListResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdListResponseModel(data: $adList, current_page: $currentPage, last_page: $lastPage, per_page: $perPage, total: $total, from: $from, to: $to, prev_page_url: $prevPageUrl, next_page_url: $nextPageUrl)';
  }

  @override
  List<Object> get props {
    return [
      adList,
      currentPage,
      lastPage,
      perPage,
      total,
      from,
      to,
      prevPageUrl,
    ];
  }
}
