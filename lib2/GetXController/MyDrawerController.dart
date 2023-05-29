// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_application/Controller/UserController.dart';

class MyDrawerController extends GetxController {
  var isLoding = true.obs;
  var canGenerate = false.obs;
  UserController userController =  UserController();
  void canGenerateCode() async {
    if (GetStorage().read("logedIn") ?? false) {
      if (isLoding.value == false) return;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        try {
          isLoding(true);
          await userController
              .canGenerateCode()
              .then((value) => canGenerate.value = value);
        } finally {
          isLoding(false);
          update();
        }
      });
    }
  }
}
