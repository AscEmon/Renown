import 'dart:io';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PictureTakeController extends GetxController {
  PictureTakeController({@required this.repository});
  MyRepository repository;
  PickedFile imageProfile;
  Image profileImage;
  ImagePicker _picker = ImagePicker();
  File profile;

  imgFromCamera() async {
    imageProfile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    try {
      if (imageProfile != null) {
        profile = File(imageProfile.path);
        print(File(profile.path));
      }
    } catch (e) {
      return null;
    }
    update();
  }

  imgFromGallery() async {
    imageProfile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    try {
      if (imageProfile != null) {
        profile = File(imageProfile.path);

        print(File(profile.path));
      }
    } catch (e) {
      return null;
    }

    update();
  }

  sendImg() {}

  void sendImage(
    var vidoeId,
    var packageId,
    var day,
    var check
  ) async {
    if (profile != null) {
      isInternet().then(
        (internet) async {
          if (internet == true) {
            print("Controller");
            print(vidoeId);
            print(packageId);
            print(day);
            print(profile.path);
            bool packgesPost = await repository.imgSentPost(
                vidoeId, packageId, day, check,File(profile.path));
            if (packgesPost == true) {
              Get.snackbar("Upload", "Image Post Successfully",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white);
              profile = null;
              //Get.offAndToNamed(AppRoutes.TODAYSACTIVITY);
              update();
            } else {
              Get.snackbar("Error", "Please Check All the field Properly",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
            }
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
    } else {
      Get.defaultDialog(
        title: "Alert",
        textConfirm: "yes",
        buttonColor: Colors.black,
        middleText: "Picture is Required",
        onConfirm: () {
          Get.back();
        },
      );
    }

    update();
  }
}
