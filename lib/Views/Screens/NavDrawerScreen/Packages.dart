import 'package:TrainnigInfo/Controller/checkController.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Packages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PackagesState();
  }
}

class _PackagesState extends State<Packages> {
  final CarouselController _controller = CarouselController();
  final CheckController _checkController = Get.put(CheckController());
  int indexResult = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            'Packages',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Obx(
            () {
            return _checkController.isLoading.value ==true ? Align(child: LinearProgressIndicator(backgroundColor: Colors.white ,),alignment: Alignment.topCenter,) : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.5,
                      enlargeCenterPage: true,
                      height: 350),
                  items: <Widget>[
                    for (var i = 0;
                        i < _checkController.categoryList.value.data.length;
                        i++)
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(200, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Gold Packages",
                                  style: TextStyle(color: Colors.yellow[800]),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  _checkController
                                      .categoryList.value.data[i].id,
                                  style: TextStyle(color: Colors.yellow[800]),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Subcribe the best packages and find the best training from us",
                                  style: TextStyle(color: Colors.yellow[800]),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                RaisedButton(
                                  child: Text("Subscription"),
                                  onPressed: () {
                                    print(
                                        "pressed  ${_checkController.categoryList.value.data[i].id}");
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
