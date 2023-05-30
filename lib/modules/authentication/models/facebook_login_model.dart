// To parse this JSON data, do
//
//     final facebookLoginModel = facebookLoginModelFromJson(jsonString);

import 'dart:convert';

FacebookLoginModel facebookLoginModelFromJson(String str) => FacebookLoginModel.fromJson(json.decode(str));

String facebookLoginModelToJson(FacebookLoginModel data) => json.encode(data.toJson());

class FacebookLoginModel {
  FacebookLoginModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.picture,
  });

  String? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  Picture? picture;

  factory FacebookLoginModel.fromJson(Map<String, dynamic> json) => FacebookLoginModel(
    id: json["id"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    picture: Picture.fromJson(json["picture"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "picture": picture?.toJson(),
  };
}

class Data {
  Data({
    this.height,
    this.isSilhouette,
    this.url,
    this.width,
  });

  int? height;
  bool? isSilhouette;
  String? url;
  int? width;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    height: json["height"],
    isSilhouette: json["is_silhouette"],
    url: json["url"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "is_silhouette": isSilhouette,
    "url": url,
    "width": width,
  };
}

class Picture {
  Picture({
    this.data,
  });

  Data? data;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class PictureData {
  PictureData({
    this.url,
  });

  String? url;

  factory PictureData.fromJson(Map<String, dynamic> json) => PictureData(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}

