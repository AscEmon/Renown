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
    List<dynamic> reply;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        post: json["post"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        reply: List<dynamic>.from(json["reply"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post": post,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "reply": List<dynamic>.from(reply.map((x) => x)),
    };
}
