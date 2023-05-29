// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/Pages/SignInPage.dart';
import 'package:web_application/Pages/SignUpPage.dart';

class RegesterationPage extends StatefulWidget {
  const RegesterationPage({Key? key}) : super(key: key);

  @override
  _RegesterationPageState createState() => _RegesterationPageState();
}

class _RegesterationPageState extends State<RegesterationPage> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (MyConst.styleWidgetController.signInPageOrSignUpPage.value)
        return SignInPage();
      else if (!MyConst.styleWidgetController.signInPageOrSignUpPage.value)
        return SignUpPage();
      else
        return Container();
    });
  }
}
