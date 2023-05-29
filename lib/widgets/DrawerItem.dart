// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_initializing_formals, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class DrawerItem extends StatefulWidget {
  String? content;
  IconData? icon;
  Function()? function;
  bool? chosen;
  int? i;

  DrawerItem(
      String content, IconData icon, Function() function, int i, bool chosen) {
    this.content = content;
    this.icon = icon;
    this.function = function;
    this.i = i;
    this.chosen = chosen;
  }

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: widget.chosen!
            ? linearGradient
            : LinearGradient(colors: [white, white]),
      ),
      height: 40,
      child: InkWell(
        onTap: widget.function,
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 15,
            ),
            Icon(
              widget.icon,
              color: widget.chosen! ? white : blueColor,
              size: 40,
            ),
            SizedBox(
              width: 15,
            ),
            MyText(
                content: widget.content,
                color: widget.chosen! ? white : blueColor,
                size: 18),
          ],
        ),
      ),
    );
  }
}
