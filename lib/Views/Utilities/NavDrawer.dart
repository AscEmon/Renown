import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:TrainnigInfo/main.dart';
import 'package:TrainnigInfo/Views/Widget/NavDrawerTile.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              height: Get.height * 0.2,
              width: Get.width,
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 25, left: 16, bottom: 20),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "${userMap["data"]["name"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "${userMap["data"]["email"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
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
                      userprefs.clear();
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
                          cancelTextColor: Colors.black,
                          buttonColor: Colors.black,
                          onConfirm: () async {
                            bool logout = await myRepository.logOutPost();
                            if (logout == true) {
                             await signOut();
                            }
                          },
                          onCancel: () {
                            Get.back();
                          },
                        );
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

  signOut() {
    try {
      userprefs.clear();
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      print(e.toString());
    }
  }
}
