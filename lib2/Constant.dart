// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_application/GetXController/AfterSubCatPagesController.dart';
import 'package:web_application/GetXController/CaruselGetXController.dart';
import 'package:web_application/GetXController/CategoryController.dart';

import 'package:web_application/GetXController/ChargeAcountGetXController.dart';
import 'package:web_application/GetXController/CodePageGetXController.dart';
import 'package:web_application/GetXController/DrawerController.dart';
import 'package:web_application/GetXController/LogedInController.dart';

import 'package:web_application/GetXController/MyDrawerController.dart';
import 'package:web_application/GetXController/ProfilePageController.dart';
import 'package:web_application/GetXController/RatingCcontroller.dart';

import 'package:web_application/GetXController/StyleWidgetController.dart';
import 'package:web_application/GetXController/SubCatController.dart';
import 'package:web_application/GetXController/UserController.dart';
import 'package:splash_route/splash_route.dart';

List<Color> gradinentColors = [
 blueColor,greenColor
];
// Color blueColor = Color.fromRGBO(2, 7, 29, 1);
Color blueColor = Color.fromRGBO(63, 108, 176, 1);
// Color greenColor = Color.fromRGBO(255, 168, 7, 1);
Color greenColor = Color.fromRGBO(71, 190, 153, 1);
LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blueColor, greenColor]);
BoxDecoration linearGradientbox = BoxDecoration(gradient: linearGradient);
BorderRadius borderRadius = BorderRadius.circular(20);
BoxDecoration shadowBoxDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.9),
    borderRadius: borderRadius,
    boxShadow: [
      BoxShadow(blurRadius: 20, spreadRadius: 12, color: Colors.grey)
    ]);
ImageProvider logoImage = AssetImage('images/logo.jpg');
ImageProvider itemImage = AssetImage('images/item.png');
ImageProvider notificationsImage = AssetImage('images/notifications.png');
ImageProvider ordersHistoryImage = AssetImage('images/ordersHistory.png');
Color white = Colors.white;
DecorationImage backgroundImage = DecorationImage(
  image: logoImage,
  colorFilter: ColorFilter.mode(white, BlendMode.dstIn),
  fit: BoxFit.fill,
);
void showAlertDialog(
    BuildContext context, List<Widget> items, List<TextButton> buttons) {
  AlertDialog alert = AlertDialog(
    content: Container(
        child: SingleChildScrollView(
      child: ListBody(
        children: items,
      ),
    )),
    actions: buttons,
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void navigate(Widget targetPage,BuildContext context) {
  Navigator.of(context).push(
    SplashRoute(
      targetPage: targetPage,
      splashColor: blueColor,
      startFractionalOffset: FractionalOffset.center,
      transitionDuration: Duration(milliseconds: 800),
    ),
  );
}

final picker = ImagePicker();

class MyConst {
  static AfterSubCatPagesController afterSubCatPagesController =
      Get.put(AfterSubCatPagesController());
  static ChargeAcountGetXController chargeAcountGetXController =
      Get.put(ChargeAcountGetXController());
  static SubCatController subCatController = Get.put(SubCatController());
  static LogedInController logedInController = Get.put(LogedInController());
  static MyDrawerController myDrawerController = Get.put(MyDrawerController());
  static ProfilePageController profilePageController =
      Get.put(ProfilePageController());
  static RatingController ratingController = Get.put(RatingController());

  static CaruselGetXController caruselGetXController =
      Get.put(CaruselGetXController());
  static UserGetXController userGetXController = Get.put(UserGetXController());
  static CodePageGetXController codePageGetXController =
      Get.put(CodePageGetXController());
  static CategoryGetXController categoryController =
      Get.put(CategoryGetXController());
  static StyleWidgetController styleWidgetController =
      Get.put(StyleWidgetController());
  static MyDrawerGetXController drawerController =
      Get.put(MyDrawerGetXController());
}
