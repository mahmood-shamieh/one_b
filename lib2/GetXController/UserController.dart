// ignore_for_file: invalid_use_of_protected_member, file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls, avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/Controller/UserController.dart';
import 'package:web_application/Models/OrderModel.dart';
import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Models/UserModel.dart';
import 'package:web_application/Pages/ConfirmationCodePage.dart';

import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/StyleWidget.dart';

import '../Pages/Pages.dart';

class UserGetXController extends GetxController {
  var isSearched = false.obs;
  var isSearchedAsk = false.obs;
  var searchedOrders = [].obs;
  var searchedAskOrders = [].obs;
  var responseModel = ResponseModel().obs;
  var isLoading = true.obs;
  UserController userController = UserController();
  var orders = [].obs;
  var ordersAsk = [].obs;
  var notifications = [];

  void signUp(UserModel userModel) async {
    bool? userActive = null;
    await userController.addUser(userModel).then((value) {
      responseModel.value = value['response'];
      userActive = value['active'] == null
          ? userActive = null
          : (value['active'] == '1' ? true : false);
          GetStorage().write("logedIn", value['active'] == '1' ? true : false);
    });
    Get.back();
    // print(userActive);
    if (userActive != null) if (!userActive! && responseModel.value.status!)
      Get.to(() => ConfriamtionCodePage());
    else if (responseModel.value.status! && userActive!) {
      // Get.back();
      Get.back();
    }
    Get.defaultDialog(
        title: responseModel.value.status! ? "نجاح" : "فشل",
        content: MyText(
          bold: false,
          size: 16,
          content: responseModel.value.msg!,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.back();
                // Get.to(()=>StyleWidget());
              },
              icon: Center(
                  child: Icon(
                Icons.close_rounded,
                size: 40,
              )))
        ]);
    // Get.to(() => StyleWidget());
    // update();
  }

  void ressetPassword(String mobile) async {
    await userController
        .ressetPassword(mobile)
        .then((value) => responseModel.value = value);
    Get.back();
    Get.defaultDialog(
        title: responseModel.value.status! ? "نجاح" : "فشل",
        content: MyText(
          bold: false,
          size: 16,
          content: responseModel.value.msg!,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.back();
                
              },
              icon: Center(
                  child: Icon(
                Icons.done,
                size: 40,
              )))
        ]);
  }

  void signIn(Map map) async {
    // ignore: unused_local_variable
    bool active = false;
    bool needActive = false;
    await userController.signIn(map).then((value) {
      responseModel.value = value['responseModel'];
      active = value['active'];
      needActive = value['needActive'];
    });
    if (needActive) {
      Get.to(() => ConfriamtionCodePage());
    } else {
      Get.back();
      Get.back();
      Get.defaultDialog(
          title: responseModel.value.status! ? "نجاح" : "فشل",
          content: MyText(
            bold: false,
            size: 16,
            content: responseModel.value.msg!,
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  if (responseModel.value.status!) {
                    Get.back();
                    Get.to(() => StyleWidget());
                  } else
                    Get.back();
                },
                icon: Center(
                    child: Icon(
                  Icons.done,
                  size: 40,
                )))
          ]);
    }
  }

  void signOut(Map map) async {
    await userController
        .signOut(map)
        .then((value) => responseModel.value = value);

    Get.back();
    Get.defaultDialog(
        title: responseModel.value.status! ? "نجاح" : "فشل",
        content: MyText(
          bold: false,
          size: 16,
          content: responseModel.value.msg!,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.back();
                MyConst.drawerController.updateDrawer(0);
                MyConst.styleWidgetController
                    .navigate(Pages.homePage, Get.context);
              },
              icon: Center(
                  child: Icon(
                Icons.close_rounded,
                size: 40,
              )))
        ]);
  }

  void updateUser(UserModel userModel) async {
    await userController
        .updateUser(userModel)
        .then((value) => responseModel.value = value);

    Get.back();
    Get.defaultDialog(
        title: responseModel.value.status! ? "نجاح" : "فشل",
        content: MyText(
          bold: false,
          size: 16,
          content: responseModel.value.msg!,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.back();
                MyConst.drawerController.updateDrawer(0);
                MyConst.styleWidgetController
                    .navigate(Pages.homePage, Get.context);
              },
              icon: Center(
                  child: Icon(
                Icons.close_rounded,
                size: 40,
              )))
        ]);
  }

  void generateCode(String amount, BuildContext context) async {
    await userController
        .generateCode(amount)
        .then((value) => responseModel.value = value);

    Get.back();
    Get.back();
    Get.defaultDialog(
        title: responseModel.value.status! ? "نجاح" : "فشل",
        content: MyText(
          bold: false,
          size: 16,
          content: !responseModel.value.status!
              ? responseModel.value.msg
              : responseModel.value.data,
        ),
        actions: <Widget>[
          InkWell(
              onTap: () {
                if (responseModel.value.status!) {
                  Share.share(responseModel.value.data);
                  MyConst.drawerController.updateDrawer(0);
                  MyConst.styleWidgetController
                      .navigate(Pages.homePage, Get.context);
                } else
                  Get.back();
              },
              child: responseModel.value.status!
                  ? MyText(
                      content: "إنقر للمشاركة",
                    )
                  : Center(
                      child: Icon(
                      Icons.close_rounded,
                      size: 40,
                    )))
        ]);
  }

  void getAllOrders() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoading(true);
        await userController
            .getPymentHistory()
            .then((value) => orders.value = value!);
        MyConst.profilePageController.getUserInformations();
      } finally {
        isLoading(false);

        update();
      }
    });
  }

  void getAllNotification() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoading(true);
        await userController
            .getUserNotification()
            .then((value) => notifications = value!);
      } finally {
        isLoading(false);
        update();
      }
    });
  }

  void getorderHistory() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoading(true);
        MyConst.profilePageController.getUserInformations();
        await userController
            .getOrderHistory()
            .then((value) => ordersAsk.value = value!);
      } finally {
        isLoading(false);
        update();
      }
    });
  }

  void searchOnOrder(String? value, DateTime? date) {
    isSearched.value = value == null ? false : true;
    isSearched.value = value == '' ? false : true;
    searchedOrders.value = [];
    searchedOrders.value.clear();
    orders.value.forEach((element) {
      OrderModel order = element as OrderModel;
      if (value != null) if (order.content!
              .toLowerCase()
              .contains(value.trim()) ||
          DateFormat('yyyy/MM/dd – kk:mm')
              .format(order.dateTime!)
              .toLowerCase()
              .toString()
              .contains(value.trim()) ||
          order.title!.toLowerCase().contains(value.trim())) {
        searchedOrders.value.add(order);
      }
      if (date != null) if (order.dateTime!.year == date.year &&
          order.dateTime!.month == date.month &&
          order.dateTime!.day == date.day) {
        searchedOrders.value.add(order);
      }
    });
    update();
  }

  void inialSearchPage() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isSearched.value = false;
      isSearchedAsk.value = false;
    });
  }

  void searchOnOrderAsk(String? value, DateTime? date) {
    isSearchedAsk.value = value == null ? false : true;
    isSearchedAsk.value = value == '' ? false : true;
    searchedAskOrders.value = [];
    searchedAskOrders.value.clear();
    ordersAsk.value.forEach((element) {
      OrderModel order = element as OrderModel;
      if (value != null) if (order.content!
              .toLowerCase()
              .contains(value.trim()) ||
          DateFormat('yyyy/MM/dd – kk:mm')
              .format(order.dateTime!)
              .toLowerCase()
              .toString()
              .contains(value.trim()) ||
          order.title!.toLowerCase().contains(value.trim())) {
        searchedAskOrders.value.add(order);
      }
      if (date != null) if (order.dateTime!.year == date.year &&
          order.dateTime!.month == date.month &&
          order.dateTime!.day == date.day) {
        searchedAskOrders.value.add(order);
      }
    });
    update();
  }

  void verifaiedUser(String code) async {
    try {
      isLoading(true);
      await userController
          .verifyUser(code)
          .then((value) => responseModel.value = value);
      Get.back();
      Get.defaultDialog(
          title: responseModel.value.status! ? "نجاح" : "فشل",
          content: MyText(
            bold: false,
            size: 16,
            content: responseModel.value.msg!,
          ),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  if (responseModel.value.status!) {
                    Get.back();
                    Get.back();
                    Get.back();
                    MyConst.profilePageController.getUserInformations();
                    Get.to(StyleWidget());
                  } else
                    Get.back();
                },
                child: Center(
                    child: Icon(
                  Icons.close_rounded,
                  size: 40,
                )))
          ]);
    } finally {
      isLoading(false);

      update();
    }
  }
}
