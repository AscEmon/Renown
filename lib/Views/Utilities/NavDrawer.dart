import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../main.dart';
import '../Widget/NavDrawerTile.dart';

class NavDrawer extends StatelessWidget {
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                color: Colors.black,
                height: Get.height * 0.2,
                width: Get.width,
                child: ListTile(
                    contentPadding:
                        EdgeInsets.only(top: 25, left: 16, bottom: 20),
                    leading: IconButton(
                      iconSize: 45,
                      onPressed: () {},
                      icon: Icon(
                        Icons.account_circle,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Abu Sayed",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "User",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ))),
            //this is for Vendor navigation  Drawer
            Container(
              child: Column(
                children: [
                  NavDrawerTile(
                    navIcon: Icons.preview,
                    navTitle: 'Previous Activity',
                    onNavPress: () {
                      // Get.toNamed(AppRoutes.TRANSFERHISTORY);
                    },
                  ),
                  NavDrawerTile(
                    navIcon: Icons.today,
                    navTitle: "Todays Activity",
                    onNavPress: () {
                      // Get.toNamed(AppRoutes.INVOICEPAGE);
                    },
                  ),
                  NavDrawerTile(
                    navIcon: Icons.grain,
                    navTitle: 'Packages',
                    onNavPress: () {
                      Get.toNamed(AppRoutes.PACKAGES);
                    },
                  ),
                  NavDrawerTile(
                    navIcon: Icons.chat,
                    navTitle: 'Live Chat',
                    onNavPress: () {
                      //Get.toNamed(AppRoutes.LIVECHAT);
                    },
                  ),
                  NavDrawerTile(
                    navIcon: Icons.admin_panel_settings,
                    navTitle: 'Admin',
                    onNavPress: () {
                      Get.toNamed(AppRoutes.DASHBOARD);
                    },
                  ),
                  NavDrawerTile(
                    navIcon: Icons.logout,
                    navTitle: 'Logout',
                    onNavPress: () async {
                      try {
                        Get.defaultDialog(
                            title: "Logout",
                            middleText: "Are you sure, You want to Logout?",
                            textConfirm: "yes",
                            textCancel: "No",
                            cancelTextColor: Colors.red,
                            buttonColor: Colors.green,
                            onConfirm: () async {
                              bool logout = await myRepository.logOutPost();
                              if (logout == true) {
                                print(userMap["data"]["email"]);
                                await prefss.remove("userInfo");
                                Get.offAndToNamed(AppRoutes.LOGIN);
                                print(userMap["data"]["email"]);
                              } else {}
                            },
                            onCancel: () {
                              Get.back();
                            });
                      } catch (e) {}
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
