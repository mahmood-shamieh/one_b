// ignore_for_file: file_names, use_full_hex_values_for_flutter_colors, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/main.dart';
import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class OrderHisotryWidget extends StatefulWidget {
  String? title, content, title1;
  bool? askOrderSent;
  DateTime? date;
  dynamic inputs;
  String? bill;
  String? cost;
  String? subcatId;
  String? finished;
  String? orderId;
  OrderHisotryWidget(
      {Key? key,
      this.orderId,
      this.askOrderSent,
      this.finished,
      this.title1,
      this.subcatId,
      this.title,
      this.content,
      this.date,
      this.inputs,
      this.bill,
      this.cost})
      : super(key: key);

  @override
  State<OrderHisotryWidget> createState() => _OrderHisotryWidgetState();
}

class _OrderHisotryWidgetState extends State<OrderHisotryWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> inputsWidget = [];
    // print(widget.inputs.runtimeType);
    (json.decode(
                widget.inputs is Map ? widget.inputs.toString() : widget.inputs)
            as Map)
        .forEach((key, value) {
      inputsWidget.add(
        Divider(
          color: blueColor,
          thickness: 1,
        ),
      );
      inputsWidget.add(Center(
        child: value.toString().contains(".jpg")
            ? Image(
                errorBuilder: (context, error, stackTrace) =>
                    Image(image: AssetImage("images/error.gif")),
                image: NetworkImage(MyApp.hostName + "/api/uploads/" + value),
                fit: BoxFit.fill,
              )
            : MyText(
                content: key.toString() + " : " + value.toString(),
              ),
      ));
    });
    String? date1;
    if (widget.date != null) {
      date1 = DateFormat('yyyy/MM/dd – kk:mm').format(widget.date!);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Center(
                  child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: const Color(0x000000),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.2), BlendMode.dstATop),
                        image: notificationsImage)),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.title1 != null
                      ? Center(
                          child: MyText(
                            content: widget.title1,
                          ),
                        )
                      : Container(),
                      Divider(
                  color: blueColor,
                  thickness: 1,
                ),
                  widget.title != null
                      ? Center(
                          child: MyText(
                            content: widget.title,
                          ),
                        )
                      : Container(),
                  Divider(
                    color: blueColor,
                    thickness: 1,
                  ),
                  widget.content != null
                      ? MyText(
                          content: "النتيجة : " + widget.content!,
                          bold: false,
                        )
                      : Container(),
                  Divider(
                    color: blueColor,
                    thickness: 1,
                  ),
                  widget.date != null
                      ? MyText(
                          content: "تاريخ الطلب : " + date1!,
                          bold: false,
                        )
                      : Container(),
                  Divider(
                    color: blueColor,
                    thickness: 1,
                  ),
                  Center(
                    child: MyText(
                      content: "المدخلات",
                    ),
                  ),
                  ...inputsWidget,
                  Divider(
                    color: blueColor,
                    thickness: 1,
                  ),
                  SizedBox(
                      width: Get.mediaQuery.size.width - 30,
                      child: MyText(
                        bold: false,
                        content: "التكلفة : " + (widget.cost ??= "غير معروف"),
                      )),
                  Divider(
                    color: blueColor,
                    thickness: 1,
                  ),
                  (!widget.askOrderSent! ?? false) &&
                          widget.bill != "0" &&
                          widget.cost != "0"
                      ? Column(
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  decoration: linearGradientbox,
                                  child: InkWell(
                                    onTap: () {
                                      var dataProcess =
                                          json.decode(widget.inputs);
                                      dataProcess['bill'] = widget.bill;
                                      dataProcess['cost'] = widget.cost;
                                      dataProcess['subcat_id'] =
                                          widget.subcatId;
                                      dataProcess['type'] = 1;
                                      dataProcess['paid'] = 1;
                                      dataProcess['order_id'] =
                                          widget.orderId.toString();
                                      setState(() {
                                        widget.askOrderSent = true;
                                      });
                                      Get.to(() => Container(
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            color: Colors.white,
                                          ));

                                      MyConst.afterSubCatPagesController
                                          .addOrder(dataProcess, 0, true);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MyText(
                                        content: "تسديد",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: blueColor,
                              thickness: 1,
                            ),
                          ],
                        )
                      : Container(),
                  Center(
                    child: MyText(
                      content: (widget.finished == "0"
                          ? "قيد الانتظار"
                          : (widget.finished == "1"
                              ? "تمت العملية"
                              : "العملية ملغاة")),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
