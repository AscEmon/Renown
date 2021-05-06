import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/UserHomeController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/Views/Utilities/NavDrawer.dart';
import 'package:TrainnigInfo/Views/Widget/VideoItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:TrainnigInfo/main.dart';
import 'package:http/http.dart' as http;

class UserHomePage extends StatefulWidget {
  UserHomePage({Key key}) : super(key: key);

  @override
  _TodaysActivityState createState() => _TodaysActivityState();
}

class _TodaysActivityState extends State<UserHomePage> {
  final UserHomeController todayController = Get.put(
    UserHomeController(
      repository: MyRepository(
        apiClient: MyApiClient(
          httpClient: http.Client(),
        ),
      ),
    ),
  );

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
        drawer: NavDrawer(),
        body: Container(
          height: Get.height / 1.15,
          width: Get.width,
          child: Obx(
            () {
              return todayController.isLoading.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    )
                  : todayController.userVideoList.value.data.status == "0"
                      ? Center(
                          child: Text(
                            "Your Id is Disable",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        )
                      : (todayController.userVideoList.value.subscription ==
                                  true &&
                              todayController.userVideoList.value.data.status ==
                                  "1")
                          ? Container(
                              height: Get.height,
                              width: Get.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "Day : ${todayController.userVideoList.value.userData.todayVideo.day}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height / 1.3,
                                      width: Get.width,
                                      child:todayController
                                                      .userVideoList
                                                      .value
                                                      .userData
                                                      .todayVideo.video.length ==
                                                  0
                                              ? Center(
                                                child: Container(
                                                  height: Get.height,
                                                  width: Get.width,
                                                  child: Center(child: Text("No videos For Today",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),))),
                                              )
                                              :  ListView.builder(
                                        itemCount: todayController
                                                .userVideoList
                                                .value
                                                .userData
                                                .todayVideo
                                                .video
                                                .length,
                                        itemBuilder: (context, index) {
                                          var vidoeID = todayController
                                              .userVideoList
                                              .value
                                              .userData
                                              .todayVideo
                                              .video[index]
                                              .id;

                                          var pckgId = todayController
                                              .userVideoList
                                              .value
                                              .userData
                                              .todayVideo
                                              .video[index]
                                              .packageId;
                                          var day = todayController
                                              .userVideoList
                                              .value
                                              .userData
                                              .todayVideo
                                              .video[index]
                                              .day;
                                          return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Card(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          todayController
                                                                      .userVideoList
                                                                      .value
                                                                      .userData
                                                                      .todayVideo
                                                                      .video[
                                                                          index]
                                                                      .startingImage ==
                                                                  "yes"
                                                              ? RaisedButton(
                                                                  child: Text(
                                                                    "Start Image",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  color: Colors
                                                                      .black,
                                                                  onPressed:
                                                                      () {
                                                                    Get.toNamed(
                                                                      AppRoutes
                                                                          .PICTUREPAGE,
                                                                      arguments: [
                                                                        vidoeID,
                                                                        pckgId,
                                                                        day,
                                                                        "start"
                                                                      ],
                                                                    );
                                                                  },
                                                                )
                                                              : Text(""),
                                                          Container(
                                                            height: 200,
                                                            width: Get.width,
                                                            child: VideoItem(
                                                              videoPlayerController:
                                                                  VideoPlayerController
                                                                      .network(
                                                                "${todayController.userVideoList.value.userData.todayVideo.video[index].video} ",
                                                              ),
                                                            ),
                                                          ),
                                                          todayController
                                                                      .userVideoList
                                                                      .value
                                                                      .userData
                                                                      .todayVideo
                                                                      .video[
                                                                          index]
                                                                      .endinggImage ==
                                                                  "yes"
                                                              ? RaisedButton(
                                                                  child: Text(
                                                                    "End Image",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  color: Colors
                                                                      .black,
                                                                  onPressed:
                                                                      () {
                                                                    Get.toNamed(
                                                                      AppRoutes
                                                                          .PICTUREPAGE,
                                                                      arguments: [
                                                                        vidoeID,
                                                                        pckgId,
                                                                        day,
                                                                        "end"
                                                                      ],
                                                                    );
                                                                  },
                                                                )
                                                              : Text(""),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  "${todayController.userVideoList.value.userData.todayVideo.video[index].videoTitle}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .justify,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8,
                                                                        bottom:
                                                                            8),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            60,
                                                                        width: Get.width /
                                                                            1.2,
                                                                        child:
                                                                            Text(
                                                                          "${todayController.userVideoList.value.userData.todayVideo.video[index].videoDescription}",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: Center(
                                child: Container(
                                  height: Get.height / 2,
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      Text(
                                        " Your Subscription Date is Over",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          Get.offAndToNamed(AppRoutes.PACKAGES);
                                        },
                                        color: Colors.black,
                                        child: Text(
                                          "Subcription",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
            },
          ),
        ),
      ),
    );
  }
}
