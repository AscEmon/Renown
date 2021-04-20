import 'package:TrainnigInfo/Views/Screens/ForumModule/PostVisiblePage.dart';
import 'package:TrainnigInfo/Views/Screens/ForumModule/StatusPage.dart';
import 'package:flutter/material.dart';



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
              PostVisiblePage(),
              StatusPage()
            ],
          ),
        ),
      ),
    );
  }
}
