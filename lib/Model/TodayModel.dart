// To parse this JSON data, do
//
//     final todayModel = todayModelFromJson(jsonString);


// this model is edited  where null is check

import 'dart:convert';

TodayModel todayModelFromJson(String str) => TodayModel.fromJson(json.decode(str));

String todayModelToJson(TodayModel data) => json.encode(data.toJson());

class TodayModel {
    TodayModel({
        this.data,
        this.userData,
        this.subscription,
        this.role,
    });

    Data data;
    UserData userData;
    bool subscription;
    String role;

    factory TodayModel.fromJson(Map<String, dynamic> json) => TodayModel(
        data: Data.fromJson(json["data"]),
        //shaku edit
        userData:json["userData"]!=null? UserData.fromJson(json["userData"]):null,
        subscription: json["subscription"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "userData": userData.toJson(),
        "subscription": subscription,
        "role": role,
    };
}

class Data {
    Data({
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
    var status;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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

class UserData {
    UserData({
        this.status,
        this.todayVideo,
    });

    bool status;
    TodayVideo todayVideo;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        status: json["status"],
        //shaku edit///

        /////////
        ////////
        ///////
        ///////
        todayVideo:json["todayVideo"]!=null? TodayVideo.fromJson(json["todayVideo"]):null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "todayVideo": todayVideo.toJson(),
    };
}

class TodayVideo {
    TodayVideo({
        this.day,
        this.video,
    });

    var day;
    List<Video> video;

    factory TodayVideo.fromJson(Map<String, dynamic> json) => TodayVideo(
        day: json["day"],
        video:json["video"] !=null ?List<Video>.from(json["video"].map((x) => Video.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "video": List<dynamic>.from(video.map((x) => x.toJson())),
    };
}

class Video {
    Video({
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
    var day;
    String videoDescription;
    String video;
    String type;
    String startingImage;
    String endinggImage;
    String publish;
    DateTime createdAt;
    DateTime updatedAt;

    factory Video.fromJson(Map<String, dynamic> json) => Video(
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
