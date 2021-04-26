import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/AdminPackageController.dart';
import 'package:TrainnigInfo/Controller/AdminVideoController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminVideoPost extends StatefulWidget {
  AdminVideoPost({Key key}) : super(key: key);

  @override
  _AdminVideoPostState createState() => _AdminVideoPostState();
}

class _AdminVideoPostState extends State<AdminVideoPost> {
  final AdminVideoController _adminVideoController = Get.put(
      AdminVideoController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));
  final AdminPackageController _adminPackageController = Get.put(
      AdminPackageController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));

  var packagesSelect;

  String edit = Get.arguments[0];
  var id = Get.arguments[1];
  String title = Get.arguments[2];
  String day = Get.arguments[3];
  String description = Get.arguments[4];
  var packageId = Get.arguments[5];
  String startImg = Get.arguments[6];
  String endImg = Get.arguments[7];
  String publish = Get.arguments[8];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    edit == "edit"
        ? _adminVideoController.title.text = title
        : _adminVideoController.title.text = " ";
    edit == "edit"
        ? _adminVideoController.day.text = day
        : _adminVideoController.day.text = "";
    edit == "edit"
        ? _adminVideoController.description.text = description
        : _adminVideoController.description.text = "";
    edit == "edit"
        ? _adminVideoController.packagesSelect = packageId
        : print("nothing");
    edit == "edit"
        ? _adminVideoController.startingImageDropDn = startImg
        : print("nothing");
    edit == "edit"
        ? _adminVideoController.endingImageDropDn = endImg
        : print("nothing");
    edit == "edit"
        ? _adminVideoController.publishDropDn = publish
        : print("nothing");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _adminVideoController.startingImageDropDn = "";
        _adminVideoController.endingImageDropDn = "";
        _adminVideoController.publishDropDn = "";
        Get.back();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              centerTitle: true,
              title: Text(
                'Admin Video',
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
                stops: [0.30, 0.7],
                colors: [Colors.black38, Colors.blueGrey],
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
                      controller: _adminVideoController.title,
                      cursorColor: Colors.white,
                      focusNode: FocusNode(),
                      style: TextStyle(color: Colors.white),
                      decoration: new InputDecoration(
                        labelText: 'Video Title',
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
                      controller: _adminVideoController.day,
                      cursorColor: Colors.white,
                      focusNode: FocusNode(),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: new InputDecoration(
                        labelText: 'Day',
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
                      controller: _adminVideoController.description,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Video Description',
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
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () {
                        return _adminPackageController.isLoading.value == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 12,left: 16,right: 16),
                                child: Row(
                                  children: [
                                    Text("Select Package"),
                                  ],
                                ),
                              )
                            : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                    edit == "edit" ? packageId : "Select Package",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  items: _adminPackageController
                                      .adminPackagesList.value.result
                                      .map(
                                    (item) {
                                      return DropdownMenuItem(
                                        child: Text(item.title),
                                        value: edit == "edit"
                                            ? packageId.toString()
                                            : item.id.toString(),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (newVal) {
                                    setState(
                                      () {
                                        FocusScope.of(context).unfocus();
                                        packagesSelect = newVal;
                                        print(packagesSelect);
                                      },
                                    );
                                  },
                                  value: packagesSelect,
                                  underline: SizedBox(),
                                ),
                            );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      width: Get.width,
                      child: ListTile(
                        title: InkWell(
                          onTap: (){
                            _adminVideoController.temp();
                          },
                          child: Text(
                            "Starting Image",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        trailing: Container(
                          height: 20,
                          width: 100,
                          child: GetBuilder<AdminVideoController>(
                            builder: (adminVideoController) {
                              return DropdownButton(
                                isExpanded: true,
                                items:
                                    adminVideoController.dropDpwnShow.keys.map(
                                  (values) {
                                    return DropdownMenuItem(
                                      value: values,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Text(
                                          "${adminVideoController.dropDpwnShow[values]}",
                                          style: TextStyle(),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                value: adminVideoController.startingImageDropDn,
                                underline: SizedBox(),
                                onChanged: (valueSelectedByUser) {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                  });
                                  adminVideoController
                                      .onchangedDropDnStartingImage(
                                          valueSelectedByUser, context);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      width: Get.width,
                      child: ListTile(
                        leading: Text(
                          "Ending Image",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        trailing: Container(
                          height: 20,
                          width: 100,
                          child: GetBuilder<AdminVideoController>(
                            builder: (adminVideoController) {
                              return DropdownButton(
                                isExpanded: true,
                                items:
                                    adminVideoController.dropDpwnShow.keys.map(
                                  (values) {
                                    return DropdownMenuItem(
                                      value: values,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Text(
                                          "${adminVideoController.dropDpwnShow[values]}",
                                          style: TextStyle(),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                value: adminVideoController.endingImageDropDn,
                                underline: SizedBox(),
                                onChanged: (valueSelectedByUser) {
                                  adminVideoController
                                      .onchangedDropDnEndingImage(
                                          valueSelectedByUser, context);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      width: Get.width,
                      child: ListTile(
                        leading: Text(
                          "Publish the Video ?",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        trailing: Container(
                          height: 20,
                          width: 100,
                          child: GetBuilder<AdminVideoController>(
                            builder: (adminVideoController) {
                              return DropdownButton(
                                isExpanded: true,
                                items:
                                    adminVideoController.dropDpwnShow.keys.map(
                                  (values) {
                                    return DropdownMenuItem(
                                      value: values,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Text(
                                          "${adminVideoController.dropDpwnShow[values]}",
                                          style: TextStyle(),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                value: adminVideoController.publishDropDn,
                                underline: SizedBox(),
                                onChanged: (valueSelectedByUser) {
                                  adminVideoController.onchangedDropDnPulish(
                                      valueSelectedByUser, context);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<AdminVideoController>(
                      builder: (adminVideoController) {
                        return Container(
                          child: adminVideoController.videoFile == null
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
                                  child: Text(
                                    adminVideoController.videoFile.path
                                        .toString()
                                        .substring(43),
                                  ),
                                ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RaisedButton(
                          child: Text(
                            edit == "edit" ? "Modify Video" : "Pick Video",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _adminVideoController.videoFilePick();
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            edit == "edit" ? "Update Video" : "Post Video",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            edit == "edit"
                                ? _adminVideoController.sendModifyVideosPut(
                                    packagesSelect, id)
                                : _adminVideoController
                                    .sendVideos(packagesSelect);
                          },
                        ),
                      ],
                    ),
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
