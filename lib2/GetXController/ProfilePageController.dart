// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:web_application/Controller/UserController.dart';
import 'package:web_application/Models/UserModel.dart';

class ProfilePageController extends GetxController {
  var isLoding = true.obs;
  var userModel = UserModel().obs;
  UserController userController =  UserController();
  void getUserInformations() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoding(true);
        await userController.getUserInfo();
      } finally {
        isLoding(false);
        update();
      }
    });
  }
}
