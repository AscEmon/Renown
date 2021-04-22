import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/AdminPackageController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
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
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            'Admin Packages',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.001, 0.6],
            colors: [Colors.black, Colors.grey[50]],
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
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Title : " +
                                        adminPackageController.adminPackagesList
                                            .value.result[index].title),
                                    CircleAvatar(
                                      radius: 30,
                                      child: Image.network(
                                        adminPackageController.adminPackagesList
                                            .value.result[index].image,
                                        height: 120,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Price : " +
                                        adminPackageController.adminPackagesList
                                            .value.result[index].price),
                                    Text("Active Status : " +
                                        adminPackageController.adminPackagesList
                                            .value.result[index].active),
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Description : \n" +
                                              adminPackageController
                                                  .adminPackagesList
                                                  .value
                                                  .result[index]
                                                  .description),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
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
    );
  }
}
