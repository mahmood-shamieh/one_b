// ignore_for_file: file_names, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Controller/UserController.dart';
import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Pages/Pages.dart';
import 'package:web_application/widgets/MyText.dart';

import '../Constant.dart';

class ChargeAcountGetXController extends GetxController {
  var isLoading = true.obs;
  var responseModel = ResponseModel().obs;
  UserController userController = UserController();
  void addChargingPayment(String code) async {
    await userController
        .chargeAccount(code)
        .then((value) => responseModel.value = value);
    Get.back();
    Get.back();
    Get.defaultDialog(
        title: responseModel.value.status! ? "نجاح" : "فشل",
        content: MyText(
          bold: false,
          size: 16,
          content: responseModel.value.status != true
              ? responseModel.value.msg!
              : responseModel.value.msg! + responseModel.value.data.toString(),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                if (responseModel.value.status!) {
                  MyConst.drawerController.updateDrawer(0);
                  MyConst.styleWidgetController
                      .navigate(Pages.homePage, Get.context);
                      Get.back();
                      Get.back();
                }
                Get.back();
              },
              icon: Center(child: Icon(Icons.close_rounded,size: 40,)))
        ]);
  }
}
