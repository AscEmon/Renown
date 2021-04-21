
import 'package:TrainnigInfo/Repository/MyRepository.dart';
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
  String name = "";
  String email = "";
  String password = "";
  
  signUpFunction(GlobalKey<FormState> formKey) async {
    if (formKey.currentState.validate()) {
      print(nameControllerSingUp.text);
      print(emailControllerSingUp.text);
      print(phoneControllerSingUp.text);
      print(passwordControllerSingUp.text);
      name = nameControllerSingUp.text;
      email = emailControllerSingUp.text;
      password = passwordControllerSingUp.text;
      await repository.signUpPost(name, email, password);
      nameControllerSingUp.clear();
      emailControllerSingUp.clear();
      phoneControllerSingUp.clear();
      passwordControllerSingUp.clear();
      confirmPasswordControllerSingUp.clear();
    }
    update();
  }
}
