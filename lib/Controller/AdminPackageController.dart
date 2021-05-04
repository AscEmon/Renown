import 'dart:io';
import 'package:TrainnigInfo/Model/AdminPackagesModel.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminPackageController extends GetxController {
  AdminPackageController({@required this.repository});
  MyRepository repository;
  PickedFile imageProfile;
  Image profileImage;
  ImagePicker _picker = ImagePicker();
  File profile;
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  bool active;
  bool activeStatus;
  String activeText = "no";
  var image = "".obs;
  var editActiveStatusbool = false.obs;
  var editActiveStatus = "".obs;

  var isLoading = true.obs;
  var adminPackagesList = AdminPackagesModel().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    isInternet().then(
      (internet) {
        if (internet == true) {
          fetchAdminPackages();
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

  void fetchAdminPackages() async {
    try {
      isLoading(true);
      var adminPakages = await repository.getAdminPackages();
      if (adminPakages != null) {
        adminPackagesList(adminPakages);
      }
    } finally {
      isLoading(false);
    }
  }

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

  // this is for AdminPackages Post
  onchanged(bool value, BuildContext context) {
    FocusScope.of(context).unfocus();
    active = value;
    active == true ? activeText = "yes" : activeText = "no";
    print(activeText);
    update();
  }

  // this is for editonChanged Switch
  onchangedEdit(bool value, BuildContext context) {
    FocusScope.of(context).unfocus();
    editActiveStatusbool.value = value;
    editActiveStatusbool.value == true
        ? editActiveStatus.value = "yes"
        : editActiveStatus.value = "no";
    print(editActiveStatusbool.value);
  }

  // this is for AdminPackages Get where admin can change the status from list of Packages
  onchangedStatusUpdate(bool value, int index, var id) async {
    activeStatus = value;
    activeStatus == true ? activeText = "yes" : activeText = "no";
    await repository.statusUpdateAdminPackages(id);
    print(activeText);
    update();
  }

//Delete the AdminPackages using there id
  deleteAdminPackages(var id) async {
    await repository.deleteAdminPackages(id);
    update();
  }

  void sendPackages(BuildContext context) async {
    if (title.text.isNotEmpty &&
        price.text.isNotEmpty &&
        description.text.isNotEmpty &&
        activeText.isNotEmpty &&
        profile != null) {
      isInternet().then(
        (internet) async {
          if (internet == true) {
            bool packgesPost = await repository.adminPackages(title.text,
                price.text, description.text, activeText, File(profile.path));
            if (packgesPost == true) {
              Get.snackbar("Packages", "Packages Post Successfully",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white);
              title.clear();
              price.clear();
              description.clear();
              active = false;
              profile = null;
              activeText = "";
              FocusScope.of(context).unfocus();
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
        middleText: "All the field must be required",
        onConfirm: () {
          Get.back();
        },
      );
    }

    update();
  }

  sendModifyPackages(var id) {
    isInternet().then(
      (internet) async {
        if (internet == true) {
          editActiveStatusbool.value == true
              ? editActiveStatus.value = "yes"
              : editActiveStatus.value = "no";
          print(title.text);
          print(price.text);
          print(description.text);
          print(editActiveStatus.value);
          profile == null ? print(image) : print(File(profile.path));
          print(id);
          bool packgesPost = await repository.adminPackagesModifyPut(
            id,
            title.text,
            price.text,
            description.text,
            editActiveStatus.value,
            profile == null ? File("false") : File(profile.path),
          );
          if (packgesPost == true) {
            Get.snackbar("Packages Modify", "Packages Modify Successfully",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white);
          } else {
            print("Error ");
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
  }
}
