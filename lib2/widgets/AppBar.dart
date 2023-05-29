// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';



import 'package:web_application/Constant.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  MyAppBar({
    Key ?key,
  })  : preferredSize = Size.fromHeight(55.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewGradientAppBar(
      gradient: linearGradient,
      actions: [
        IconButton(
          icon: SizedBox(width: 20,),
          
          onPressed: () {
          
          },
        ),
      ],
      title: Center(
          child: MyText(
        color: Colors.white,
        content: "فواتيري",
        size: 20,
        bold: false,
      )),
    );
  }
}
