import 'package:TrainnigInfo/Views/Screens/LoginPage.dart';
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

  loginFunction(bool amdminCheck, GlobalKey<FormState> formKey) async {
    if (formKey.currentState.validate()) {
      print(emailLogin.text);
      print(passwordLogin.text);
      isInternet().then(
        (internet) async {
          if (internet == true) {
            var now = DateTime.now();
            // checkValidity();
            print("This is Current Time " + now.second.toString());
            await repository.loginPost(
                amdminCheck, emailLogin.text, passwordLogin.text);
            emailLogin.clear();
            passwordLogin.clear();
            adminCheck = false;

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
