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
        body: Obx(
          () {
            return previousController.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  )
                : previousController.previousActivityList.value.data ==
                        null
                    ? Center(
                        child: Text(
                          " No history",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(
                        height: Get.height,
                        width: Get.width,
                        child: (previousController.previousActivityList.value
                                        .data.status ==
                                    true &&
                                previousController.previousActivityList.value
                                        .data.subscription ==
                                    true)
                            ? ListView.builder(
                                itemCount: previousController
                                    .previousActivityList
                                    .value
                                    .data
                                    .history
                                    .length,
                                itemBuilder: (context, index) {
                                  // var keys = previousController
                                  //     .previousActivityList.value.data.keys
                                  //     .toList();
                                  //     print(previousController.previousActivityList.value
                                  //   .data.history.keys.length);
                                  // var values = previousController.previousActivityList
                                  //     .value.data.history[keys[index]];
                                  //     print(values);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Day : " +
                                                  previousController
                                                      .previousActivityList
                                                      .value
                                                      .data
                                                      .history[index]
                                                      .day,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Container(
                                              height: 200,
                                              width: Get.width,
                                              child: VideoItem(
                                                videoPlayerController:
                                                    VideoPlayerController
                                                        .network(
                                                  previousController
                                                      .previousActivityList
                                                      .value
                                                      .data
                                                      .history[index]
                                                      .video,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    previousController
                                                        .previousActivityList
                                                        .value
                                                        .data
                                                        .history[index]
                                                        .videoTitle,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 60,
                                                          width:
                                                              Get.width / 1.2,
                                                          child: Text(
                                                            previousController
                                                                .previousActivityList
                                                                .value
                                                                .data
                                                                .history[index]
                                                                .videoDescription,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
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
                              )
                            : previousController.previousActivityList.value
                                        .subscription ==
                                    false
                                ? Text(
                                    " Your Subscription Date is Over",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                                : Text(" Your id is disable"),
                      );
          },
        ),
      ),
    );
  }
}
