import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/forumController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StatusPage extends StatefulWidget {
  StatusPage({Key key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final ForumController _forumController = Get.put(ForumController(
      repository:
          MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _forumController.replyTextController.clear();
    _forumController.forumTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    elevation: 4,
                    child: TextField(
                      autofocus: false,
                      focusNode: FocusNode(),
                      controller: _forumController.forumTextController,
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: 'Whats on your mind?',
                          border: OutlineInputBorder(gapPadding: 16)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      userMap['role'] == "user"
                          ? _forumController.statusPostFunction()
                          : Get.defaultDialog(
                              title: "Unsupported",
                              middleText: "Admin Post is not possible");
                    },
                    child: Card(
                      elevation: 8,
                      child: Container(
                        color: Colors.black,
                        height: 40,
                        width: Get.width,
                        child: Center(
                          child: Text(
                            "Post",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
