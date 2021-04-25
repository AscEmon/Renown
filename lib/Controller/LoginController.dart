import 'package:TrainnigInfo/Views/Screens/LoginPage.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';

class LogInController extends GetxController {
  MyRepository repository;
  LogInController({@required this.repository});

  final TextEditingController emailLogin = new TextEditingController();
  final TextEditingController passwordLogin = new TextEditingController();
  Duration timerTastoPremuto;
  bool dialogShow;
  loginFunction(
    bool amdminCheck,
    GlobalKey<FormState> formKey,
  ) async {
    if (formKey.currentState.validate()) {
      print(emailLogin.text);
      print(passwordLogin.text);
      isInternet().then(
        (internet) async {
          if (internet == true) {
            dialogShowMethod(
              true,
            );
            await repository
                .loginPost(amdminCheck, emailLogin.text, passwordLogin.text)
                .then(
              (login) {
                if (login == true) {
                   Get.back(closeOverlays: true);
                  Get.offAndToNamed(AppRoutes.HOMEPAGE);
                  emailLogin.clear();
                  passwordLogin.clear();
                  adminCheck = false;
                } else {
                  Get.back(closeOverlays: true);
                  dialogShowMethod(false);
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
            title: "Loading....",
            content: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            ))
        : Get.defaultDialog(
            barrierDismissible: false,
            title: "Unauthorized",
            middleText: "Your Email and Password is not matching",
            confirmTextColor: Colors.white,
            buttonColor: Colors.black,
            onConfirm: (){
              Get.back();
            }
          );

    update();
  }

  // void checkValidity() {
  //   int _start = timerTastoPremuto.inMilliseconds;

  //   const oneDecimal = const Duration(milliseconds: 100);
  //   Timer _timer = new Timer.periodic(oneDecimal, (Timer timer) {
  //     if (_start < 100) {
  //       timer.cancel();
  //     } else {
  //       _start = _start - 100;
  //     }
  //   });
  // }
}
