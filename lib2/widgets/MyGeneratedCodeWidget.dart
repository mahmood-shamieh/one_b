// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class MyGeneratedCodeWidget extends StatefulWidget {
  String? code;
  String? amount;
  DateTime? date;
  DateTime? consumedDate;
  String? checked;
  String? consumedName;
  MyGeneratedCodeWidget(
      {Key? key, this.amount, this.code, this.date, this.checked,this.consumedName,this.consumedDate})
      : super(key: key);

  @override
  _MyGeneratedCodeWidgetState createState() => _MyGeneratedCodeWidgetState();
}

class _MyGeneratedCodeWidgetState extends State<MyGeneratedCodeWidget> {
  String? date1;
  String? date2;

  @override
  Widget build(BuildContext context) {
    if (widget.date != null) {
      date1 = DateFormat('yyyy/MM/dd – kk:mm').format(widget.date!);
    }
    if (widget.consumedDate != null) {
      date2 = DateFormat('yyyy/MM/dd – kk:mm').format(widget.consumedDate!);
    }
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            
            MyText(
              content: "حالة الكود : " +
                  (widget.checked == "0" ? "الكود متاح" : "الكود مستهلك"),
              color:
                  (widget.checked == "0" ? Colors.green[700]! : Colors.red[700]!),
            ),
            Divider(
              color: blueColor,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      // width: 20,
                      color: (widget.checked == "0"
                          ? Colors.green[700]!
                          : Colors.red[700]!),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                          color: (widget.checked == "0"
                              ? Colors.green[700]!
                              : Colors.red[700]!),
                          width: 2.0),
                      bottom: BorderSide(
                          color: (widget.checked == "0"
                              ? Colors.green[700]!
                              : Colors.red[700]!),
                          width: 2.0),
                      right: BorderSide(
                          color: (widget.checked == "0"
                              ? Colors.green[700]!
                              : Colors.red[700]!),
                          width: 2.0),
                      left: BorderSide(
                          color: (widget.checked == "0"
                              ? Colors.green[700]!
                              : Colors.red[700]!),
                          width: 2.0),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: MyText(
                        content: widget.code!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      // width: 20,
                      color: (widget.checked == "0"
                          ? Colors.green[700]!
                          : Colors.red[700]!),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: blueColor,
            ),
            MyText(
              content: "القيمة : " + widget.amount!,
            ),
            Divider(
              color: blueColor,
            ),
            MyText(
              content: "المستهلك : " + (widget.consumedName ?? "المستهلك الافتراضي").toString(),
            ),
            Divider(
              color: blueColor,
            ),
            MyText(
              content: "تاريخ التوليد : " + (date1 ??= "غير معروف بعد" ),
            ),
            Divider(
              color: blueColor,
            ),
            MyText(
              content: "تاريخ الاستهلاك : " + (date2 ??= "غير معروف بعد"),
            ),
            Divider(
              color: blueColor,
            ),
            TextButton(
              onPressed: () {
                Share.share(widget.code ?? " ");
                // final RenderObject box = context.findRenderObject()!;
                // Share.share(widget.code ?? " ",
                //     sharePositionOrigin:
                //         (box as RenderBox).localToGlobal(Offset.zero) & box.size);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: MyText(
                      color: Colors.white,
                      content: "إنقر للمشاركة",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
