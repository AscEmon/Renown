import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';


class PictureController extends GetxController {
  List<PlatformFile> filepick = [];

  filePick() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      print("results");
      filepick = result.files.toList();
      print(File(filepick[0].path));
      //  files = result.paths.map((path) => File(path)).toList();
      // filepick.forEach(
      //   (files) {
      //     setState(
      //       () {
      //         selectedFileList.add(File(files.path));
      //         fileShow.add(files.name);
      //         //singlefile =File(files.path);
      //         print(File(files.path));
      //       },
      //     );
      //   },
      // );
      // print("first check" + selectedFileList.toString());
      update();
    } else {
      // User canceled the picker
    }
  }
}
