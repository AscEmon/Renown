import 'dart:convert';
import 'dart:io';
import 'package:TrainnigInfo/Model/AdminDashboardModel.dart';
import 'package:TrainnigInfo/Model/AdminPackagesModel.dart';
import 'package:TrainnigInfo/Model/AdminVideoModel.dart';
import 'package:TrainnigInfo/Model/CommentModel.dart';
import 'package:TrainnigInfo/Model/ForumModel.dart';
import 'package:TrainnigInfo/Model/SingUpModel.dart';
import 'package:TrainnigInfo/Model/TotalUserModel.dart';
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
      var response = await httpClient.get(AppUrl.forumUrl, headers: header2());
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
      var response =
          await httpClient.get(AppUrl.commentUrl + "/$id", headers: header2());
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
        GETX.Get.offAndToNamed(AppRoutes.HOMEPAGE);
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
        print("working RefreshToken");
        await refreashTokenPost().then(
          (refresh) {
            if (refresh == true) {
              logOutPost();
            } else {
              // GETX.Get.offAndToNamed(AppRoutes.LOGIN);
              GETX.Get.snackbar("Refresh Erron", "Pls Uninstall the app ");
            }
          },
        );
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
      String active, File image) async {
    print("apiProvider adminPackages");

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap(
        {
          "title": title,
          "price": price,
          "description": description,
          "active": active,
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
      String description, String active, File image) async {
    print("apiProvider adminPackagesModify Put");
    print(id);
    print(title);
    print(price);
    print(description);
    print(active);
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
              }
            : {
                "title": title,
                "price": price,
                "description": description,
                "active": active,
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

  //RefreshToken After expiry in 1 hour it will be call from LoginController
  Future<bool> refreashTokenPost() async {
    print("apiProvider RefreshToken");
    print(userMap["access_token"]);
    try {
      http.Response response;
      response = await http.post(
        Uri.parse(AppUrl.adminRefreshTokenUrl),
        headers: header2(),
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        print(responseString);
        userprefs.setString("userInfos", responseString);
        userMap = jsonDecode(responseString);
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("RefreshToken ::: ${e.toString()}");
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

//User Subscription Api is calling which is come from UserSubsCription Controller
  Future<bool> userSubscription(var amonut, var pId, var uId) async {
    print("apiProvider userSubscription");
    print(userMap["access_token"]);
    try {
      final response = await httpClient.post(
        AppUrl.userSubscriptionUrl,
        headers: header2(),
        body: {"amount": amonut, "package_id ": pId, "auth_id": uId},
      );
      print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      String responseString;
      if (response.statusCode == 200) {
        responseString = response.body;
        print(responseString);
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("userSubscription ::: ${e.toString()}");
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
}
