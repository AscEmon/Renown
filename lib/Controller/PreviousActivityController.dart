import 'package:TrainnigInfo/Model/PreeviousActivity.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviousActivityController extends GetxController {
  MyRepository repository;
  PreviousActivityController({@required this.repository});
  var isLoading = true.obs;
  var previousActivityList = PreviousActivityModel().obs;
  var list = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    isInternet().then(
      (internet) {
        if (internet == true) {
          fetchPreviousVideo();
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

  void fetchPreviousVideo() async {
    try {
      isLoading(true);
      var previousVideo = await repository.previousActivity();
      if (previousVideo != null) {
        previousActivityList(previousVideo);
        // previousActivityList.value.data.history.forEach(
        //   (String key, dynamic value) {
        //     list.add(
        //       {key: value},
        //     );
        //   },
        // );
        
      }
    } finally {
      isLoading(false);
    }
  }
}
