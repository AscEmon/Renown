import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  MyRepository repository;
  ChangePasswordController({@required this.repository});

  final TextEditingController oldPasswordController =
      new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController =
      new TextEditingController();

  changePasswordFunction(GlobalKey<FormState> formKey) async {
    if (formKey.currentState.validate()) {
      print(oldPasswordController.text);
      print(passwordController.text);
      print(confirmPasswordController.text);
      isInternet().then(
        (internet) async {
          if (internet == true) {
            await repository
                .changePasswordPost(
                    oldPasswordController.text, passwordController.text)
                .then(
              (passwordChange) {
                if (passwordChange == true) {
                  Get.snackbar(
                      "Password Change", "Your password is Change Successfully",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white);
                  oldPasswordController.clear();
                  passwordController.clear();
                  confirmPasswordController.clear();

                  update();
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
    }
    update();
  }
}
