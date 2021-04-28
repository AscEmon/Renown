import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/forumController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostVisiblePage extends StatefulWidget {
  PostVisiblePage({Key key}) : super(key: key);

  @override
  _PostVisiblePageState createState() => _PostVisiblePageState();
}

class _PostVisiblePageState extends State<PostVisiblePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _forumController.repository.forumStatusGet();
  }

  final ForumController _forumController = Get.put(ForumController(
      repository:
          MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.black,
      onRefresh: () {
        return Future.delayed(
          Duration(seconds: 1),
          () {
            _forumController.fetchForumStatus();
          },
        );
      },
      child: Container(
        height: Get.height,
        width: Get.width,
        child: Obx(
          () {
            return _forumController.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  )
                : Container(
                    height: Get.height,
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: _forumController.forumList.value.result.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                  height: 200,
                                  width: Get.width / 1,
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: [
                                      Positioned(
                                        top: 40,
                                        left: 10,
                                        child: Container(
                                          height: Get.height / 5,
                                          width: Get.width / 1.2,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _forumController.forumList
                                                      .value.result[index].post,
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: InkWell(
                                          onTap: () {
                                            print("Pressed");
                                            Get.toNamed(AppRoutes.COMMENTPAGE,
                                                arguments: _forumController
                                                    .forumList
                                                    .value
                                                    .result[index]
                                                    .id);
                                          },
                                          child: Container(
                                            height: Get.height / 24,
                                            width: Get.width / 1.1,
                                            color: Colors.grey,
                                            child: Center(
                                              child: Text(
                                                "Comment",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -16,
                                        left: -12,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 25,
                                          child: Icon(
                                            Icons.account_box,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 48,
                                        child: Text(
                                          _forumController.forumList.value
                                              .result[index].user.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                        Positioned(
                                        top: 30,
                                        left: 26,
                                        child: Container(
                                        height: 2,
                                        width: Get.width/1.19,
                                        color: Colors.black,)
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
