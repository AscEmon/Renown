import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

Widget webAppbar(String textShow, InAppWebViewController _webViewController) {
  return AppBar(
    backgroundColor: Colors.black,
    title: Text(textShow,style: TextStyle(color: Colors.white),),
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        if (_webViewController != null) {
          print("print Pressed");
          _webViewController.canGoBack().then((value) {
            if (value) {
              _webViewController.goBack();
            } else {
              Get.back();
            }
          });
        }
      },
    ),
  );
}
