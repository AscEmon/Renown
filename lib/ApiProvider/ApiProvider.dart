import 'dart:convert';
import 'dart:io';
import 'package:TrainnigInfo/Model/AdminModel/AdminDashboardModel.dart';
import 'package:TrainnigInfo/Model/AdminModel/AdminPackagesModel.dart';
import 'package:TrainnigInfo/Model/AdminModel/AdminVideoModel.dart';
import 'package:TrainnigInfo/Model/AdminModel/TotalUserModel.dart';
import 'package:TrainnigInfo/Model/CommentModel.dart';
import 'package:TrainnigInfo/Model/ForumModel.dart';
import 'package:TrainnigInfo/Model/PreviousActivityModel.dart';
import 'package:TrainnigInfo/Model/SingUpModel.dart';
import 'package:TrainnigInfo/Model/UserHomePageModel.dart';
import 'package:TrainnigInfo/Model/UserPackagesModel.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/Views/Utilities/AppUrl.dart';
import 'package:get/get.dart' as GETX;
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:TrainnigInfo/main.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyApiClient {
  final http.Client httpClient;
  MyApiClient({@required this.httpClient});

  //this is for header for SignUp and login
  static header() => {
        'Accept': 'application/json',
      };
  //this is the header where user token is also stored
  static header2() => {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userMap["access_token"]}'
      };

  //this is the header where user token and id is store and its use in Forum portion
  static header3() => {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userMap["access_token"]}',
        'auth_id': '${userMap["data"]["id"]}'
      };

  //this is the header where user token and id is store but key name is user_id
  static header4() => {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userMap["access_token"]}',
        'user_id': '${userMap["data"]["id"]}'
      };

