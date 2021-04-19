import 'package:TrainnigInfo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusPage extends StatefulWidget {
  StatusPage({Key key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  TextEditingController forumTextController = TextEditingController();
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
                      controller: forumTextController,
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
                    onTap: (){
                      saveData();
                    },
                      child: Card(
                    elevation: 8,
                    child: Container(
                        color: Colors.blue,
                        height: 40,
                        width: Get.width,
                        child: Center(child: Text("Post",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),))),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveData() {
    // List postList=[];
    // postList.add(forumTextController.text);
    prefss.setString("Post", forumTextController.text);
    forumTextController.clear();
  }
}
