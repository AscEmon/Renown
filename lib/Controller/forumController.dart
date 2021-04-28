import 'package:TrainnigInfo/Model/CommentModel.dart';
import 'package:TrainnigInfo/Model/ForumModel.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForumController extends GetxController {
  MyRepository repository;
  ForumController({@required this.repository});
  TextEditingController forumTextController = TextEditingController();
  TextEditingController replyTextController = TextEditingController();
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var forumList = ForumModel().obs;
  var commentList = CommentModel().obs;
  var id;
  @override
  void onInit() {
    // TODO: implement onInit
    forumTextController.clear();
    replyTextController.clear();
    isInternet().then(
      (internet) {
        if (internet == true) {
          fetchForumStatus();
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

  void fetchForumStatus() async {
    try {
      isLoading(true);
      var statuss = await repository.forumStatusGet();
      if (statuss != null) {
        forumList(statuss);
      }
    } finally {
      isLoading(false);
    }
  }

  statusPostFunction() async {
    if (forumTextController.text != null) {
      isInternet().then(
        (internet) async {
          if (internet == true) {
            dialogShowMethod(
              true,
            );
            await repository.statusPost(forumTextController.text).then(
              (stausPost) {
                if (stausPost == true) {
                  Get.back(closeOverlays: true, canPop: true);
                  dialogShowMethod(false);
                  fetchForumStatus();
                  Get.offAndToNamed(AppRoutes.FORUM);
                  forumTextController.clear();
                  update();
                } else {
                  Get.back(closeOverlays: true);
                  Get.snackbar("Error", "Something is Occured");
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
    } else {}
    update();
  }

  void commentGet(id) async {
    try {
      isLoading2(true);
      var comments = await repository.commentGet(id);
      if (comments != null) {
        commentList(comments);
      }
    } finally {
      isLoading2(false);
    }
  }

  replyPostFunction(var forumId) async {
    if (replyTextController.text != null) {
      isInternet().then(
        (internet) async {
          if (internet == true) {
            await repository.replyPost(replyTextController.text, forumId).then(
              (replyPost) {
                if (replyPost == true) {
                  replyTextController.text= "";
                  update();
                } else {
                  Get.snackbar("Error", "Something is Occured");
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
    } else {}
    update();
  }

  dialogShowMethod(dialogShow) {
    dialogShow == true
        ? Get.defaultDialog(
            barrierDismissible: false,
            title: "Loading....",
            content: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            ),
          )
        : Get.defaultDialog(
            barrierDismissible: false,
            title: "Status",
            middleText: "Your Status is Successfully Post",
            confirmTextColor: Colors.white,
            buttonColor: Colors.black,
            onConfirm: () {
              Get.back();
            },
          );

    update();
  }
}
