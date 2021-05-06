// To parse this JSON data, do
//
//     final userPackagesModel = userPackagesModelFromJson(jsonString);

import 'dart:convert';

UserPackagesModel userPackagesModelFromJson(String str) =>
    UserPackagesModel.fromJson(json.decode(str));

String userPackagesModelToJson(UserPackagesModel data) =>
    json.encode(data.toJson());

class UserPackagesModel {
  UserPackagesModel({
    this.error,
    this.result,
  });

  bool error;
  List<Result> result;

  factory UserPackagesModel.fromJson(Map<String, dynamic> json) =>
      UserPackagesModel(
        error: json["error"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.title,
    this.price,
    this.image,
    this.description,
    this.active,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String price;
  String image;
  String description;
  String active;
  String duration;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        image: json["image"],
        description: json["description"],
        active: json["active"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "image": image,
        "description": description,
        "active": active,
        "duration": duration,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
