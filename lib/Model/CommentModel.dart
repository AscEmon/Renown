// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
    CommentModel({
        this.error,
        this.result,
    });

    bool error;
    Result result;

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        error: json["error"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "result": result.toJson(),
    };
}

class Result {
    Result({
        this.id,
        this.userId,
        this.post,
        this.createdAt,
        this.updatedAt,
        this.reply,
    });

    int id;
    String userId;
    String post;
    DateTime createdAt;
    DateTime updatedAt;
    List<Reply> reply;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        post: json["post"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        reply: List<Reply>.from(json["reply"].map((x) => Reply.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post": post,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "reply": List<dynamic>.from(reply.map((x) => x.toJson())),
    };
}

class Reply {
    Reply({
        this.id,
        this.userId,
        this.forumId,
        this.reply,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    int id;
    String userId;
    String forumId;
    String reply;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"],
        userId: json["user_id"],
        forumId: json["forum_id"],
        reply: json["reply"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "forum_id": forumId,
        "reply": reply,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
    };
}

class User {
    User({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    String image;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
