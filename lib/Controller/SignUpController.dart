import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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



  signUpFunction()async
  {
    if(formKey.currentState.validate())
    {
      print(nameControllerSingUp.text);
      print(emailControllerSingUp.text);
      print(phoneControllerSingUp.text);
      print(passwordControllerSingUp.text);
      nameControllerSingUp.clear();
      emailControllerSingUp.clear();
      phoneControllerSingUp.clear();
      passwordControllerSingUp.clear();
      confirmPasswordControllerSingUp.clear();
    }
    update();
  }

  

}