import 'package:TrainnigInfo/Model/Check.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/Views/Utilities/NavDrawer.dart';
import 'package:TrainnigInfo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../Widget/VideoItem.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        floatingActionButton: InkWell(
          onTap: (){
            Get.toNamed(AppRoutes.PICTUREPAGE);
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
            child: Icon(Icons.add_a_photo, color: Colors.white),
          ),
        ),
        drawer: NavDrawer(),
        body: Container(
          height: Get.height,
          child: ListView.builder(
            itemCount: StringModel.stringCheck.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Positioned(
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.red,
                      child: Container(
                        height: 200,
                        width: Get.width,
                        child: VideoItem(
                          videoPlayerController: VideoPlayerController.network(
                            StringModel.stringCheck[index].url,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    child: Image.asset(
                      'images/premium.png',
                      height: 22,
                      width: 22,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
