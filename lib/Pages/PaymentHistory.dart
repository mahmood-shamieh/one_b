// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, sized_box_for_whitespace, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:web_application/Constant.dart';
import 'package:web_application/GetXController/PaymentHistoryGetxController.dart';
import 'package:web_application/Models/ChartModel.dart';
import 'package:web_application/Models/OrderModel.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';
import 'package:web_application/widgets/PaymentWidget.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class PaymentHistroy extends StatefulWidget {
  List<Widget> orders = [];
  TextEditingController textEditingController = TextEditingController();
  PaymentHistoryGetXController paymentHistoryGetXController =
      Get.put(PaymentHistoryGetXController());
  PaymentHistroy({Key? key}) : super(key: key);

  @override
  _PaymentHistroyState createState() => _PaymentHistroyState();
}

class _PaymentHistroyState extends State<PaymentHistroy> {
  // ignore: non_constant_identifier_names
  List<ChartModel> chart_data = [];
  // ignore: non_constant_identifier_names
  Map dataForGraph = {};

  @override
  void initState() {
    
    MyConst.userGetXController.inialSearchPage();
    MyConst.userGetXController.getAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Obx(() {
            if (MyConst.userGetXController.isLoading.value)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (MyConst.userGetXController.orders.value == null)
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
            else if (MyConst.userGetXController.orders.value.isEmpty)
              return Center(
                child: Container(
                  height: 200,
                  child: MyText(
                    content: "لا يوجد بيانات بعد",
                  ),
                ),
              );
            else if (MyConst.userGetXController.orders.value.isNotEmpty) {
              widget.orders.clear();
              chart_data.clear();
              dataForGraph = {};

              if (!MyConst.userGetXController.isSearched.value) {
                for (int i = MyConst.userGetXController.orders.value.length - 1;
                    i >= 0;
                    i--) {
                  if (!dataForGraph.containsKey(MyConst
                      .userGetXController.orders.value
                      .elementAt(i)
                      .title))
                    dataForGraph[MyConst.userGetXController.orders.value
                        .elementAt(i)
                        .title] = 1;
                  else
                    dataForGraph[MyConst.userGetXController.orders.value
                        .elementAt(i)
                        .title] = dataForGraph[MyConst
                            .userGetXController.orders.value
                            .elementAt(i)
                            .title] +
                        1;
                  widget.orders.add(PaymentWidget(
                    finished: MyConst.userGetXController.orders.value
                        .elementAt(i)
                        .finished,
                        inputs: MyConst.userGetXController.orders.value
                        .elementAt(i)
                        .inputs,
                    cahceBefor: MyConst.userGetXController.orders.value
                            .elementAt(i)
                            .bill ??
                        "",
                    caheAfter: MyConst.userGetXController.orders.value
                            .elementAt(i)
                            .cost ??
                        "",
                    date: MyConst.userGetXController.orders.value
                        .elementAt(i)
                        .dateTime,
                    subCatName: MyConst.userGetXController.orders.value
                            .elementAt(i)
                            .title ??
                        "",
                    content: MyConst.userGetXController.orders.value
                            .elementAt(i)
                            .content ??
                        "",
                        date2: MyConst.userGetXController.orders.value
                            .elementAt(i)
                            .finishDate,
                            catName: MyConst.userGetXController.orders.value
                            .elementAt(i)
                            .catName,
                  ));
                }
                dataForGraph.forEach((key, value) {
                  chart_data.add(ChartModel(title: key, value: value));
                });
              } else {
                widget.orders.clear();
                for (OrderModel item
                    in MyConst.userGetXController.searchedOrders.value) {
                  if (!dataForGraph.containsKey(item.title))
                    dataForGraph[item.title] = 1;
                  else
                    dataForGraph[item.title] = dataForGraph[item.title] + 1;
                  widget.orders.add(PaymentWidget(
                    finished: item.finished!,
                    cahceBefor: item.bill ?? "",
                    caheAfter: item.cost ?? "",
                    date: item.dateTime!,
                    subCatName: item.title ?? "",
                    content: item.content ?? "",
                    date2: item.finishDate!,
                    inputs: item.inputs,
                    catName: item.catName ?? "",
                  ));
                }

                dataForGraph.forEach((key, value) {
                  chart_data.add(ChartModel(title: key, value: value));
                });
              }

              return Column(
                children: [
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              widget.paymentHistoryGetXController.toGraphPage();
                            },
                            child: MyText(
                              content: "مخطط",
                              color: widget.paymentHistoryGetXController
                                      .graphPage.value
                                  ? blueColor
                                  : Colors.grey,
                            )),
                        TextButton(
                            onPressed: () {
                              widget.paymentHistoryGetXController
                                  .toHistoryPage();
                            },
                            child: MyText(
                              content: "سجل",
                              color: widget.paymentHistoryGetXController
                                      .historyPage.value
                                  ? blueColor
                                  : Colors.grey,
                            )),
                      ],
                    ),
                  ),
                  widget.paymentHistoryGetXController.historyPage.value
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                MyConst.userGetXController
                                    .searchOnOrder(value, null);
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
                                          .searchOnOrder(null, dateTime);
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
                                color: blueColor,size: 35 ,
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
                            
                            Divider(
                              color: blueColor,
                              thickness: 1,
                            ),
                            Column(
                              children: widget.orders,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: SfCircularChart(
                                tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                    textStyle: GoogleFonts.elMessiri(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                title: ChartTitle(
                                    text: "مخطط بياني يوضح المدفوعات الشهرية",
                                    textStyle: GoogleFonts.elMessiri(
                                        color: blueColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                legend: Legend(
                                    isVisible: true,
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    isResponsive: true,
                                    alignment: ChartAlignment.center,
                                    width:
                                        (MediaQuery.of(context).size.width - 20)
                                            .toString(),
                                    itemPadding: 10,
                                    textStyle: GoogleFonts.elMessiri(
                                        color: blueColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                series: <CircularSeries>[
                                  PieSeries<ChartModel, String>(
                                      dataSource: chart_data,
                                      xValueMapper: (ChartModel model, _) =>
                                          model.title,
                                      yValueMapper: (ChartModel model, _) =>
                                          model.value,
                                      dataLabelSettings: DataLabelSettings(
                                          isVisible: true,
                                          alignment: ChartAlignment.center,
                                          margin: EdgeInsets.all(2),
                                          textStyle: GoogleFonts.elMessiri(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)))
                                ],
                              ),
                            ),
                          ],
                        )
                ],
              );
            } else
              return Container(
                height: 200,
                child: MyText(
                  content:
                      "هناك مشكلة في الاتصال بالانترنت يرجى إعادة المحاولة",
                ),
              );
          }),
        )
      ],
    );
  }
}


