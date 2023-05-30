import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/authentication/models/user_prfile_model.dart';

class SellerResponseModel extends Equatable {
  final List<UserProfileModel> seller;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;
  final String prevPageUrl;
  final String? nextPageUrl;
  const SellerResponseModel({
    required this.seller,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
    required this.prevPageUrl,
    required this.nextPageUrl,
  });

  SellerResponseModel copyWith({
    List<UserProfileModel>? seller,
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
    int? from,
    int? to,
    String? prevPageUrl,
    String? nextPageUrl,
  }) {
    return SellerResponseModel(
      seller: seller ?? this.seller,
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

    result.addAll({'data': seller.map((x) => x.toMap()).toList()});
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

  factory SellerResponseModel.fromMap(Map<String, dynamic> map) {
    return SellerResponseModel(
      seller: map['data'] != null
          ? List<UserProfileModel>.from(
          map['data']?.map((x) => UserProfileModel.fromMap(x)))
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

  factory SellerResponseModel.fromJson(String source) =>
      SellerResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SellerResponseModel(data: $seller, current_page: $currentPage, last_page: $lastPage, per_page: $perPage, total: $total, from: $from, to: $to, prev_page_url: $prevPageUrl, next_page_url: $nextPageUrl)';
  }

  @override
  List<Object> get props {
    return [
      seller,
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
