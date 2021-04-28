import 'package:TrainnigInfo/Controller/forumController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final ForumController _forumController = Get.find<ForumController>();
  var id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = Get.arguments;
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
        body: Container(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () {
                    return _forumController.isLoading2.value == true
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, right: 16, left: 2),
                                child: Card(
                                  elevation: 8,
                                  child: Container(
                                    height: 120,
                                    width: Get.width / 1.1,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              _forumController.commentList.value
                                                  .result.post,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.show');
                                      openinputDialog(context, id);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 32),
                                      child: Text(
                                        "Reply",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                  },
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RefreshIndicator(
                        backgroundColor: Colors.black,
                        onRefresh: () {
                          return Future.delayed(
                            Duration(seconds: 1),
                            () {
                              _forumController.commentGet(id);
                            },
                          );
                        },
                        child: Container(
                          height: Get.height / 1.6,
                          width: Get.width,
                          child: Obx(
                            () {
                              return _forumController.isLoading2.value == true
                                  ? Text("")
                                  : _forumController.commentList.value.result
                                              .reply.length ==
                                          0
                                      ? Text("")
                                      : Container(
                                          height: Get.height,
                                          width: Get.width,
                                          child: ListView.builder(
                                            itemCount: _forumController
                                                    .commentList
                                                    .value
                                                    .result
                                                    .reply
                                                    .length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.comment,
                                                      color: Colors.black,
                                                      size: 30,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16,
                                                              right: 0,
                                                              left: 2),
                                                      child: Card(
                                                        elevation: 2,
                                                        child: Container(
                                                          height: 100,
                                                          width:
                                                              Get.width / 1.2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    _forumController
                                                                        .commentList
                                                                        .value
                                                                        .result
                                                                        .reply[
                                                                            index]
                                                                        .reply,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openinputDialog(BuildContext context, var id) {
    Get.defaultDialog(
      radius: 4,
      title: "",
      middleText: "",
      content: TextFormField(
        maxLines: 3,
        focusNode: FocusNode(),
        controller: _forumController.replyTextController,
        decoration: InputDecoration(hintText: "Please enter your reply"),
      ),
      confirmTextColor: Colors.white,
      textConfirm: "Reply",
      buttonColor: Colors.black,
      cancelTextColor: Colors.red,
      textCancel: "Cancel",
      onCancel: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        Get.back(canPop: true);
      },
      onConfirm: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _forumController.replyPostFunction(id.toString());
        _forumController.commentGet(id);
        _forumController.update();
        Get.back(canPop: true);
      },
    );
  }
}
