import 'dart:io';
import '../ApiProvider/ApiProvider.dart';
import 'package:meta/meta.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({@required this.apiClient}) : assert(apiClient != null);

  getUserPackages() {
    return apiClient.getUserPackages();
  }

  getAdminPackages() {
    return apiClient.getAdminPakages();
  }

  getAdminDashBoard() {
    return apiClient.getAdminDashBoard();
  }

  getTotalUser() {
    return apiClient.getTotalUser();
  }

  getAdminVideo() {
    return apiClient.adminVideoGet();
  }

  forumStatusGet() {
    return apiClient.statusGet();
  }

  commentGet(var id) {
    return apiClient.commentGet(id);
  }

  deleteForum(var id) {
    return apiClient.deleteForum(id);
  }

  deleteComment(var id) {
    return apiClient.deleteComment(id);
  }

  adminPackagesModifyPut(var id, String title, String price, String description,
      String active, var duration, File image) {
    return apiClient.adminPackagesModifyPut(
        id, title, price, description, active, duration, image);
  }

  statusUpdateAdminPackages(var id) {
    return apiClient.statusUpdateAdminPackages(id);
  }

  signUpPost(String name, String email, String password) {
    print(name);
    return apiClient.signUpPost(name, email, password);
  }

  loginPost(var adminCheck, String email, String password) {
    print(adminCheck);
    return apiClient.loginPost(adminCheck, email, password);
  }

  logOutPost() {
    return apiClient.logOutPost();
  }

  changePasswordPost(String oldPassword, String password) {
    print(oldPassword);
    return apiClient.changePasswordPost(oldPassword, password);
  }

  adminVideoPost(String title, String price, String description, var packageId,
      String startImg, String endImg, String pubLish, File video) {
    return apiClient.adminVideoPost(
        title, price, description, packageId, startImg, endImg, pubLish, video);
  }

  adminVideoModifyPut(
      var id,
      String title,
      String price,
      String description,
      var packageId,
      String startImg,
      String endImg,
      String pubLish,
      File video) {
    return apiClient.adminVideoModifyPut(id, title, price, description,
        packageId, startImg, endImg, pubLish, video);
  }

  userHomePage() {
    return apiClient.userHomePage();
  }

  previousActivity() {
    return apiClient.previousActivityGet();
  }

  statusPost(String status) {
    return apiClient.statusPost(status);
  }

  replyPost(String reply, var id) {
    return apiClient.replyPost(reply, id.toString());
  }

  imgSentPost(var vidoeId, var packageId, var day, var check, File image) {
    return apiClient.imgSent(vidoeId, packageId, day, check, image);
  }

  adminPackages(String title, String price, String description, String active,
      String durationDropDn, File image) {
    return apiClient.adminPackagesPost(
        title, price, description, active, durationDropDn, image);
  }

  deleteAdminPackages(var id) {
    return apiClient.deleteAdminPakages(id);
  }

  deleteAdminVideo(var id) {
    return apiClient.deleteAdminVideo(id);
  }
}
