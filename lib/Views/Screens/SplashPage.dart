import 'dart:async';
import 'package:TrainnigInfo/Controller/LoginController.dart';
import 'package:TrainnigInfo/Controller/SignUpController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 3000);
    Timer(_duration, navigationPage);
    SignUpController signUpController = Get.put(SignUpController(),permanent:true);
    LogInController logInController = Get.put(LogInController(),permanent:true);
  }

  void navigationPage() async {
    try {
      Get.offAndToNamed(AppRoutes.LOGIN);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/splashImage.png',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 120,
            left: Get.width/2-100,
            child: Text("Trainning Info",style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
