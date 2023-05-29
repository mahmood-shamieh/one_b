// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';

import 'package:web_application/Controller/SubCatContentcontroller.dart';

import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Pages/Pages.dart';

import 'package:web_application/widgets/MyText.dart';

class AfterSubCatPagesController extends GetxController {
  var isLoading = true.obs;
  var textFields = [].obs;
  var dropDowns = [].obs;
  var multiTextField = [].obs;
  var imageLoaders = [].obs;
  ResponseModel responseModel = ResponseModel();
  SubCatContentContoller subCatContentContoller = SubCatContentContoller();

  void getConatinent(Map map) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoading(true);
        await subCatContentContoller.getSubCatContent(map).then((value) {
          // print(value);
          textFields.value = value['textFields'];
          dropDowns.value = value['dropDowns'];
          multiTextField.value = value['multiTextField'];
          imageLoaders.value = value['imageLoaders'];
        });

        
      } finally {
        isLoading(false);
        update();
      }
    });
  }

  void addOrder(Map map, int sign, bool reSentOrder) async {
    await subCatContentContoller
        .addOrder(map)
        .then((value) => responseModel = value);

    if ((reSentOrder ?? false) && responseModel.status!) {
      await subCatContentContoller.setOrderSent(map['order_id']);
    }
    MyConst.profilePageController.getUserInformations();
    if (!reSentOrder ?? true) {
      Get.back();
      Get.back();
    }
    if (responseModel.status!) {
      if (sign == 1) {
        Get.back();
        Get.back();
      } else {
        MyConst.drawerController.updateDrawer(0);
        MyConst.styleWidgetController.navigate(Pages.homePage, Get.context);
      }
    }
    Get.defaultDialog(
        title: responseModel.status! ? "نجاح" : "فشل",
        content: MyText(
          bold: false,
          size: 16,
          content: responseModel.msg!,
        ),
        actions: <Widget>[
          InkWell(
              onTap: () {
                if (responseModel.status!) {
                  if (sign == 1) {
                    Get.back();
                    Get.back();
                  } else {
                    MyConst.drawerController.updateDrawer(0);
                    MyConst.styleWidgetController
                        .navigate(Pages.homePage, Get.context);
                  }
                }
                Get.back();
              },
              child: Center(
                  child: Icon(
                Icons.close_rounded,
                size: 40,
              ))),
        ]);
  }

  void setOrderSent(String orderId, int sign) async {
    await subCatContentContoller
        .setOrderSent(orderId)
        .then((value) => responseModel = value);
    MyConst.profilePageController.getUserInformations();
    Get.back();
    Get.back();
    if (responseModel.status!) {
      if (sign == 1) {
        Get.back();
        Get.back();
      } else {
        MyConst.drawerController.updateDrawer(0);
        MyConst.styleWidgetController.navigate(Pages.homePage, Get.context);
      }
    }
    
  }
}
