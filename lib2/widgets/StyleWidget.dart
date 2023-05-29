// ignore_for_file: file_names, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/Pages/ChargeAccount.dart';
import 'package:web_application/Pages/CodeViewPage.dart';
import 'package:web_application/Pages/ContactUsPage.dart';

import 'package:web_application/Pages/GenerateCodeChargePage.dart';
import 'package:web_application/Pages/HomePage.dart';
import 'package:web_application/Pages/NotificationsPage.dart';
import 'package:web_application/Pages/OrdersHistoryPage.dart';
import 'package:web_application/Pages/OurServicesPlacePage.dart';
import 'package:web_application/Pages/Pages.dart';
import 'package:web_application/Pages/PaymentHistory.dart';
import 'package:web_application/Pages/ProfilePage.dart';
import 'package:web_application/Pages/RatingAppPage.dart';
import 'package:web_application/Pages/SharePage.dart';
import 'package:web_application/widgets/MyText.dart';

import 'AppBar.dart';

import 'MyDrawer.dart';

// ignore: must_be_immutable
class StyleWidget extends StatefulWidget {
  bool? logedIn;
  List<Widget>? items = [];
  int? i;
  StyleWidget({Key? key, this.items, this.i, this.logedIn}) : super(key: key);
  @override
  _StyleWidgetState createState() => _StyleWidgetState();
}

class _StyleWidgetState extends State<StyleWidget> {
  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: MyText(
              content: "الخروج من التطبيق",
            ),
            content: MyText(
              content: "هل أنت متأكد من الخروج من التطبيق ؟",
            ),
            actions: [
              InkWell(
                onTap: () => Navigator.of(context).pop(false),
                
                child: MyText(
                  content: "إلغاء",
                ),
              ),
              InkWell(
                onTap: () => exit(0),
                
                child: MyText(
                  content: "تأكيد",
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ) ??
        false; 
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: MyAppBar(),
            drawer: MyDrawer(
             
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Obx(() {
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.homePage) return HomePage();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.profilePage)
                      return PrrofilePage();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.chargeAccount) return ChargeAccount();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.paymentHistory) return PaymentHistroy();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.orderHistory) return OrderHistoryPage();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.notificationhistory) return NotificationsPage();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.codeViewPage) return CodeViewPage();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.ourServicesPlaces) return OurServicesPlacePage();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.contactUsPage) return ContactUsPage();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.ratingPage) return RatingAppPage();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.shareAppPage) return SharePage();
                    if (MyConst.styleWidgetController.page.value ==
                        Pages.generateCodeCharge)
                      return GenerateCodeChargePage();
                    return Container(
                      color: Colors.white,
                      child: MyText(
                        content: "هناك خطأ ما",
                      ),
                    );
                  }),
                ),
              ],
            )),
      ),
    );
  }
}
