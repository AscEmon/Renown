import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Model/AdminModel/TotalUserModel.dart';
import 'package:TrainnigInfo/Views/Utilities/Check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:TrainnigInfo/Model/AdminModel/AdminDashboardModel.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';



class AdminDashBoardController extends GetxController {
  final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
   var isLoading2 = true.obs;
  var adminDashBoardList = AdminDashBoardModel().obs;
  var adminTotalUserList = TotalUserModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    isInternet().then(
      (internet) {
        if (internet == true) {
          fetchAdminDashBoard();
          fetchTotalUser();
          
        } else {
          Get.defaultDialog(
            title: "Internet Problem",
            content: Image.asset(
              "images/NoInternet_ic.png",
            ),
            buttonColor: Colors.black,
            onConfirm: () {
              Get.back();
            },
          );
        }
      },
    );

    super.onInit();
  }

  void fetchAdminDashBoard() async {
    try {
      isLoading(true);
      var adminDashboards = await repository.getAdminDashBoard();
      if (adminDashboards != null) {
        adminDashBoardList(adminDashboards);
      }
    } finally {
      isLoading(false);
    }
  }


  void fetchTotalUser() async {
    try {
      isLoading2(true);
      var adminTotalUsers = await repository.getTotalUser();
      if (adminTotalUsers != null) {
        adminTotalUserList(adminTotalUsers);
      }
    } finally {
      isLoading2(false);
    }
  }
}
