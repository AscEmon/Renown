import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PicturePage extends StatefulWidget {
  PicturePage({Key key}) : super(key: key);

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  List<PlatformFile> filepick = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Take Pic",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.001, 0.6],
              colors: [Colors.black, Colors.grey[50]],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: filepick.isEmpty
                      ? Container(
                          height: 300,
                          width: 200,
                          color: Colors.black,
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 60,
                          ),
                        )
                      : Card(
                          elevation: 8,
                          child: Image.file(
                            File(filepick[0].path),
                            height: 300,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                RaisedButton(
                  child: Text(
                    "Pick Image",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await filePick();
                  },
                ),
                RaisedButton(
                  child: Text(
                    "Send Image",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await filePick();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> filePick() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      print("results");
      filepick = result.files.toList();
      print(File(filepick[0].path));
      //  files = result.paths.map((path) => File(path)).toList();
      filepick.forEach(
        (files) {
          setState(
            () {
              // selectedFileList.add(File(files.path));
              // fileShow.add(files.name);
              //singlefile =File(files.path);
              print(File(files.path));
            },
          );
        },
      );
    } else {
      // User canceled the picker
    }
  }
}
