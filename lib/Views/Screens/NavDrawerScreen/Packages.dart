import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Controller/UserPackagesController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:TrainnigInfo/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Packages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PackagesState();
  }
}

class _PackagesState extends State<Packages> {
  final CarouselController _controller = CarouselController();
  final UserPackagesController _userPackagesController = Get.put(
      UserPackagesController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));
  int indexResult = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            'Packages',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.001, 0.6],
            colors: [Colors.black, Colors.grey[50]],
          ),
        ),
        child: Obx(
          () {
            return _userPackagesController.isLoading.value == true
                ? Align(
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    alignment: Alignment.topCenter,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.6,
                            enlargeCenterPage: true,
                            height: 380),
                        items: <Widget>[
                          for (var i = 0;
                              i <
                                  _userPackagesController
                                      .packagesList.value.result.length;
                              i++)
                            Container(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
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
                                      vertical: 18.0, horizontal: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                _userPackagesController.packagesList
                                                        .value.result[i].image ??
                                                    "No Image",
                                                scale: 150.0),
                                          ),
                                          SizedBox(width: 10,),
                                          _userPackagesController.packagesList
                                                        .value.result[i].active=="yes" ? CircleAvatar(
                                            radius: 8,
                                            child: Container(decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(Radius.circular(50))
                                            ),),
                                          ):CircleAvatar(
                                            radius: 8,
                                            child: Container(decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(Radius.circular(50))
                                            ),),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          _userPackagesController.packagesList
                                              .value.result[i].title,
                                              textAlign: TextAlign.justify,
                                              overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.yellow[800],
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                     
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12,right: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Price",
                                              style: TextStyle(
                                                  color: Colors.yellow[800]),
                                            ),
                                            Text(
                                              _userPackagesController
                                                  .packagesList
                                                  .value
                                                  .result[i]
                                                  .price,
                                              style: TextStyle(
                                                 fontSize: 14,
                                                 fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        height: 100,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                _userPackagesController
                                                    .packagesList
                                                    .value
                                                    .result[i]
                                                    .description,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: Colors.yellow[800],
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      RaisedButton(
                                        color: Colors.white,
                                        child: Text(
                                          "SUBSCRIPTION",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        onPressed: () {
                                          var amount = _userPackagesController
                                              .packagesList
                                              .value
                                              .result[i]
                                              .price;
                                          var pId = _userPackagesController
                                              .packagesList.value.result[i].id;
                                          var userId = userMap["data"]["id"];
                                          print(amount.toString());
                                          print(pId.toString());
                                          print(userId.toString());
                                          _userPackagesController
                                              .sendSubscription(
                                                  amount.toString(),
                                                  pId.toString(),
                                                  userId.toString());
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
