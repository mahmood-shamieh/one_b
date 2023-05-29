// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';

// ignore: must_be_immutable
class PayMentPageheader extends StatelessWidget {
  String? title;
  PayMentPageheader({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: title,
                        style: GoogleFonts.cairo(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                  )
                ],
              ),
              Divider(
                thickness: 6,
                height: 20,
                color: greenColor.withOpacity(0.5),
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}
