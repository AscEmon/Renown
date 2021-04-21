import 'dart:io';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminPackageController extends GetxController {
  AdminPackageController({@required this.repository});
  PickedFile imageProfile;
  Image profileImage;
  ImagePicker _picker = ImagePicker();
  File profile;
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  bool active;
  String activeText = "no";
  MyRepository repository;

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

  onchanged(bool value, BuildContext context) {
    FocusScope.of(context).unfocus();
    active = value;
    active == true ? activeText = "yes" : activeText = "no";
    print(activeText);
    update();
  }

  void sendPackages() async {
    if (title.text.isNotEmpty &&
        price.text.isNotEmpty &&
        description.text.isNotEmpty &&
        activeText.isNotEmpty &&
        profile != null) {
      bool packgesPost = await repository.adminPackages(title.text, price.text,
          description.text, activeText, File(profile.path));
      if (packgesPost == true) {
        Get.snackbar("Packages", "Pakcages Post Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Something is Happend",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
      title.clear();
      price.clear();
      description.clear();
      active = false;
      profile = null;
      activeText = "";
    } else {
      Get.defaultDialog(
        title: "Alert",
         textConfirm: "yes",
         buttonColor: Colors.black,
        middleText: "All the field must be required",
        onConfirm: () {
          Get.back();
        },
      );
    }

    update();
  }
}
