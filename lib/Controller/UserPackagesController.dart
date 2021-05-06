
import'package:TrainnigInfo/Model/UserPackagesModel.dart';
import 'package:flutter/material.dart';
import '../Repository/MyRepository.dart';
import 'package:get/get.dart';

class UserPackagesController extends GetxController {
  UserPackagesController({@required this.repository});
  MyRepository repository;

  var isLoading = true.obs;
  var packagesList = UserPackagesModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchPackages();
    super.onInit();
  }

  void fetchPackages() async {
    try {
      isLoading(true);
      var packages = await repository.getUserPackages();
      if (packages != null) {
        packagesList(packages);
      }
    } finally {
      isLoading(false);
    }
  }

  
}
