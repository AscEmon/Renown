import 'package:TrainnigInfo/Views/Screens/ForumModule/StatusPage.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForumPage extends StatefulWidget {
  ForumPage({Key key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  TextEditingController forumTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
            title: Text(
              "Forum",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: false,
              tabs: [
                Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                Icon(
                  Icons.post_add,
                  color: Colors.white,
                )
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
                                          prefss.getString("Post").toString(),
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
                                    Get.toNamed(AppRoutes.COMMENTPAGE);
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
                                    "Abu Sayed",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              StatusPage()
            ],
          ),
        ),
      ),
    );
  }
}