//User Packages  Api Calling
  getUserPackages() async {
    try {
      var response = await httpClient.get(
        AppUrl.userPackagesUrl,
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done user Packages");
        String jsonResponseString = response.body;
        print(response.body);
        return userPackagesModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("getUserPackages :::" + e.toString());
    }
  }

//AdnminPackages Get  Api Calling
  getAdminPakages() async {
    try {
      var response =
          await httpClient.get(AppUrl.adminPackagesUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done AdminPakcges");
        String jsonResponseString = response.body;
        print(response.body);
        return adminPackagesModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("getAdminPackages ::: ${e.toString()}");
    }
  }

  //AdnminDashBoard Get  Api Calling
  getAdminDashBoard() async {
    try {
      var response =
          await httpClient.get(AppUrl.adminDashboardUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done AdminDashBoard");
        String jsonResponseString = response.body;
        print(response.body);
        return adminDashBoardModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("getAdminDashBoard ::: ${e.toString()}");
    }
  }

//TotalUser get Api for Admin where admin will see the list of User
  getTotalUser() async {
    try {
      var response =
          await httpClient.get(AppUrl.adminTotalUserUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done TotalUser");
        String jsonResponseString = response.body;
        print(response.body);
        return totalUserModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("getTotalUser ::: ${e.toString()}");
    }
  }

  //AdnminPackages Status Update Api Calling
  statusUpdateAdminPackages(var id) async {
    try {
      var response = await httpClient
          .get(AppUrl.adminPackagesStatusUrl + "/$id", headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Admin Packages $id Status is Updated");
        print(response.body);
        GETX.Get.snackbar("Update", "Sucessfully Update  the Status",
            snackPosition: GETX.SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        print(response.statusCode);
        print(response.body);
        GETX.Get.snackbar("Error", "Something is Happend",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: GETX.SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("statusUpdateAdminPackages ::: ${e.toString()}");
    }
  }

  //AdnminVideo  GET  Api Calling
  adminVideoGet() async {
    try {
      var response =
          await httpClient.get(AppUrl.adminVideoUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Admin Video Get");
        print(response.body);
        String jsonResponseString = response.body;
        print(response.body);
        return adminVideoModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("adminVideoGet ::: ${e.toString()}");
    }
  }

  //Forum Status   GET  Api Calling
  statusGet() async {
    try {
      var response = await httpClient.get(
          userMap['role'] == "user" ? AppUrl.forumUrl : AppUrl.adminForumUrl,
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Forum Status Get");
        print(response.body);
        String jsonResponseString = response.body;
        print(response.body);
        return forumModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("statusGet ::: ${e.toString()}");
    }
  }

  //Comment GET  Api Calling
  commentGet(var id) async {
    try {
      var response = await httpClient.get(
          userMap['role'] == "user"
              ? AppUrl.commentUrl + "/$id"
              : AppUrl.adminCommentUrl + "/$id",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Comment Get");
        print(response.body);
        String jsonResponseString = response.body;
        print(response.body);
        return commentModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("commentGet ::: ${e.toString()}");
    }
  }

//Previous Activity for USer which is History Api is Calling here
  previousActivityGet() async {
    try {
      var response =
          await httpClient.get(AppUrl.previousActivityUrl, headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("previousActivity Get");
        print(response.body);
        String jsonResponseString = response.body;
        print(response.body);
        return previousActivityModelFromJson(jsonResponseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("previousActivityGet ::: ${e.toString()}");
    }
  }

//this is for SignUp APi where name, email and Password are come from SignUpController
  Future<SingUpModel> signUpPost(
      String name, String email, String password) async {
    print("apiProvider Signup");
    try {
      final response = await httpClient.post(
        AppUrl.signUpUrl,
        headers: header(),
        body: {"name": name, "email": email, "password": password},
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        print(responseString);
        userprefs.setBool("loginStatus", true);
        userprefs.setString("userInfos", responseString);
        userMap = jsonDecode(responseString);
        userprefs.setBool("isNewCheck", userMap['isNew']);
        userMap["role"] == "user"
            ? GETX.Get.offAndToNamed(AppRoutes.PACKAGES)
            : GETX.Get.offAndToNamed(AppRoutes.HOMEPAGE);
        return singUpModelFromJson(responseString);
      } else {
        print(response.statusCode);
        print(response.body);
        GETX.Get.snackbar("Error", response.body);
      }
    } catch (e) {
      print("SignUp ::: ${e.toString()}");
    }
    return null;
  }

  //This is for LoginApi where email and Password are come from loginController
  Future<bool> loginPost(var adminCheck, String email, String password) async {
    print("apiProvider Login");
    print(adminCheck);
    String loginUrl =
        adminCheck == false ? AppUrl.loginUrl : AppUrl.adminLoginUrl;
    try {
      final response = await httpClient.post(
        loginUrl,
        headers: header(),
        body: {"email": email, "password": password},
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        print(responseString);
        userprefs.setBool("loginStatus", true);
        userprefs.setString("userInfos", responseString);
        userMap = jsonDecode(responseString);
        userprefs.setBool("isNewCheck", userMap['isNew']);
        return true;
      } else if (response.statusCode == 401) {
        print(response.statusCode);
        print(response.body);
        responseString = response.body;
        return false;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("login :: ${e.toString()}");
    }
    return null;
  }

  //this is for logOut APi where only header2 is working
  Future<bool> logOutPost() async {
    print("apiProvider logout");
    String logOutUrl =
        userMap["role"] == "admin" ? AppUrl.adminLogOutUrl : AppUrl.logoutUrl;
    try {
      final response = await httpClient.post(
        logOutUrl,
        headers: header2(),
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        return true;
      } else if (response.statusCode == 401) {
        GETX.Get.snackbar("Refresh Error", "Pls Uninstall the app");
        GETX.Get.offAllNamed(AppRoutes.LOGIN);
      } else {
        print(response.statusCode);
        print(response.body);
        return false;
        //Get.snackbar("Error", response.body);
      }
    } catch (e) {
      print("logOut ::: ${e.toString()}");
    }
    return null;
  }

//this is for AdminPCkages APi where title, price ,description,active and image are come from AdminPackages Controller
  Future<bool> adminPackagesPost(String title, String price, String description,
      String active, String durationDropDn, File image) async {
    print("apiProvider adminPackages");

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap(
        {
          "title": title,
          "price": price,
          "description": description,
          "active": active,
          "duration": durationDropDn,
          "image": await MultipartFile.fromFile(
            image.path,
          ),
        },
      );
      var response = await dio.post(
        AppUrl.adminPackagesUrl + "?_method=POST",
        data: formData,
        options: Options(
          headers: header2(),
        ),
      );
      if (response.statusCode == 200) {
        print("adminPackages  Done");
        print(response.data);
        return true;
      } else {
        print(response.statusCode);
        print(response.data);
        return false;
      }
    } catch (e) {
      print("Adminpackages ${e.toString()}");
    }
    return null;
  }

//this is for AdminPCkages APi where title, price ,description,active and image are come from AdminPackages Controller
  Future<bool> adminPackagesModifyPut(var id, String title, String price,
      String description, String active, var duration, File image) async {
    print("apiProvider adminPackagesModify Put");
    print(id);
    print(title);
    print(price);
    print(description);
    print(active);
    print(duration);
    print(image.path);

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap(
        image.path == "false"
            ? {
                "title": title,
                "price": price,
                "description": description,
                "active": active,
                "duration": duration
              }
            : {
                "title": title,
                "price": price,
                "description": description,
                "active": active,
                "duration": duration,
                "image": await MultipartFile.fromFile(
                  image.path,
                ),
              },
      );

      var response = await dio.post(
        AppUrl.adminPackagesUrl + "/$id?_method=PUT",
        data: formData,
        options: Options(
          headers: header2(),
        ),
      );
      if (response.statusCode == 200) {
        print("adminPackagesModify  Done");
        print(response.data);
        return true;
      } else {
        print(response.statusCode);
        print(response.data);
        return false;
      }
    } catch (e) {
      print("adminPackagesModify ${e.toString()}");
    }
    return null;
  }

  //UserHomePage  for user HomePage where user can see today video
  Future<UserHomePageModel> userHomePage() async {
    print("apiProvider userHomePage");
    print(userMap["access_token"]);
    try {
      http.Response response;
      response = await http.post(
        AppUrl.userHomePageUrl,
        headers: header2(),
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        return todayModelFromJson(responseString);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("userHomePage ::: ${e.toString()}");
    }
    return null;
  }

//this is for AdminVideo APi where title, price ,description, publish, startImg,endImg  and video are come from AdminVideo Controller
  Future<bool> adminVideoPost(
      String title,
      String price,
      String description,
      var packageId,
      String startImg,
      String endImg,
      String pubLish,
      File video) async {
    print("apiProvider adminVideo");
    print(packageId);
    print(startImg);
    print(video.path);
    print(pubLish);

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap(
        {
          "videoTitle": title,
          "day": price,
          "videoDescription": description,
          "package_id": packageId,
          "startingImage": startImg,
          "endinggImage": endImg,
          "publish": pubLish,
          "video": await MultipartFile.fromFile(
            video.path,
          ),
        },
      );
      var response = await dio.post(
        AppUrl.adminVideoUrl + "?_method=POST",
        data: formData,
        options: Options(
          headers: header2(),
        ),
      );
      if (response.statusCode == 200) {
        print("admin Video  Done");
        print(response.data);
        return true;
      } else {
        print(response.statusCode);
        print(response.data);
        return false;
      }
    } catch (e) {
      print("adminVideoPost ${e.toString()}");
    }
    return null;
  }

//this is for AdminVideoModify APi where title, price ,description, publish, startImg,endImg  and video are come from AdminVideo Controller
  Future<bool> adminVideoModifyPut(
      var id,
      String title,
      String price,
      String description,
      var packageId,
      String startImg,
      String endImg,
      String pubLish,
      File video) async {
    print("apiProvider adminVideoModify");
    print(packageId);
    print(startImg);
    print(video.path);
    print(pubLish);
    print(id);

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap(
        video.path == "false"
            ? {
                "videoTitle": title,
                "day": price,
                "videoDescription": description,
                "package_id": packageId,
                "startingImage": startImg,
                "endinggImage": endImg,
                "publish": pubLish,
              }
            : {
                "videoTitle": title,
                "day": price,
                "videoDescription": description,
                "package_id": packageId,
                "startingImage": startImg,
                "endinggImage": endImg,
                "publish": pubLish,
                "video": await MultipartFile.fromFile(
                  video.path,
                ),
              },
      );
      var response = await dio.post(
        AppUrl.adminVideoUrl + "/$id?_method=PUT",
        data: formData,
        options: Options(
          headers: header2(),
        ),
      );
      if (response.statusCode == 200) {
        print("admin VideoModify  Done");
        print(response.data);
        return true;
      } else {
        print(response.statusCode);
        print(response.data);
        return false;
      }
    } catch (e) {
      print("adminVideoModifyPut ${e.toString()}");
    }
    return null;
  }

  //Status is post by using this function
  Future<bool> statusPost(String status) async {
    try {
      final response = await httpClient.post(
        AppUrl.forumStatusUrl,
        headers: header3(),
        body: {
          "post": status,
        },
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        print("Done post in forum");
        responseString = response.body;
        print(responseString);
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("statusPost ::: ${e.toString()}");
    }
    return null;
  }

//Status is post by using this function
  Future<bool> replyPost(String reply, var forumId) async {
    try {
      final response = await httpClient.post(
        AppUrl.replyUrl,
        headers: header3(),
        body: {
          "forum_id": forumId.toString(),
          "reply": reply,
        },
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        print("Done reply in Comment");
        responseString = response.body;
        print(responseString);
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("replyPost ::: ${e.toString()}");
    }
    return null;
  }

  Future<bool> imgSent(
      var vidoeId, var packageId, var day, var check, File image) async {
    print("apiProvider imgSent");
    print("video :" + vidoeId.toString());
    print("pckage: " + packageId.toString());
    print("day " + day.toString());

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap(
        check == "start"
            ? {
                "video_id": vidoeId.toString(),
                "package_id": packageId.toString(),
                "day": day.toString(),
                "startingImage": await MultipartFile.fromFile(
                  image.path,
                ),
              }
            : {
                "video_id": vidoeId.toString(),
                "package_id": packageId.toString(),
                "day": day.toString(),
                "endingImage": await MultipartFile.fromFile(
                  image.path,
                ),
              },
      );
      var response = await dio.post(
        check == "start" ? AppUrl.startingImageUrl : AppUrl.endingImageUrl,
        data: formData,
        options: Options(
          headers: header4(),
        ),
      );
      if (response.statusCode == 200) {
        print("imgSent  Done");
        print(response.data);
        return true;
      } else {
        print(response.statusCode);
        print(response.data);
        return false;
      }
    } catch (e) {
      print("imgSent ${e.toString()}");
    }
    return null;
  }

  //Change Password  api Calling for both admin and User where value are come from ChangePassword Controller
  Future<bool> changePasswordPost(String oldPassword, String password) async {
    print("api Provider");
    print(oldPassword);
    print(password);
    try {
      final response = await httpClient.post(
        userMap["role"] == "user"
            ? AppUrl.changePasswordUserUrl
            : AppUrl.changePasswordAdminUrl,
        headers: header2(),
        body: {
          "old_password": oldPassword,
          "new_password": password,
          "confirm_new_password": password
        },
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        print("Done ChangePassword ");
        responseString = response.body;
        print(responseString);
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("changePasswordPost ::: ${e.toString()}");
    }
    return null;
  }

//AdnminPackages Delete  Api Calling
  deleteAdminPakages(var id) async {
    try {
      var response = await httpClient.delete(AppUrl.adminPackagesUrl + "/$id",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Admin Packages $id is Deleted");
        print(response.body);
        GETX.Get.snackbar("Delete", "Sucessfully Deleted the Packages",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        print(response.statusCode);
        print(response.body);
        GETX.Get.snackbar("Error", "Something is Happend",
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } catch (e) {
      print("deleteAdminPakages ::: ${e.toString()}");
    }
  }

  //AdnminPackages Delete  Api Calling
  deleteAdminVideo(var id) async {
    try {
      var response = await httpClient.delete(AppUrl.adminVideoUrl + "/$id",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Admin Video $id is Deleted");
        print(response.body);
        GETX.Get.snackbar("Delete", "Sucessfully Deleted the Video",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        print(response.statusCode);
        print(response.body);
        GETX.Get.snackbar("Error", "Something is Happend",
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } catch (e) {
      print("deleteAdminVideo ::: ${e.toString()}");
    }
  }

//Delete Forum Api Calling using there id which is controller from ForumController
  deleteForum(var id) async {
    try {
      var response = await httpClient.get(AppUrl.adminForumDeleteUrl + "/$id",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Forum $id is Deleted");
        print(response.body);
        GETX.Get.snackbar("Delete", "Sucessfully Deleted the Post",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        print(response.statusCode);
        print(response.body);
        GETX.Get.snackbar("Error", "Something is Happend",
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } catch (e) {
      print("deleteForum ::: ${e.toString()}");
    }
  }

  //Delete Comment Api Calling using there id which is controller from ForumController
  Future<bool> deleteComment(var id) async {
    print("reply id " + id.toString());
    try {
      var response = await httpClient.get(
          AppUrl.adminCommentDeleteUrl + "/${id.toString()}",
          headers: header2());
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Comment $id is Deleted");
        print(response.body);
        GETX.Get.snackbar("Delete", "Sucessfully Deleted the Comment",
            backgroundColor: Colors.green, colorText: Colors.white);
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
        GETX.Get.snackbar("Error", "Something is Happend",
            colorText: Colors.white, backgroundColor: Colors.red);
        return false;
      }
    } catch (e) {
      print("deleteComment ::: ${e.toString()}");
    }
    return null;
  }
}
