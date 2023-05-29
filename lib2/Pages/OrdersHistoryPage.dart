// ignore_for_file: file_names, curly_braces_in_flow_control_structures, prefer_const_constructors, sized_box_for_whitespace, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:get/get.dart';

import 'package:web_application/Constant.dart';
import 'package:web_application/Models/OrderModel.dart';

import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';
import 'package:web_application/widgets/OrderHistoryWidget.dart';

// ignore: must_be_immutable
class OrderHistoryPage extends StatefulWidget {
  List<Widget> orders = [];
  OrderHistoryPage({Key? key}) : super(key: key);

  TextEditingController textEditingController = TextEditingController();

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    MyConst.userGetXController.inialSearchPage();
    if (MyConst.userGetXController.ordersAsk != null)
      MyConst.userGetXController.getorderHistory();
    super.initState();
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
                  image: ordersHistoryImage,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              MyText(
                content: "سجل الإستعلامات",
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
          if (MyConst.userGetXController.isLoading.value)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (MyConst.userGetXController.ordersAsk.value == null)
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: MyText(
                  content:
                      "هناك مشكلة في الاتصال بالانترنت يرجى إعادة المحاولة",
                ),
              ),
            );
          else if (MyConst.userGetXController.ordersAsk.value.isNotEmpty) {
            if (!MyConst.userGetXController.isSearchedAsk.value) {
              widget.orders.clear();
              for (int i =
                      MyConst.userGetXController.ordersAsk.value.length - 1;
                  i >= 0;
                  i--) {
                    
                widget.orders.add(OrderHisotryWidget(
                  title: MyConst.userGetXController.ordersAsk.value
                          .elementAt(i)
                          .title ??
                      "",
                  inputs: MyConst.userGetXController.ordersAsk.value
                          .elementAt(i)
                          .inputs ??
                      "",
                  content: MyConst.userGetXController.ordersAsk.value
                          .elementAt(i)
                          .content ??
                      "لا يوجد نتائج",
                  date: MyConst.userGetXController.ordersAsk.value
                      .elementAt(i)
                      .dateTime,
                  bill: MyConst.userGetXController.ordersAsk.value
                      .elementAt(i)
                      .bill,
                  cost: MyConst.userGetXController.ordersAsk.value
                      .elementAt(i)
                      .cost,
                  subcatId: MyConst.userGetXController.ordersAsk.value
                      .elementAt(i)
                      .subcatsId,
                  finished: MyConst.userGetXController.ordersAsk.value
                      .elementAt(i)
                      .finished,
                  askOrderSent: MyConst.userGetXController.ordersAsk.value
                      .elementAt(i)
                      .askOrderSent,
                  orderId: MyConst.userGetXController.ordersAsk.value
                      .elementAt(i)
                      .id,
                      title1: MyConst.userGetXController.ordersAsk.value
                      .elementAt(i)
                      .catName
                ));
              }
            } else {
              widget.orders.clear();
              for (OrderModel item
                  in MyConst.userGetXController.searchedAskOrders.value) {
                widget.orders.add(OrderHisotryWidget(
                  title: item.title ?? "",
                  content: item.content ?? "لا يوجد نتائج",
                  date: item.dateTime!,
                  inputs: item.inputs!,
                  bill: item.bill!,
                  cost: item.cost!,
                  subcatId: item.subcatsId!,
                  finished: item.finished!,
                  askOrderSent: item.askOrderSent!,
                  orderId: item.id!,
                  title1: item.catName!,
                ));
              }
            }
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  isEmail: true,
                  isPassword: false,
                  hintText: "اسم الخدمة أو تاريخها أو نتيجتها",
                  icon: Icons.search,
                  controller: widget.textEditingController,
                  function: (value) {
                    MyConst.userGetXController.searchOnOrderAsk(value, null);
                  },
                ),
                InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        locale: DateTimePickerLocale.ar,
                        initialDateTime: DateTime.now(),
                        onChange: (dateTime, selectedIndex) {
                          MyConst.userGetXController
                              .searchOnOrderAsk(null, dateTime);
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: blueColor)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.date_range,
                                color: blueColor,
                                size: 35,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MyText(
                                content: "إضغط لإختيار التاريخ",
                                bold: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: blueColor,
                  thickness: 1,
                ),
                Column(
                  children: widget.orders,
                ),
              ],
            );
          } else
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: MyText(
                  content: "لا يوجد استعلامات بعد",
                ),
              ),
            );
        }),
        SizedBox(
          height: 200,
        )
      ],
    );
  }
}
