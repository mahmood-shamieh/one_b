// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Controller/ContactUsController.dart';
import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Models/SocialBlockModel.dart';
import 'package:web_application/widgets/MyText.dart';

import '../Constant.dart';
import '../Pages/Pages.dart';

class ContactUsGetXController extends GetxController {
  var isLoading = true.obs;
  ResponseModel responseModel = ResponseModel();
  List<SocialBlockModel> contactList = [];
  ContactUsController contactUsController =  ContactUsController();
  void getAllSocialContactList() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{ try {
      isLoading(true);
      await contactUsController
          .getAllCenters()
          .then((value) => contactList = value!);
    } finally {
      isLoading(false);
      update();
    } });
   
  }

  void sendMessage(String message) async {
    await contactUsController
        .sendMessage(message)
        .then((value) => responseModel = value);
    Get.back();
    Get.defaultDialog(
        title: responseModel.status! ? "نجاح" : "فشل",
        content: MyText(
          bold: false,
          size: 16,
          content: responseModel.msg!,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                if(responseModel.status!){
                  MyConst.drawerController.updateDrawer(0);
                  MyConst.styleWidgetController
                      .navigate(Pages.homePage, Get.context);
                }
                Get.back();
              },
              icon: Center(child: Icon(Icons.close_rounded,size: 40,)))
        ]);
  }
}
