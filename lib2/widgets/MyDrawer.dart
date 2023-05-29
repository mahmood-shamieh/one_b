// ignore_for_file: file_names, curly_braces_in_flow_control_structures, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, invalid_use_of_protected_member, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:web_application/Constant.dart';

import 'package:web_application/GetXController/UserController.dart';
import 'package:web_application/Models/UserModel.dart';

import 'package:web_application/Pages/Pages.dart';

import 'package:web_application/Pages/RegesterationPage.dart';
import 'package:web_application/Pages/Settings.dart';
import 'package:web_application/Pages/UserGuide.dart';

import 'package:web_application/widgets/DrawerItem.dart';
import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  double distance = 10;

  MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(GetStorage().read("logedIn") == true);
    Widget getCanChargeButton() {
      // ignore: prefer_typing_uninitialized_variables
      var canGenerate;
      if (GetStorage().read('userModel') is UserModel)
        canGenerate = (GetStorage().read('userModel') as UserModel).canCharge;
      else
        canGenerate =
            UserModel.fromJson(GetStorage().read('userModel')).canCharge;
      if (canGenerate == '1') {
        return DrawerItem("توليد كود شحن", Icons.code, () {
          MyConst.drawerController.updateDrawer(12);
          MyConst.styleWidgetController
              .navigate(Pages.generateCodeCharge, context);
        }, 12, MyConst.drawerController.buttons.value[12]);
      } else
        return Container();
    }

    void navigate(int number, Pages page, BuildContext context) {
      MyConst.drawerController.updateDrawer(number);
      MyConst.styleWidgetController.navigate(page, context);
    }

    return Obx(() {
      if (MyConst.profilePageController.isLoding.value)
        // ignore: prefer_const_constructors
        return Center(
          // ignore: prefer_const_constructors
          child: CircularProgressIndicator(),
        );
      else
        return Container(
          width: MediaQuery.of(context).size.width - 100,
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 230,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: logoImage,
                                    maxRadius: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    child: MyText(
                                      color: Colors.white,
                                      content: MyConst
                                              .logedInController.logedIn.value
                                          ? (MyConst
                                                      .profilePageController
                                                      .userModel
                                                      .value
                                                      .balance !=
                                                  null)
                                              ? "الرصيد الحالي : " +
                                                  MyConst.profilePageController
                                                      .userModel.value.balance
                                                      .toString()
                                              : ""
                                          : "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            MyText(
                              color: Colors.white,
                              content: MyConst.logedInController.logedIn.value
                                  ? ((MyConst.profilePageController.userModel
                                              .value.firstName ??
                                          "") +
                                      " " +
                                      (MyConst.profilePageController.userModel
                                              .value.lastName ??
                                          ""))
                                  : "لم يتم تسجيل الدخول بعد",
                            ),
                            MyText(
                              color: Colors.white,
                              content: MyConst.logedInController.logedIn.value
                                  ? (MyConst.profilePageController.userModel
                                      .value.level!)
                                  : "",
                            ),
                            SizedBox(
                              height: 4,
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(gradient: linearGradient),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DrawerItem("الصفحة الرئيسية", Icons.home, () {
                      MyConst.drawerController.updateDrawer(0);
                      MyConst.styleWidgetController
                          .navigate(Pages.homePage, context);
                      MyConst.styleWidgetController
                          .NavigateToMainPageOrPaymentPage(true);
                    }, 0, MyConst.drawerController.buttons.value[0]),
                    SizedBox(
                      height: widget.distance,
                    ),
                    DrawerItem("الملف الشخصي", Icons.person, () {
                      if (MyConst.logedInController.logedIn.value == true)
                        navigate(1, Pages.profilePage, context);
                      else
                        Get.to(() => RegesterationPage());
                    }, 1, MyConst.drawerController.buttons.value[1]),
                    SizedBox(
                      height: widget.distance,
                    ),
                    DrawerItem("شحن حسابي", Icons.add, () {
                      if (MyConst.logedInController.logedIn.value == true)
                        navigate(2, Pages.chargeAccount, context);
                      else
                        Get.to(() => RegesterationPage());
                    }, 2, MyConst.drawerController.buttons.value[2]),
                    SizedBox(
                      height: widget.distance,
                    ),
                    DrawerItem("سجل المدفوعات", Icons.badge, () {
                      if (MyConst.logedInController.logedIn.value == true)
                        navigate(4, Pages.paymentHistory, context);
                      else
                        Get.to(() => RegesterationPage());
                    }, 4, MyConst.drawerController.buttons.value[4]),
                    SizedBox(
                      height: widget.distance,
                    ),

                    DrawerItem("سجل المدفوعات", Icons.badge, () {
                      if (MyConst.logedInController.logedIn.value == true)
                        navigate(4, Pages.paymentHistory, context);
                      else
                        Get.to(() => RegesterationPage());
                    }, 4, MyConst.drawerController.buttons.value[4]),
                    SizedBox(
                      height: widget.distance,
                    ),
                    DrawerItem("سجل الاستعلامات", Icons.call, () {
                      if (MyConst.logedInController.logedIn.value == true)
                        navigate(5, Pages.orderHistory, context);
                      else
                        Get.to(() => RegesterationPage());
                    }, 5, MyConst.drawerController.buttons.value[5]),
                    SizedBox(
                      height: widget.distance,
                    ),
                    DrawerItem("سجل الإشعارات", Icons.history, () {
                      if (MyConst.logedInController.logedIn.value == true)
                        navigate(6, Pages.notificationhistory, context);
                      else
                        Get.to(() => RegesterationPage());
                    }, 6, MyConst.drawerController.buttons.value[6]),
                    SizedBox(
                      height: widget.distance,
                    ),
                    DrawerItem("أكواد الشحن", Icons.code_off, () {
                      if (MyConst.logedInController.logedIn.value == true) {
                        navigate(7, Pages.codeViewPage, context);
                      } else
                        Get.to(() => RegesterationPage());
                    }, 7, MyConst.drawerController.buttons.value[7]),
                    SizedBox(
                      height: widget.distance,
                    ),
                    DrawerItem("مراكزنا", Icons.streetview_sharp, () {
                      MyConst.drawerController.updateDrawer(8);
                      MyConst.styleWidgetController
                          .navigate(Pages.ourServicesPlaces, context);
                    }, 8, MyConst.drawerController.buttons.value[8]),
                    SizedBox(
                      height: widget.distance,
                    ),
                    DrawerItem("تواصل معنا", Icons.people_alt, () {
                      if (MyConst.logedInController.logedIn.value == true) {
                        MyConst.drawerController.updateDrawer(9);
                        MyConst.styleWidgetController
                            .navigate(Pages.contactUsPage, context);
                      } else
                        Get.to(() => RegesterationPage());
                    }, 9, MyConst.drawerController.buttons.value[9]),
                    SizedBox(
                      height: widget.distance,
                    ),
                    getCanChargeButton(),
                    SizedBox(
                      height: widget.distance,
                    ),
                    MyConst.logedInController.logedIn.value == true
                        ? Obx(() {
                            if (MyConst.logedInController.logedIn.value) {
                              return DrawerItem("الإعدادات", Icons.settings,
                                  () {
                                Get.to(() => Settins());
                              }, 13,
                                  MyConst.drawerController.buttons.value[13]);
                            } else
                              return Container();
                          })
                        : Container(),
                    SizedBox(
                      height: widget.distance,
                    ),
                    MyConst.logedInController.logedIn.value == true
                        ? Obx(() {
                            if (MyConst.logedInController.logedIn.value) {
                              return DrawerItem(
                                  "دليل المستخدم", Icons.question_answer, () {
                                Get.to(() => UserGuidePage());
                              }, 14,
                                  MyConst.drawerController.buttons.value[14]);
                            } else
                              return Container();
                          })
                        : Container(),
                    SizedBox(
                      height: widget.distance,
                    ),
                    MyConst.logedInController.logedIn.value == true
                        ? DrawerItem("تسجيل الخروج", Icons.exit_to_app, () {
                            UserGetXController userGetXController =
                                UserGetXController();
                            userGetXController.signOut({
                              'user_id': MyConst
                                  .profilePageController.userModel.value.id
                            });
                            Get.to(() => Container(
                                  color: Colors.white,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ));
                          }, 15, false)
                        : Container(),
                    SizedBox(
                      height: widget.distance,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    });
  }
}
