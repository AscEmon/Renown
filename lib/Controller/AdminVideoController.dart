import 'dart:io';
import 'package:TrainnigInfo/Model/AdminVideoModel.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminVideoController extends GetxController {
  AdminVideoController({@required this.repository});
  var isLoading = true.obs;
  var videoList = AdminVideoModel().obs;
  MyRepository repository;
  TextEditingController title = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController description = TextEditingController();
  List<PlatformFile> filePick;
  File videoFile;
  String videoFileName;
  String startingImageDropDn;
  String endingImageDropDn;
  String publishDropDn;
  var packagesSelect;
  bool dialogShow;
  Map dropDpwnShow = {
    "": "",
    'yes': 'Yes',
    'no': 'No',
  };

  @override
  void onInit() {
    // TODO: implement onInit
    isInternet().then(
      (internet) {
        if (internet == true) {
          fetchAdminVideo();
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

  void fetchAdminVideo() async {
    try {
      isLoading(true);
      var videos = await repository.getAdminVideo();
      if (videos != null) {
        videoList(videos);
      }
    } finally {
      isLoading(false);
    }
  }

  //statring Image Drop Down on changed Method
  onchangedDropDnStartingImage(startingImag, BuildContext context) {
    FocusScope.of(context).unfocus();
    startingImageDropDn = startingImag;
    print(startingImageDropDn);
    update();
  }

  //ending Image Drop Down on changed Method
  onchangedDropDnEndingImage(var valueSelectedByUser, BuildContext context) {
    FocusScope.of(context).unfocus();
    endingImageDropDn = valueSelectedByUser;
    print(endingImageDropDn);
    update();
  }

  //Publish Drop Down on changed Method
  onchangedDropDnPulish(var valueSelectedByUser, BuildContext context) {
    FocusScope.of(context).unfocus();
    publishDropDn = valueSelectedByUser;
    print(publishDropDn);
    update();
  }

  temp() async {
    await repository.refreshTokenPost();
  }

  videoFilePick() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    if (result != null) {
      print("results");
      filePick = result.files.toList();
      videoFile = File(filePick[0].path);
      videoFileName = filePick[0].name;
      print(File(filePick[0].path));
      //  files = result.paths.map((path) => File(path)).toList();

    } else {
      // User canceled the picker
    }
    update();
  }

  //Delete the AdminVideo using there id
  deleteAdminVideo(var id) async {
    await repository.deleteAdminVideo(id);
    update();
  }

  //send all the file and text in there to repository
  void sendVideos(packagesSelect) async {
    if (title.text.isNotEmpty &&
        day.text.isNotEmpty &&
        description.text.isNotEmpty &&
        packagesSelect != null &&
        startingImageDropDn.isNotEmpty &&
        endingImageDropDn.isNotEmpty &&
        publishDropDn.isNotEmpty &&
        videoFile != null) {
      isInternet().then(
        (internet) async {
          if (internet == true) {
            dialogShowMethod(false);
            await repository
                .adminVideoPost(
                    title.text,
                    day.text,
                    description.text,
                    packagesSelect,
                    startingImageDropDn,
                    endingImageDropDn,
                    publishDropDn,
                    File(videoFile.path))
                .then(
              (videoPost) {
                if (videoPost == true) {
                  Get.back(closeOverlays: true);
                  dialogShowMethod(true);
                  title.clear();
                  day.clear();
                  description.clear();
                  startingImageDropDn = "";
                  endingImageDropDn = "";
                  publishDropDn = "";
                  packagesSelect = null;
                  videoFile = null;
                } else {
                  Get.snackbar("Error", "Please Check All the field Properly",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                }
              },
            );
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

  //send all the file and text in there to repository
  void sendModifyVideosPut(packagesSelect, var id) async {
    isInternet().then(
      (internet) async {
        if (internet == true) {
          dialogShowMethod(false);
          await repository
              .adminVideoModifyPut(
            id,
            title.text,
            day.text,
            description.text,
            packagesSelect,
            startingImageDropDn,
            endingImageDropDn,
            publishDropDn,
            videoFile == null ? File("false") : File(videoFile.path),
          )
              .then(
            (videoPost) {
              if (videoPost == true) {
                Get.back(closeOverlays: true);
                dialogShowMethod(true);
                id = "";
                title.clear();
                day.clear();
                description.clear();
                startingImageDropDn = "";
                endingImageDropDn = "";
                publishDropDn = "";
                packagesSelect = null;
                videoFile = null;
              } else {
                Get.snackbar("Error", "Please Check All the field Properly",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
              }
            },
          );
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
    update();
  }

  dialogShowMethod(dialogShow) {
    dialogShow == false
        ? Get.defaultDialog(
            barrierDismissible: false,
            title: "Loading....",
            content: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            ))
        : Get.defaultDialog(
            barrierDismissible: false,
            title: "Video Upload",
            middleText: "Video is Posted Successfully",
            confirmTextColor: Colors.white,
            buttonColor: Colors.black,
            onConfirm: () {
              Get.back();
            });

    update();
  }
}
