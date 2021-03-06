// To parse this JSON data, do
//
//     final adminVideoModel = adminVideoModelFromJson(jsonString);

import 'dart:convert';

AdminVideoModel adminVideoModelFromJson(String str) => AdminVideoModel.fromJson(json.decode(str));

String adminVideoModelToJson(AdminVideoModel data) => json.encode(data.toJson());

class AdminVideoModel {
    AdminVideoModel({
        this.error,
        this.result,
    });

    bool error;
    List<Result> result;

    factory AdminVideoModel.fromJson(Map<String, dynamic> json) => AdminVideoModel(
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
        this.package,
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
    Package package;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
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
        package: Package.fromJson(json["package"]),
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
        "package": package.toJson(),
    };
}

class Package {
    Package({
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

    factory Package.fromJson(Map<String, dynamic> json) => Package(
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
