import 'dart:io';
import '../ApiProvider/ApiProvider.dart';
import 'package:meta/meta.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({@required this.apiClient}) : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
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

  adminPackagesModifyPut(var id, String title, String price, String description,
      String active, File image) {
    return apiClient.adminPackagesModifyPut(
        id, title, price, description, active, image);
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

  refreshTokenPost() {
    return apiClient.refreashTokenPost();
  }

  adminPackages(String title, String price, String description, String active,
      File image) {
    return apiClient.adminPackagesPost(
        title, price, description, active, image);
  }

  deleteAdminPackages(var id) {
    return apiClient.deleteAdminPakages(id);
  }
   deleteAdminVideo(var id) {
    return apiClient.deleteAdminVideo(id);
  }
}
