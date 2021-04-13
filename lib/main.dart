import 'package:flutter/material.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:get/get.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppRoutes.AppRoutesList(),
      title: 'Trainning Info',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        accentColor: Colors.white,
        backgroundColor: Colors.white,
      ),
    );
  }
}

