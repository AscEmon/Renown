import 'package:TrainnigInfo/Controller/forumController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final ForumController _forumController = Get.find<ForumController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var id = Get.arguments;
    _forumController.commentGet(id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Comment",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return _forumController.isLoading2.value == true
                ? Center(
                    child: CircularProgressIndicator(backgroundColor: Colors.black,),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, right: 16, left: 16),
                          child: Card(
                            elevation: 8,
                            child: Container(
                              height: 60,
                              width: Get.width / 1.1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_forumController
                                    .commentList.value.result.post),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
