import 'dart:io';
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/AdminController/AdminPackageController.dart';
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
  String edit = Get.arguments[0];
  String title = Get.arguments[1];
  String price = Get.arguments[2];
  String description = Get.arguments[3];
  var activeStatus = Get.arguments[4];
  String image = Get.arguments[5];
  var id = Get.arguments[6];
  var duration = Get.arguments[7];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    edit == "edit"
        ? adminPackageController.title.text = title
        : adminPackageController.title.text = " ";
    edit == "edit"
        ? adminPackageController.price.text = price
        : adminPackageController.price.text = "";
    edit == "edit"
        ? adminPackageController.description.text = description
        : adminPackageController.description.text = "";
    edit == "edit"
        ? adminPackageController.image.value = image
        : print("nothing");

    edit == "edit"
        ? adminPackageController.editActiveStatusbool.value = activeStatus
        : print("nothing");
    edit == "edit"
        ? adminPackageController.durationDropDn = duration
        : print("nothing");
  }

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
    return WillPopScope(
      onWillPop: () async {
        image = "";
        adminPackageController.profile = null;
        Get.back();
      },
      child: SafeArea(
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
                      keyboardType: TextInputType.number,
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
                            edit == "edit"
                                ? Obx(
                                    () {
                                      return Container(
                                        child: Switch(
                                          value: adminPackageController
                                                  .editActiveStatusbool.value ??
                                              false,
                                          onChanged: (value) {
                                            adminPackageController
                                                .onchangedEdit(value, context);
                                          },
                                          activeTrackColor: Color(0xff2ECC71),
                                          activeColor: Color(0xff2ECC71),
                                        ),
                                      );
                                    },
                                  )
                                : GetBuilder<AdminPackageController>(
                                    builder: (adminPackageController) {
                                      return Container(
                                        child: Switch(
                                          value:
                                              adminPackageController.active ??
                                                  false,
                                          onChanged: (value) {
                                            adminPackageController.onchanged(
                                                value, context);
                                          },
                                          activeTrackColor: Color(0xff2ECC71),
                                          activeColor: Color(0xff2ECC71),
                                        ),
                                      );
                                    },
                                  )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: Get.width,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Text(
                            "Duration",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Container(
                          height: 20,
                          width: 100,
                          child: GetBuilder<AdminPackageController>(
                            builder: (adminPackageController) {
                              return DropdownButton(
                                isExpanded: true,
                                items: adminPackageController.dropDpwnShow.keys
                                    .map(
                                  (values) {
                                    return DropdownMenuItem(
                                      value: values,
                                      child: Text(
                                        "${adminPackageController.dropDpwnShow[values]}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    );
                                  },
                                ).toList(),
                                value: adminPackageController.durationDropDn,
                                underline: SizedBox(),
                                onChanged: (valueSelectedByUser) {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                  });
                                  adminPackageController
                                      .onchangedDurationDropDn(
                                          valueSelectedByUser, context);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    GetBuilder<AdminPackageController>(
                      builder: (adminPackageController) {
                        return Row(
                          mainAxisAlignment: edit == "edit"
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.center,
                          children: [
                            Container(
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
                                        File(adminPackageController
                                            .profile.path),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            edit == "edit"
                                ? Card(
                                    elevation: 8,
                                    child: Image.network(
                                      image,
                                      height: 100,
                                      width: 100,
                                    ),
                                  )
                                : Text(""),
                          ],
                        );
                      },
                    ),
                    edit == "edit"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Update Image"),
                              Text("Package Image")
                            ],
                          )
                        : Text(""),
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
                            edit == "edit"
                                ? adminPackageController.sendModifyPackages(id)
                                : adminPackageController.sendPackages(context);
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
      ),
    );
  }
}
