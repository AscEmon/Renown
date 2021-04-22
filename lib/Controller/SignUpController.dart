import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  MyRepository repository;
  SignUpController({@required this.repository});

  final TextEditingController nameControllerSingUp =
      new TextEditingController();
  final TextEditingController emailControllerSingUp =
      new TextEditingController();
  final TextEditingController phoneControllerSingUp =
      new TextEditingController();
  final TextEditingController passwordControllerSingUp =
      new TextEditingController();
  final TextEditingController confirmPasswordControllerSingUp =
      new TextEditingController();

  signUpFunction(GlobalKey<FormState> formKey) async {
    if (formKey.currentState.validate()) {
      print(nameControllerSingUp.text);
      print(emailControllerSingUp.text);
      print(phoneControllerSingUp.text);
      print(passwordControllerSingUp.text);
      isInternet().then(
        (internet) async {
          if (internet == true) {
            await repository.signUpPost(nameControllerSingUp.text,
                emailControllerSingUp.text, passwordControllerSingUp.text);
            nameControllerSingUp.clear();
            emailControllerSingUp.clear();
            phoneControllerSingUp.clear();
            passwordControllerSingUp.clear();
            confirmPasswordControllerSingUp.clear();
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
