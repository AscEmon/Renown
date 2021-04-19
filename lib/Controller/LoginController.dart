import 'package:TrainnigInfo/Controller/checkController.dart';
import 'package:TrainnigInfo/Views/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';

class LogInController extends GetxController {
  MyRepository repository;
  LogInController({@required this.repository});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailLogin = new TextEditingController();
  final TextEditingController passwordLogin = new TextEditingController();

  loginFunction(bool amdminCheck) async {
    if (formKey.currentState.validate()) {
      print(emailLogin.text);
      print(passwordLogin.text);
      await repository.loginPost(amdminCheck,emailLogin.text, passwordLogin.text);
      emailLogin.clear();
      passwordLogin.clear();
    } else {}
    update();
  }

}
