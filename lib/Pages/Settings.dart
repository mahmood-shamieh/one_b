// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:web_application/widgets/AppBar.dart';

import 'package:web_application/widgets/MyText.dart';


class Settins extends StatefulWidget {
  const Settins({Key? key}) : super(key: key);

  @override
  _SettinsState createState() => _SettinsState();
}

class _SettinsState extends State<Settins> {
  var distance = 10.0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: MyAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              child: Image(
                                  image:
                                      AssetImage('images/privacyPolicy.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "سياسة الخصوصية",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              child: Image(
                                  image: AssetImage(
                                      'images/securityPrincibl.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "معايير الأمان",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 70,
                              height: 70,
                              child:
                                  Image(image: AssetImage('images/ban1.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "سياسة الإلغاء",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              child:
                                  Image(image: AssetImage('images/ban.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "الأنشطة المحظورة",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              child: Image(
                                  image:
                                      AssetImage('images/UserGuide-page.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "دليل الإستخدام",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              child: Image(
                                  image: AssetImage('images/userGuide.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "سياسة الإستخدام",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 70,
                              height: 70,
                              child: Image(
                                  image: AssetImage('images/prices.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "الأسعار",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              child: Image(
                                  image: AssetImage('images/billsModels.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "نماذج الفواتير",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              child: Image(
                                  image: AssetImage('images/dataStorage.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "البيانات والتخزين",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              child: Image(
                                  image: AssetImage('images/remember.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          MyText(
                            content: "مواعيد فواتيري",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: distance + 100,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
