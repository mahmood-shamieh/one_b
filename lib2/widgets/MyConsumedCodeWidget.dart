// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class MyConsumedCodeWidget extends StatelessWidget {
  String? code;
  String? amount;
  DateTime? date;
  DateTime? consumedDate;
  String? checked;
  String? generatorName;
  MyConsumedCodeWidget(
      {Key? key, this.amount, this.code, this.date, this.checked,this.generatorName,this.consumedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? date1 = null;
    if (date != null) {
      date1 = DateFormat('yyyy/MM/dd – kk:mm').format(date!);
    }
    String? date2;
    if (consumedDate != null) {
      date2 = DateFormat('yyyy/MM/dd – kk:mm').format(consumedDate!);
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
                  (checked == "0" ? "الكود متاح" : "الكود مستهلك"),
              color: (checked == "0" ? Colors.green[700]! : Colors.red[700]!),
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
                      
                      color: (checked == "0"
                          ? Colors.green[700]
                          : Colors.red[700]),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                          color: (checked == "0"
                              ? Colors.green[700]!
                              : Colors.red[700]!),
                          width: 2.0),
                      bottom: BorderSide(
                          color: (checked == "0"
                              ? Colors.green[700]!
                              : Colors.red[700]!),
                          width: 2.0),
                      right: BorderSide(
                          color: (checked == "0"
                              ? Colors.green[700]!
                              : Colors.red[700]!),
                          width: 2.0),
                      left: BorderSide(
                          color: (checked == "0"
                              ? Colors.green[700]!
                              : Colors.red[700]!),
                          width: 2.0),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: MyText(
                        content: code!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      
                      color: (checked == "0"
                          ? Colors.green[700]
                          : Colors.red[700]),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: blueColor,
            ),
            MyText(
              content: "القيمة : " + amount!,
            ),
            Divider(
              color: blueColor,
            ),
            MyText(
              content: "المولد : " + (generatorName ?? "المولد الافتراضي").toString(),
            ),
            Divider(
              color: blueColor,
            ),
            MyText(
              content: "تاريخ التوليد : " + (date1! ??"غير معروف بعد"),
            ),
            Divider(
              color: blueColor,
            ),
            MyText(
              content: "تاريخ الاستهلاك : " + (date2 ?? "غير معروف بعد"),
            ),
          ],
        ),
      ),
    );
  }
}
