import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefss;
//This is store value of userSharedPreferences
String user = prefss.getString("userInfo");
Map<String, dynamic> userMap = jsonDecode(user);
// print("${userMap["data"]["email"]}");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefss = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppRoutes.AppRoutesList(),
      title: 'Trainning',
      theme: ThemeData(
        toggleableActiveColor: Colors.green,
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        accentColor: Colors.white,
        backgroundColor: Colors.white,
      ),
    );
  }
}
