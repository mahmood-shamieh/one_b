// ignore_for_file: file_names, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, prefer_is_empty, curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';

import 'package:web_application/GetXController/CompanyBillsController.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';

// ignore: must_be_immutable
class CompanyBillsPayment extends StatefulWidget {
  String? hint;
  CompanyBillsController? controller;
  String? name;
  double? balance;
  CompanyBillsPayment({Key? key, this.name, this.hint, this.balance})
      : super(key: key);

  @override
  _CompanyBillsPaymentState createState() => _CompanyBillsPaymentState();
}

class _CompanyBillsPaymentState extends State<CompanyBillsPayment> {
  String value = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder(
          init: CompanyBillsController(),
          builder: (controller) {
            widget.controller = controller as CompanyBillsController;
            List<Widget> items = [];
            for (var i = 0; i < widget.controller!.phonesnumber.value; i++) {
              TextEditingController textEditingController =
                  TextEditingController();
              textEditingController.text =
                  (i > widget.controller!.getNumberValues().length - 1
                      ? ""
                      : widget.controller!.getNumberValues().elementAt(i));
              items.add(
                MyTextField(
                  id: i,
                  hintText: widget.hint!,
                  icon: Icons.mobile_friendly,
                  isEmail: true,
                  isPassword: false,
                  keyboardType: TextInputType.number,
                  bill: false,
                  controller: textEditingController,
                ),
              );
              items.add(
                SizedBox(
                  height: 6,
                ),
              );
              
              TextEditingController textEditingController1 =
                  TextEditingController();
              textEditingController1.text =
                  (widget.controller!.getMoneyValues().length - 1 < i
                      ? ""
                      : widget.controller!.getMoneyValues().elementAt(i));
              items.add(SizedBox(
                width: Get.mediaQuery.size.width - 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: Get.mediaQuery.size.width / 2 - 35,
                      child: MyTextField(
                        id: i,
                        hintText: "القيمة المالية",
                        icon: Icons.money,
                        isEmail: true,
                        isPassword: false,
                        bill: true,
                        keyboardType: TextInputType.number,
                        controller: textEditingController1,
                        function: (_) {},
                      ),
                    ),
                  ],
                ),
              ));
              items.add(SizedBox(
                height: 6,
              ));
              if (widget.controller!.phonesnumber.value != 1)
                {items.add(RaisedButton(
                  onPressed: (){
                    widget.controller!.deleteWidget(i);
                  } ,
                  child: MyText(
                    content: "إلغاء الحقل",
                    color: white,
                    size: 16,
                  ),
                ));
              items.add(
                SizedBox(
                  height: 6,
                ),
              );}
            }
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListBody(children: [
                Column(
                  children: [
                    ...items,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(blueColor),
                          ),
                          onPressed: () {
                            int cost = 0;
                            for (int k = 0; k < items.length; k++) {
                              if (items.elementAt(k) is SizedBox) {
                                if ((items.elementAt(k) as SizedBox).child
                                    is Row)
                                  ((items.elementAt(k) as SizedBox).child
                                          as Row)
                                      .children
                                      .forEach((element) {
                                    if (element is SizedBox) {
                                      // ignore: unnecessary_cast
                                      if ((element as SizedBox).child
                                          is MyTextField)
                                        cost = cost +
                                            int.parse((element.child
                                                        as MyTextField)
                                                    .controller!
                                                    .text
                                                    .isEmpty
                                                ? "0"
                                                : (element.child as MyTextField)
                                                    .controller!
                                                    .text);
                                    }
                                  });
                              }
                            }
                            Get.dialog(Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText(
                                      content: "مجموع الفواتير المدخلة",
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MyText(
                                          content: cost.toString(),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          // ignore: prefer_const_literals_to_create_immutables
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1,
                                                blurRadius: 0.3)
                                          ]),
                                    ),
                                    Divider(
                                      color: blueColor,
                                      thickness: 1.2,
                                    ),
                                    MyText(
                                      content: "القيمة المخصومة",
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MyText(
                                          content:
                                              (cost * widget.balance! / 100 +
                                                      cost)
                                                  .toString(),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          // ignore: prefer_const_literals_to_create_immutables
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1,
                                                blurRadius: 0.3)
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  blueColor),
                                        ),
                                        onPressed: () => Get.back(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RichText(
                                            text: TextSpan(
                                                text: "الرجوع",
                                                style: GoogleFonts.elMessiri(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ));
                          },
                          child: RichText(
                            text: TextSpan(
                                text: "معرفة الكلفة",
                                style: GoogleFonts.elMessiri(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(blueColor),
                          ),
                          onPressed: () {
                            widget.controller!.addWidget();
                            widget.controller!.getNumberValues().clear();
                            widget.controller!.getMoneyValues().clear();
                            for (int k = 0; k < items.length; k++) {
                              if (items.elementAt(k) is SizedBox) {
                                if ((items.elementAt(k) as SizedBox).child
                                    is Row)
                                  ((items.elementAt(k) as SizedBox).child
                                          as Row)
                                      .children
                                      .forEach((element) {
                                    if (element is SizedBox) {
                                      // ignore: unnecessary_cast
                                      if ((element as SizedBox).child
                                          is MyTextField)
                                        widget.controller!.getMoneyValues().add(
                                            (element.child as MyTextField)
                                                .controller!
                                                .text);
                                    }
                                  });
                              }
                              if (items.elementAt(k) is MyTextField) {
                                MyTextField temp =
                                    items.elementAt(k) as MyTextField;
                                if (!temp.bill!) {
                                  widget.controller!
                                      .getNumberValues()
                                      .add(temp.controller!.text);
                                }
                              }
                            }
                            widget.controller!.getMoneyValues().add("");
                            widget.controller!.getNumberValues().add("");
                            widget.controller!.getBillsValues().add("");
                          },
                          child: RichText(
                            text: TextSpan(
                                text: "إضافة رقم",
                                style: GoogleFonts.elMessiri(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ]),
            );
          }),
    );
  }
}
