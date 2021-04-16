import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widget/NavDrawerTile.dart';

class NavDrawer extends StatelessWidget {
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
                      // Get.toNamed(AppRoutes.FAVOURITE);
                    },
                  ),
                  NavDrawerTile(
                    navIcon: Icons.logout,
                    navTitle: 'Logout',
                    onNavPress: () async {
                      // try {
                      //   Get.defaultDialog(
                      //       title: "Logout",
                      //       middleText: "Are you sure, You want to Logout?",
                      //       onConfirm: () async {},
                      //       onCancel: () {
                      //         Get.back();
                      //       });
                      // } catch (e) {}
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
