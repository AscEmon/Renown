import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/AdminPackageController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminPackagesGet extends StatefulWidget {
  AdminPackagesGet({Key key}) : super(key: key);

  @override
  _AdminPackagesGetState createState() => _AdminPackagesGetState();
}

class _AdminPackagesGetState extends State<AdminPackagesGet> {
  final AdminPackageController adminPackageController = Get.put(
      AdminPackageController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.ADMINPACKAGES, arguments: [
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                  ]);
                },
                child: Icon(
                  Icons.add_moderator,
                  color: Colors.white,
                )),
            SizedBox(
              width: 20,
            ),
          ],
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            'Admin Packages',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black),
      body: RefreshIndicator(
        backgroundColor: Colors.black,
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            adminPackageController.fetchAdminPackages();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.001, 0.6],
              colors: [Colors.black, Colors.grey[600]],
            ),
          ),
          child: Obx(
            () {
              return adminPackageController.isLoading.value == true
                  ? Align(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                      alignment: Alignment.topCenter,
                    )
                  : Container(
                      child: ListView.builder(
                        itemCount: adminPackageController
                            .adminPackagesList.value.result.length,
                        itemBuilder: (context, index) {
                          var id = adminPackageController
                              .adminPackagesList.value.result[index].id;
                          String title = adminPackageController
                              .adminPackagesList.value.result[index].title;
                          String price = adminPackageController
                              .adminPackagesList.value.result[index].price;
                          String description = adminPackageController
                              .adminPackagesList
                              .value
                              .result[index]
                              .description;
                          String image = adminPackageController
                              .adminPackagesList.value.result[index].image;
                          bool activeStatus = adminPackageController
                                      .adminPackagesList
                                      .value
                                      .result[index]
                                      .active ==
                                  "yes"
                              ? true
                              : false;
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    child: Image.network(
                                      adminPackageController.adminPackagesList
                                          .value.result[index].image,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          adminPackageController
                                              .adminPackagesList
                                              .value
                                              .result[index]
                                              .title,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.ADMINPACKAGES,
                                              arguments: [
                                                "edit",
                                                title,
                                                price,
                                                description,
                                                activeStatus,
                                                image,
                                                id
                                              ],
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.defaultDialog(
                                            title: "Delete Package",
                                            middleText:
                                                "Are you sure, You want to Delete this Package",
                                            buttonColor: Colors.red,
                                            cancelTextColor: Colors.black,
                                            onCancel: () {},
                                            onConfirm: () {
                                              adminPackageController
                                                  .deleteAdminPackages(id);
                                              Get.back();
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Status",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          GetBuilder<AdminPackageController>(
                                            builder: (adminPackageController) {
                                              return Container(
                                                child: Switch(
                                                  value: activeStatus ?? false,
                                                  onChanged: (value) {
                                                    activeStatus = value;
                                                    adminPackageController
                                                        .onchangedStatusUpdate(
                                                            activeStatus,
                                                            index,
                                                            id);
                                                  },
                                                  activeTrackColor:
                                                      Color(0xff2ECC71),
                                                  activeColor:
                                                      Color(0xff2ECC71),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                      SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Price : " +
                                                  adminPackageController
                                                      .adminPackagesList
                                                      .value
                                                      .result[index]
                                                      .price,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              "Description : \n" +
                                                  adminPackageController
                                                      .adminPackagesList
                                                      .value
                                                      .result[index]
                                                      .description,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
