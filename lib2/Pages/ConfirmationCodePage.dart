// ignore_for_file: file_names, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/widgets/MyText.dart';

import 'package:pinput/pinput.dart';

class ConfriamtionCodePage extends StatefulWidget {
  TextEditingController textEditingController = TextEditingController();
  ConfriamtionCodePage({Key? key}) : super(key: key);

  @override
  _ConfriamtionCodePageState createState() => _ConfriamtionCodePageState();
}

class _ConfriamtionCodePageState extends State<ConfriamtionCodePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: NewGradientAppBar(
          gradient: linearGradient,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            height: Get.mediaQuery.size.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Center(
                      child: MyText(
                        content: "الرجاء انتظار رمز التفعيل",
                        size: 24,
                      ),
                    ),
                    Divider(
                      color: blueColor,
                      thickness: 1,
                    ),
                    Center(
                      child: MyText(
                        content: "الرجاء ادخال رمز التفيعل في الحقول أدناه",
                        size: 18,
                        bold: false,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Pinput(
                      onCompleted: (code) {
                        Get.to(() => Container(
                          color: Colors.white,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ));
                        MyConst.userGetXController.verifaiedUser(code);
                      },
                      length: 6,
                    
                      animationCurve: Curves.bounceIn,
                      animationDuration: Duration(milliseconds: 150),
                      autofocus: true,
                      controller: widget.textEditingController,
                      closeKeyboardWhenCompleted: true,
                      keyboardType: TextInputType.number,
                      enabled: true,
                      defaultPinTheme: PinTheme(
                          height: 80,
                          textStyle: GoogleFonts.cairo(
                            color: blueColor,
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: greenColor,
                                    blurRadius: 3,
                                    spreadRadius: 1)
                              ])),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
