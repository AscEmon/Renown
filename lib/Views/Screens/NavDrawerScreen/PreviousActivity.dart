import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/PreviousActivityController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/NavDrawer.dart';
import 'package:TrainnigInfo/Views/Widget/VideoItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class PreviousActivity extends StatefulWidget {
  PreviousActivity({Key key}) : super(key: key);

  @override
  _PreviousActivityState createState() => _PreviousActivityState();
}

class _PreviousActivityState extends State<PreviousActivity> {
  final PreviousActivityController previousController = Get.put(
    PreviousActivityController(
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
            "Previos Activity",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        drawer: NavDrawer(),
        body: Obx(
          () {
            return previousController.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  )
                : Container(
                    height: Get.height,
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: previousController.previousActivityList.value
                          .data.history.keys.length,
                      itemBuilder: (context, index) {
                        var keys = previousController
                            .previousActivityList.value.data.history.keys
                            .toList();
                            print(previousController.previousActivityList.value
                          .data.history.keys.length);
                        var values = previousController.previousActivityList
                            .value.data.history[keys[index]];
                        print(values);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // Container(
                                  //   height: 200,
                                  //   width: Get.width,
                                  //   child: VideoItem(
                                  //     videoPlayerController:
                                  //         VideoPlayerController.network(
                                  //       "${previousController.previousActivityList.value.data.history['${index+1}'][index].video} ",
                                  //     ),
                                  //   ),
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          values[index].videoTitle,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(
                                  //           left: 8, right: 8, bottom: 8),
                                  //       child: SingleChildScrollView(
                                  //         child: Column(
                                  //           children: [
                                  //             Container(
                                  //               height: 60,
                                  //               width: Get.width / 1.2,
                                  //               child: Text(
                                  //                 "${todayController.todayVideoList.value.userData.todayVideo.video[index].videoDescription}",
                                  //                 style: TextStyle(
                                  //                     fontWeight:
                                  //                         FontWeight
                                  //                             .normal,
                                  //                     fontSize: 16),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
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
