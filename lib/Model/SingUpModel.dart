
// To parse this JSON data, do
//
//     final singUpModel = singUpModelFromJson(jsonString);

import 'dart:convert';

SingUpModel singUpModelFromJson(String str) => SingUpModel.fromJson(json.decode(str));

String singUpModelToJson(SingUpModel data) => json.encode(data.toJson());

class SingUpModel {
    SingUpModel({
        this.data,
        this.accessToken,
        this.tokenType,
        this.expiresIn,
    });

    Data data;
    String accessToken;
    String tokenType;
    int expiresIn;

    factory SingUpModel.fromJson(Map<String, dynamic> json) => SingUpModel(
        data: Data.fromJson(json["data"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
    };
}

class Data {
    Data({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
