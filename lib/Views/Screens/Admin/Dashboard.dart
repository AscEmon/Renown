import 'package:TrainnigInfo/Controller/AdminController/AdminDashBoardController.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final AdminDashBoardController _adminDashBoardController =
        Get.put(AdminDashBoardController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Dashboard",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[900],
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: Get.height / 6,
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () {
                              return _adminDashBoardController
                                          .isLoading.value ==
                                      true
                                  ? Text(" ")
                                  : Text(
                                      _adminDashBoardController
                                          .adminDashBoardList
                                          .value
                                          .data
                                          .totalPackage
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    );
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Total Packages",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () {
                              return _adminDashBoardController
                                          .isLoading.value ==
                                      true
                                  ? Text(" ")
                                  : Text(
                                      _adminDashBoardController
                                          .adminDashBoardList
                                          .value
                                          .data
                                          .totalVideo
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    );
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Total Video",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.TOTALUSER);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () {
                                return _adminDashBoardController
                                            .isLoading.value ==
                                        true
                                    ? Text(" ")
                                    : Text(
                                        _adminDashBoardController
                                            .adminDashBoardList
                                            .value
                                            .data
                                            .totalUser
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      );
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Total User",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    "Recent User",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: Get.height / 1.7,
                    width: Get.width,
                    child: Obx(
                      () {
                        return _adminDashBoardController.isLoading.value == true
                            ? Align(
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                                alignment: Alignment.topCenter,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  child: ListView.builder(
                                    itemCount: _adminDashBoardController
                                        .adminDashBoardList
                                        .value
                                        .data
                                        .recentUser
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6,
                                                right: 6,
                                                top: 10,
                                                bottom: 10),
                                            child: ListTile(
                                              title: Row(
                                                children: [
                                                  Text(
                                                    _adminDashBoardController
                                                        .adminDashBoardList
                                                        .value
                                                        .data
                                                        .recentUser[index]
                                                        .name
                                                        .toString(),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  _adminDashBoardController
                                                              .adminDashBoardList
                                                              .value
                                                              .data
                                                              .recentUser[index]
                                                              .status ==
                                                          "Active"
                                                      ? Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        )
                                                      : Text(" ")
                                                ],
                                              ),
                                              subtitle: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Email : " +
                                                        _adminDashBoardController
                                                            .adminDashBoardList
                                                            .value
                                                            .data
                                                            .recentUser[index]
                                                            .email
                                                            .toString(),
                                                  ),
                                                  Text(
                                                    "Member Since : " +
                                                        _adminDashBoardController
                                                            .adminDashBoardList
                                                            .value
                                                            .data
                                                            .recentUser[index]
                                                            .memberSince
                                                            .toString(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
