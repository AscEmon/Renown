import 'dart:io';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PictureTakeController extends GetxController {
  PictureTakeController({@required this.repository});
  MyRepository repository;
  PickedFile imageProfile;
  Image profileImage;
  ImagePicker _picker = ImagePicker();
  File profile;



  imgFromCamera() async {
    imageProfile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    try {
      if (imageProfile != null) {
        profile = File(imageProfile.path);
        print(File(profile.path));
      }
    } catch (e) {
      return null;
    }
    update();
  }

  imgFromGallery() async {
    imageProfile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    try {
      if (imageProfile != null) {
        profile = File(imageProfile.path);

        print(File(profile.path));
      }
    } catch (e) {
      return null;
    }

    update();
  }
}
