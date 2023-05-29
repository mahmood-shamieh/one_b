// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/GetXController/UserController.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';


class GenerateCodeChargePage extends StatefulWidget {
  const GenerateCodeChargePage({Key? key}) : super(key: key);

  @override
  _GenerateCodeChargePageState createState() => _GenerateCodeChargePageState();
}

class _GenerateCodeChargePageState extends State<GenerateCodeChargePage> {
  TextEditingController codeEditingController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        SizedBox(
          height: 10,
        ),
        MyText(
          content: "توليد كود الشحن",
          size: 25,
        ),
        Divider(
          color: Theme.of(context).primaryColor,
          indent: 30,
          endIndent: 30,
          thickness: 1,
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyTextField(
            controller: codeEditingController,
            hintText: "أدخل القيمة المراد شحنها",
            icon: CupertinoIcons.money_euro,
            isEmail: true,
            isPassword: false,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Spacer(),
            InkWell(
              onTap: () {
                showAlertDialog(context, [
                  Center(
                    child: Text(
                      "هل أنت متأكد من توليد كود بقيمة "+codeEditingController.text.toString()+"؟؟",
                      style: GoogleFonts.cairo(
                          color: blueColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ], [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "إلغاء",
                        style: GoogleFonts.cairo(
                            color: blueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                  TextButton(
                    onPressed: () {
                      Get.to(() => Container(
                            color: Colors.white,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                            height: double.infinity,
                            width: double.infinity,
                          ));
                      UserGetXController userGetXController =
                          Get.put(UserGetXController());
                      userGetXController.generateCode(
                          codeEditingController.text, context);
                    },
                    child: Text(
                      "تأكيد",
                      style: GoogleFonts.cairo(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]);
              },
              child: Center(
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: linearGradient),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.done_all, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "توليد كود الشحن",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
      ],
    );
  }
}
