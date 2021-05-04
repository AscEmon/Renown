import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/AdminVideoController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/Views/Utilities/NavDrawer.dart';
import 'package:TrainnigInfo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../Widget/VideoItem.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Duration timerTastoPremuto;
  final AdminVideoController adminVideoController = Get.put(
      AdminVideoController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Timer.periodic(
    //   Duration(seconds: 10),
    //   (Timer timer) {
    //     print("hey bro");
    //     print(timer);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Renown",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.forum),
              onPressed: () {
                print(userMap["data"]["email"]);
                print(userMap["access_token"]);
                Get.toNamed(AppRoutes.FORUM);
              },
            )
          ],
        ),
        floatingActionButton: userMap["role"] == "admin"
            ? InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.ADMINVIDEOPOST, arguments: [
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                    "NotEdit",
                  ]);
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              )
            : Text(""),
        drawer: NavDrawer(),
        body: RefreshIndicator(
          backgroundColor: Colors.black,
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                adminVideoController.fetchAdminVideo();
              },
            );
          },
          child: Container(
            color: Colors.blueGrey,
            height: Get.height,
            child: Obx(
              () {
                return adminVideoController.isLoading.value == true
                    ? Align(
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                        alignment: Alignment.topCenter,
                      )
                    : ListView.builder(
                        itemCount:
                            adminVideoController.videoList.value.result.length,
                        itemBuilder: (context, index) {
                          var id = adminVideoController
                              .videoList.value.result[index].id;
                          String title = adminVideoController
                              .videoList.value.result[index].videoTitle;
                          String day = adminVideoController
                              .videoList.value.result[index].day;
                          String description = adminVideoController
                              .videoList.value.result[index].videoDescription;
                          var packageTitle = adminVideoController
                              .videoList.value.result[index].package.title;
                          String startImg = adminVideoController
                              .videoList.value.result[index].startingImage;
                          String endImg = adminVideoController
                              .videoList.value.result[index].endinggImage;
                          String publish = adminVideoController
                              .videoList.value.result[index].publish;

                          return Stack(
                            children: [
                              Positioned(
                                child: Card(
                                  elevation: 8,
                                  shadowColor: Colors.red,
                                  child: Column(
                                    children: [
                                      userMap["role"] == "admin"
                                          ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      AppRoutes.ADMINVIDEOPOST,
                                                      arguments: [
                                                        "edit",
                                                        id,
                                                        title,
                                                        day,
                                                        description,
                                                        packageTitle,
                                                        startImg,
                                                        endImg,
                                                        publish,
                                                      ],
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.green,
                                                    size: 24,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                      title: "Delete Video",
                                                      middleText:
                                                          "Are you sure, You want to Delete this Video",
                                                      buttonColor: Colors.red,
                                                      cancelTextColor:
                                                          Colors.black,
                                                      onCancel: () {},
                                                      onConfirm: () {
                                                        adminVideoController
                                                            .deleteAdminVideo(
                                                                id);
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
                                            )
                                          : Text(""),
                                      Container(
                                        height: 200,
                                        width: Get.width,
                                        child: VideoItem(
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                            adminVideoController.videoList.value
                                                .result[index].video,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   top: 4,
                              //   child: Image.asset(
                              //     'images/premium.png',
                              //     height: 22,
                              //     width: 22,
                              //   ),
                              // ),
                            ],
                          );
                        },
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
