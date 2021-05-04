// To parse this JSON data, do
//
//     final previousActivityModel = previousActivityModelFromJson(jsonString);

import 'dart:convert';

PreviousActivityModel previousActivityModelFromJson(String str) => PreviousActivityModel.fromJson(json.decode(str));

String previousActivityModelToJson(PreviousActivityModel data) => json.encode(data.toJson());

class PreviousActivityModel {
    PreviousActivityModel({
        this.status,
        this.subscription,
        this.data,
    });

    bool status;
    bool subscription;
    Data data;

    factory PreviousActivityModel.fromJson(Map<String, dynamic> json) => PreviousActivityModel(
        status: json["status"],
        subscription: json["subscription"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "subscription": subscription,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.status,
        this.subscription,
        this.history,
    });

    bool status;
    bool subscription;
    Map<String, List<History>> history;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        subscription: json["subscription"],
        history: Map.from(json["history"]).map((k, v) => MapEntry<String, List<History>>(k, List<History>.from(v.map((x) => History.fromJson(x))))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "subscription": subscription,
        "history": Map.from(history).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
    };
}

class History {
    History({
        this.id,
        this.packageId,
        this.videoTitle,
        this.day,
        this.videoDescription,
        this.video,
        this.type,
        this.startingImage,
        this.endinggImage,
        this.publish,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String packageId;
    String videoTitle;
    String day;
    String videoDescription;
    String video;
    String type;
    String startingImage;
    String endinggImage;
    String publish;
    DateTime createdAt;
    DateTime updatedAt;

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        packageId: json["package_id"],
        videoTitle: json["videoTitle"],
        day: json["day"],
        videoDescription: json["videoDescription"],
        video: json["video"],
        type: json["type"],
        startingImage: json["startingImage"],
        endinggImage: json["endinggImage"],
        publish: json["publish"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "package_id": packageId,
        "videoTitle": videoTitle,
        "day": day,
        "videoDescription": videoDescription,
        "video": video,
        "type": type,
        "startingImage": startingImage,
        "endinggImage": endinggImage,
        "publish": publish,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
