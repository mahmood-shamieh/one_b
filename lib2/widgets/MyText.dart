// ignore_for_file: file_names, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  String? content;
  double? size;
  Color? color;
  bool? bold;
  MyText({Key? key, this.content, this.size, this.color, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: content,
          style: GoogleFonts.cairo(
              fontWeight: (bold) == null ? FontWeight.bold : FontWeight.normal,
              fontSize: size == null ? 20 : size,
              color: color == null ? blueColor : color),
        ));
  }
}
