// To parse this JSON data, do
//
//     final adminDashBoardModel = adminDashBoardModelFromJson(jsonString);

import 'dart:convert';

AdminDashBoardModel adminDashBoardModelFromJson(String str) => AdminDashBoardModel.fromJson(json.decode(str));

String adminDashBoardModelToJson(AdminDashBoardModel data) => json.encode(data.toJson());

class AdminDashBoardModel {
    AdminDashBoardModel({
        this.error,
        this.data,
    });

    bool error;
    Data data;

    factory AdminDashBoardModel.fromJson(Map<String, dynamic> json) => AdminDashBoardModel(
        error: json["error"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.totalUser,
        this.totalPackage,
        this.totalVideo,
        this.recentUser,
    });

    int totalUser;
    int totalPackage;
    int totalVideo;
    List<RecentUser> recentUser;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalUser: json["total_user"],
        totalPackage: json["total_package"],
        totalVideo: json["total_video"],
        recentUser: List<RecentUser>.from(json["recent_user"].map((x) => RecentUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_user": totalUser,
        "total_package": totalPackage,
        "total_video": totalVideo,
        "recent_user": List<dynamic>.from(recentUser.map((x) => x.toJson())),
    };
}

class RecentUser {
    RecentUser({
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

    factory RecentUser.fromJson(Map<String, dynamic> json) => RecentUser(
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
