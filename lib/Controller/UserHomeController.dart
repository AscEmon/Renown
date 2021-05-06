import 'package:TrainnigInfo/Model/UserHomePageModel.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHomeController extends GetxController {
  MyRepository repository;
  UserHomeController({@required this.repository});
  var isLoading = true.obs;
  var userVideoList = UserHomePageModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    isInternet().then(
      (internet) {
        if (internet == true) {
          fetchTodayVideo();
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

    super.onInit();
  }

  void fetchTodayVideo() async {
    try {
      isLoading(true);
      var videos = await repository.userHomePage();
      if (videos != null) {
        userVideoList(videos);
      }
    } finally {
      isLoading(false);
    }
  }
}
