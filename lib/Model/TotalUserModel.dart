// To parse this JSON data, do
//
//     final totalUserModel = totalUserModelFromJson(jsonString);

import 'dart:convert';

TotalUserModel totalUserModelFromJson(String str) => TotalUserModel.fromJson(json.decode(str));

String totalUserModelToJson(TotalUserModel data) => json.encode(data.toJson());

class TotalUserModel {
    TotalUserModel({
        this.error,
        this.result,
    });

    bool error;
    List<Result> result;

    factory TotalUserModel.fromJson(Map<String, dynamic> json) => TotalUserModel(
        error: json["error"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.memberSince,
    });

    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    String status;
    String memberSince;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        memberSince: json["member_since"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "member_since": memberSince,
    };
}
