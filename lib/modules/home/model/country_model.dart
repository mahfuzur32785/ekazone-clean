import 'dart:convert';

import 'package:equatable/equatable.dart';

class TopCountry extends Equatable{
  const TopCountry({
    required this.id,
    required this.iso,
    required this.name,
    required this.nicename,
    required this.iso3,
    required this.numcode,
    required this.phonecode,
    required this.code,
    required this.symbol,
    required this.isDefault,
    required this.status,
    required this.flag,
  });

  final String id;
  final String iso;
  final String name;
  final String nicename;
  final String iso3;
  final String numcode;
  final String phonecode;
  final String code;
  final String symbol;
  final String isDefault;
  final String status;
  final String flag;

  TopCountry copyWith({
    String? id,
    String? iso,
    String? name,
    String? nicename,
    String? iso3,
    String? numcode,
    String? phonecode,
    String? code,
    String? symbol,
    String? isDefault,
    String? status,
    String? flag,
  }) =>
      TopCountry(
        id: id ?? this.id,
        iso: iso ?? this.iso,
        name: name ?? this.name,
        nicename: nicename ?? this.nicename,
        iso3: iso3 ?? this.iso3,
        numcode: numcode ?? this.numcode,
        phonecode: phonecode ?? this.phonecode,
        code: code ?? this.code,
        symbol: symbol ?? this.symbol,
        isDefault: isDefault ?? this.isDefault,
        status: status ?? this.status,
        flag: flag ?? this.flag,
      );

  factory TopCountry.fromJson(String str) => TopCountry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopCountry.fromMap(Map<String, dynamic> json) => TopCountry(
    id: json["id"] is int ? json["id"].toString(): json["id"]??"",
    iso: json["iso"],
    name: json["name"],
    nicename: json["nicename"],
    iso3: json["iso3"],
    numcode: json["numcode"]  is int ? json["numcode"].toString() : json["numcode"] ?? '',
    phonecode: json["phonecode"] is int ? json["phonecode"].toString() : json["phonecode"] ?? '',
    code: json["code"] ?? '',
    symbol: json["symbol"] ?? '',
    isDefault: json["is_default"] is int ? json["is_default"].toString() : json["is_default"] ?? '',
    status: json["status"] is int ? json["status"].toString() : json["status"] ?? '',
    flag: json["flag"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "iso": iso,
    "name": name,
    "nicename": nicename,
    "iso3": iso3,
    "numcode": numcode,
    "phonecode": phonecode,
    "code": code,
    "symbol": symbol,
    "is_default": isDefault,
    "status": status,
    "flag": flag,
  };

  @override
  String toString() {
    return 'TopCountry(id: $id,status:$status, code:$code, symbol:$symbol, flag:$flag iso: $iso, name:$name,nicename:$nicename, iso3:$iso3,numcode:$numcode, phonecode:$phonecode,isDefault:$isDefault)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      iso,
      name,
      nicename,
      iso3,
      numcode,
      phonecode,
      code,
      symbol,
      isDefault,
      status,
      flag
    ];
  }
}
