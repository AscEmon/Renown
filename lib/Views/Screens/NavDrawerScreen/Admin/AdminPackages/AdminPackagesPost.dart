import 'dart:io';
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/AdminPackageController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminPackages extends StatefulWidget {
  AdminPackages({Key key}) : super(key: key);

  @override
  _AdminPackagesState createState() => _AdminPackagesState();
}

class _AdminPackagesState extends State<AdminPackages> {
  final AdminPackageController adminPackageController = Get.put(
      AdminPackageController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      adminPackageController.imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    adminPackageController.imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text(
              'Admin Packages',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black),
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.01, 0.6],
              colors: [Colors.black, Colors.grey],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  TextFormField(
                    maxLines: 1,
                    controller: adminPackageController.title,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: new InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: adminPackageController.price,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: new InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    autofocus: false,
                    focusNode: FocusNode(),
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    controller: adminPackageController.description,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Active Packages",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          GetBuilder<AdminPackageController>(
                              builder: (adminPackageController) {
                            return Container(
                              child: Switch(
                                value: adminPackageController.active ?? false,
                                onChanged: (value) {
                                  adminPackageController.onchanged(
                                      value, context);
                                },
                                activeTrackColor: Color(0xff2ECC71),
                                activeColor: Color(0xff2ECC71),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<AdminPackageController>(
                    builder: (adminPackageController) {
                      return Container(
                        child: adminPackageController.profile == null
                            ? Container(
                                height: 100,
                                width: 100,
                                color: Colors.grey,
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              )
                            : Card(
                                elevation: 8,
                                child: Image.file(
                                  File(adminPackageController.profile.path),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RaisedButton(
                        child: Text(
                          "Pick Image",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          //await filePick();
                          _showPicker(context);
                        },
                      ),
                      RaisedButton(
                        child: Text(
                          "Send Packages",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          adminPackageController.sendPackages(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
