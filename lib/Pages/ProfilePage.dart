// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:web_application/Constant.dart';

import 'package:web_application/Pages/ChargeAccount.dart';
import 'package:web_application/Pages/EditProfilePage.dart';

import 'package:web_application/widgets/MyText.dart';


class PrrofilePage extends StatefulWidget {
  PrrofilePage({Key? key}) : super(key: key);

  @override
  State<PrrofilePage> createState() => _PrrofilePageState();
}

class _PrrofilePageState extends State<PrrofilePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double distanc = 20.0;
    String? date1;
    if (MyConst.profilePageController.userModel.value.createDate != null)
      date1 = DateFormat('yyyy/MM/dd – kk:mm')
          .format(MyConst.profilePageController.userModel.value.createDate!);
    return Obx(
      () {
        if (MyConst.styleWidgetController
                    .profilePageOrEditProfilePageOrChargeAcount.value ==
                "EditProfilePage") return EditProfilePage();
            if (MyConst.styleWidgetController
                    .profilePageOrEditProfilePageOrChargeAcount.value ==
                "ChargeAccount")
              return ChargeAccount();
            else
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              maxRadius: MediaQuery.of(context).size.width / 4,
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
            Obx(() {
              if (MyConst.profilePageController.isLoding.value)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (MyConst.profilePageController.userModel.value.id == null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    child: MyText(
                      content:
                          "هناك مشكلة في الاتصال بالانترنت يرجى إعادة المحاولة",
                    ),
                  ),
                );
              } 
              
              else {
                
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Divider(
                          color: blueColor,
                          thickness: 1,
                        ),
                        MyText(
                          content:
                              MyConst.profilePageController.userModel.value.level!,
                        ),
                        Divider(
                          color: blueColor,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        MyText(
                            content: "الاسم الأول : " +
                                    MyConst.profilePageController.userModel.value
                                        .firstName
                                        .toString() ??
                                ""),
                        SizedBox(
                          height: distanc,
                        ),
                        MyText(
                            content: "الاسم الأخير : " +
                                    MyConst.profilePageController.userModel.value
                                        .lastName
                                        .toString() ??
                                ""),
                        SizedBox(
                          height: distanc,
                        ),

                        MyText(
                          content: "تاريخ الإنشاء : " + date1!  ?? "",
                        ),
                        SizedBox(
                          height: distanc,
                        ),
                        MyText(
                          content: "رقم الموبايل : " +
                                  MyConst
                                      .profilePageController.userModel.value.mobile
                                      .toString() ??
                              "",
                        ),
                        SizedBox(
                          height: distanc,
                        ),
                        Divider(
                          color: blueColor,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () => MyConst.styleWidgetController
                                  .NavigateProfilePageOrEdirOrCharge(
                                      "ChargeAccount"),
                              child: Center(
                                child: Container(

                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: linearGradient),

                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.attach_money,
                                            color: Colors.white),
                                        MyText(
                                          content: "شحن الرصيد",
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: distanc,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () => MyConst.styleWidgetController
                                  .NavigateProfilePageOrEdirOrCharge(
                                      "EditProfilePage"),
                              child: InkWell(
                                child: Center(
                                  child: Container(

                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: linearGradient),

                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.edit, color: Colors.white),
                                          MyText(
                                            content: "تعديل البيانات",
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer()
                          ],
                        ),
                        Divider(
                          color: blueColor,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                  );
              }
            })
          ],
        );
      }
    );
  }
}
