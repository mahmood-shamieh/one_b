// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:web_application/widgets/MainMenuItem.dart';
import 'package:web_application/widgets/StyleWidget.dart';
import 'package:responsive_grid/responsive_grid.dart';

class OurAApplications extends StatefulWidget {
  OurAApplications({Key? key}) : super(key: key);

  @override
  _OurAApplicationsState createState() => _OurAApplicationsState();
}

class _OurAApplicationsState extends State<OurAApplications> {
  @override
  Widget build(BuildContext context) {
    return StyleWidget(
      i: 11,
      items: [
        ResponsiveGridList(
          children: [
            MainMenuItem(
              url: "images/facebook.png",
              content: "Facebook",
              navigation: () {},
            ),
            MainMenuItem(
              url: "images/whatsApp.png",
              content: "Whatsapp",
              navigation: () {},
            ),
            MainMenuItem(
              url: "images/telegram.png",
              content: "Telegram",
              navigation: () {},
            ),
            MainMenuItem(
              url: "images/phone.png",
              content: "اتصال",
              navigation: () {},
            ),
          ],
          desiredItemWidth: 200,
          scroll: false,
        )
      ],
    );
  }
}
