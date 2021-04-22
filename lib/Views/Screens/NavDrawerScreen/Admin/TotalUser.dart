import 'package:TrainnigInfo/Controller/AdminDashBoardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalUser extends StatefulWidget {
  TotalUser({Key key}) : super(key: key);

  @override
  _TotalUserState createState() => _TotalUserState();
}

class _TotalUserState extends State<TotalUser> {
  final AdminDashBoardController _adminDashBoardController =
      Get.put(AdminDashBoardController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text(
              'Total User',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
               
                child: Obx(
                  () {
                    return _adminDashBoardController.isLoading2.value == true
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
                                    .adminTotalUserList.value.result.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Card(
                                      elevation: 8,
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
                                                    .adminTotalUserList
                                                    .value
                                                    .result[index]
                                                    .name
                                                    .toString(),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              _adminDashBoardController
                                                          .adminTotalUserList
                                                          .value
                                                          .result[index]
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
                                                        .adminTotalUserList
                                                        .value
                                                        .result[index]
                                                        .email
                                                        .toString(),
                                              ),
                                              Text(
                                                "Member Since : " +
                                                    _adminDashBoardController
                                                        .adminTotalUserList
                                                        .value
                                                        .result[index]
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
          ),
        ),
      ),
    );
  }
}
