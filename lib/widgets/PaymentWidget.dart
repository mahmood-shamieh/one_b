// ignore_for_file: file_names, curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/main.dart';
import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class PaymentWidget extends StatefulWidget {
  DateTime? date;
  DateTime? date2;
  String? content, catName;
  String? cahceBefor;
  String? caheAfter;
  String? subCatName;
  String? finished;
  dynamic inputs;
  PaymentWidget(
      {Key? key,
      this.inputs,
      this.cahceBefor,
      this.date2,
      this.caheAfter,
      this.content,
      this.date,
      this.catName,
      this.subCatName,
      this.finished})
      : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> inputsWidget = [];
    (json.decode(widget.inputs) as Map).forEach((key, value) {
      inputsWidget.add(
        Container(
          width: double.infinity,
          height: 1,
          color: blueColor,
        ),
      );
      inputsWidget.add(Center(
        child: value.toString().contains(".jpg")
            ? Image(
                image: NetworkImage(MyApp.hostName + "/uploads/" + value),
                errorBuilder: (context, error, stackTrace) =>
                    const Image(image: AssetImage("images/error.gif")),
              )
            : MyText(
                content: key.toString() + " : " + value.toString(),
              ),
      ));
    });
    inputsWidget.add(
      Container(
        width: double.infinity,
        height: 1,
        color: blueColor,
      ),
    );

    // ignore: avoid_init_to_null
    String? date = null;
    if (widget.date != null)
      date = DateFormat('yyyy/MM/dd – kk:mm').format(widget.date!);
    // ignore: avoid_init_to_null
    String? date2 = null;
    if (widget.date2 != null)
      date2 = DateFormat('yyyy/MM/dd – kk:mm').format(widget.date2!);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shadowColor: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              MyText(
                content: widget.catName,
                size: 20,
              ),
              Divider(
                color: blueColor,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MyText(
                  content: widget.subCatName,
                  size: 20,
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: blueColor,
              ),
              Container(
                width: double.infinity,
                child: MyText(
                  content: "النتيجة : " + widget.content!,
                  bold: false,
                ),
              ),
              ...inputsWidget,
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: MyText(
                  content: "قيمة الخصم : " + widget.caheAfter.toString(),
                  bold: false,
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: blueColor,
              ),
              MyText(
                content: date == null ? "" : "تاريخ الدفع : " + date,
                bold: false,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: blueColor,
              ),
              MyText(
                content: date2 == null
                    ? "لم يتم تنفيذ الطلب بعد"
                    : "تاريخ التنفيذ : " + date2,
                bold: false,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: blueColor,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyText(
                  content: (widget.finished == "0"
                      ? "قيد الانتظار"
                      : (widget.finished == "1"
                          ? "تمت العملية"
                          : "العملية ملغاة")),
                  size: 20,
                ),
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
