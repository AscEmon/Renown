import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Model/UserPackagesModel.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:flutter/material.dart';
import '../Repository/MyRepository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

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

  sendSubscription(var amount, var pId, var uId) {
    isInternet().then(
      (internet) async {
        if (internet == true) {
          await repository.userSubscriptionPost(amount, pId, uId);
        } else {
          Get.defaultDialog(
            title: "Internet Problem",
            content: Image.asset(
              "images/NoInternet_ic.png",
            ),
            buttonColor: Colors.black,
            onConfirm: () {
              Get.back();
            },
          );
        }
      },
    );
  }
}
