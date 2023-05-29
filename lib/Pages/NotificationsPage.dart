// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:web_application/Constant.dart';
import 'package:web_application/Models/NotificationModel.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/NotificationWidget.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatefulWidget {
  List<Widget> items = [];
  NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    widget.items.clear();
    MyConst.userGetXController.getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                child: Image(
                  image: notificationsImage,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              MyText(
                content: "سجل الإشعارات",
                size: 22,
              )
            ],
          ),
        ),
        Divider(
          color: blueColor,
          thickness: 1,
        ),
        Obx(() {
          if (MyConst.userGetXController.isLoading.value == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (MyConst.userGetXController.notifications == null) {
            return Center(
              child: MyText(
                content: "حصلت مشكلة اثناء جلب البيانات يرجي المحاولة مرة أخرى",
              ),
            );
          } else if (MyConst.userGetXController.notifications.isEmpty) {
            return Center(
              child: MyText(
                content: "لا يوجد اشعارات بعد",
              ),
            );
          } else {
            for (NotificationModel item
                in MyConst.userGetXController.notifications) {
              widget.items.add(NotificationWidget(
                title: "إشعار",
                content: item.text!,
                date: item.date != null
                    ? DateFormat('yyyy/MM/dd – kk:mm').format(item.date!)
                    : "",
              ));
            }
            return Column(children: widget.items);
          }
        }),
        SizedBox(
          height: 200,
        )
      ],
    );
  }
}
