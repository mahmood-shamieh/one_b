// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';


class ChargeAccount extends StatefulWidget {
  ChargeAccount({Key? key}) : super(key: key);

  @override
  _ChargeAccountState createState() => _ChargeAccountState();
}

class _ChargeAccountState extends State<ChargeAccount> {
  TextEditingController chargeCode =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [SizedBox(
          height: 10,
        ),
        MyText(
          content: "شحن الحساب",
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
            controller: chargeCode,
            hintText: "أدخل كود الشحن",
            icon: CupertinoIcons.bold_italic_underline,
            isEmail: true,
            isPassword: false,
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
                      "هل أنت متأكد؟؟",
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
                      MyConst.chargeAcountGetXController
                          .addChargingPayment(chargeCode.text);
                          MyConst.profilePageController.getUserInformations();
                      Get.to(() => Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ));
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
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: linearGradient),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.done_all, color: Colors.white),
                        SizedBox(width: 20,),
                        Text(
                          "شحن الحساب",
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
        ),],);
  }
}
