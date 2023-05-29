// ignore_for_file: file_names, curly_braces_in_flow_control_structures, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, avoid_function_literals_in_foreach_calls, unnecessary_string_escapes, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/GetXController/BillsValueController.dart';

import 'package:web_application/Models/DropDownButtonModel.dart';
import 'package:web_application/Models/ImageLodaer.dart';
import 'package:web_application/Models/TextFieldModel.dart';
import 'package:web_application/Pages/CompanyBillsPayment.dart';
import 'package:web_application/widgets/AppBar.dart';
import 'package:web_application/widgets/ImageLoaderWidget.dart';

import 'package:web_application/widgets/MyDropDownButton.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';
import 'package:web_application/widgets/PaymentPageHeader.dart';

// ignore: must_be_immutable
class PaymentPageprces extends StatefulWidget {
  String? title;
  String? subCatId;
  bool? local;
  String? buttons;
  // this is the benifits
  double? bounce;
  Map<String, TextEditingController> controllers = {};
  Map<String, dynamic> data = {};
  PaymentPageprces(
      {Key? key,
      this.title,
      this.subCatId,
      this.local,
      this.buttons,
      this.bounce})
      : super(key: key);

  @override
  _PaymentPageprcesState createState() => _PaymentPageprcesState();
}

class _PaymentPageprcesState extends State<PaymentPageprces> {
  @override
  void initState() {
    MyConst.afterSubCatPagesController.getConatinent({
      'subcat_id': widget.subCatId,
      'user_id': MyConst.profilePageController.userModel.value.id
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool haveBillMenu = false;
    bool haveMultiTextField = false;
    bool haveImagesLoaders = false;
    MyDropDownButton? billMenu = null;
    // ignore: avoid_init_to_null, unused_local_variable
    CompanyBillsPayment? billFormMultiTextField = null;
    TextEditingController billController = TextEditingController();
    List<Widget> items = [];
    List<MyTextField> textFields = [];
    List<MyDropDownButton> dropDownButtons = [];
    List<CompanyBillsPayment> multiTextFields = [];
    List<ImageLoaderWidget> imageLoaders = [];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: MyAppBar(),
          body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListBody(children: [
                  PayMentPageheader(
                    title: widget.title!,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.local!
                          ? Column(
                              children: items,
                            )
                          : Obx(() {
                              if (MyConst
                                  .afterSubCatPagesController.isLoading.value)
                                // ignore: prefer_const_constructors
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              else if (MyConst
                                          // ignore: invalid_use_of_protected_member
                                          .afterSubCatPagesController
                                          .dropDowns
                                          // ignore: invalid_use_of_protected_member
                                          .value ==
                                      null &&
                                  MyConst
                                          .afterSubCatPagesController
                                          .multiTextField
                                          // ignore: invalid_use_of_protected_member
                                          .value ==
                                      null &&
                                  // ignore: invalid_use_of_protected_member
                                  MyConst
                                          .afterSubCatPagesController
                                          .textFields
                                          // ignore: invalid_use_of_protected_member
                                          .value ==
                                      null &&
                                  // ignore: invalid_use_of_protected_member
                                  MyConst
                                          .afterSubCatPagesController
                                          .imageLoaders
                                          // ignore: invalid_use_of_protected_member
                                          .value ==
                                      null) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 200,
                                    child: MyText(
                                      content:
                                          "لا يوجد اتصال بالإنترنت يرجى إعادة المحاولة لاحقا",
                                    ),
                                  ),
                                );
                              } else {
                                items.clear();
                                dropDownButtons.clear();
                                textFields.clear();
                                multiTextFields.clear();
                                imageLoaders.clear();
                                haveBillMenu = false;
                                haveMultiTextField = false;
                                haveImagesLoaders = false;
                                for (DropDownButtonModel item in MyConst
                                    // ignore: invalid_use_of_protected_member
                                    .afterSubCatPagesController
                                    .dropDowns
                                    // ignore: invalid_use_of_protected_member
                                    .value) {
                                  // ignore: unnecessary_new
                                  MyDropDownButton m = new MyDropDownButton(
                                    items: item.data!,
                                    name: item.englishName!,
                                    label: item.arabicName!,
                                    billMenu: item.bill!,
                                  );
                                  if (item.bill!) {
                                    haveBillMenu = true;
                                    billMenu = m;
                                  }
                                  dropDownButtons.add(m);
                                }

                                if (MyConst
                                        .afterSubCatPagesController
                                        // ignore: invalid_use_of_protected_member
                                        .textFields
                                        .value !=
                                    null)
                                  for (TextFieldModel item in MyConst
                                      // ignore: invalid_use_of_protected_member
                                      .afterSubCatPagesController
                                      .textFields
                                      // ignore: invalid_use_of_protected_member
                                      .value) {
                                    // ignore: unnecessary_new
                                    MyTextField m = new MyTextField(
                                      hintText: item.arabicName!,
                                      name: item.name!,
                                      isEmail: true,
                                      isPassword: false,
                                      icon: Icons.text_fields,
                                      controller: TextEditingController(),
                                    );
                                    textFields.add(m);
                                  }
                                for (TextFieldModel item in MyConst
                                    // ignore: invalid_use_of_protected_member
                                    .afterSubCatPagesController
                                    .multiTextField
                                    // ignore: invalid_use_of_protected_member
                                    .value) {
                                  haveMultiTextField = true;
                                  CompanyBillsPayment m = CompanyBillsPayment(
                                    hint: item.arabicName,
                                    name: item.name,
                                    balance: widget.bounce,
                                  );
                                  billFormMultiTextField = m;
                                  multiTextFields.add(m);
                                }
                                for (ImageLoader item in MyConst
                                    .afterSubCatPagesController
                                    .imageLoaders
                                    .value) {
                                  haveImagesLoaders = true;
                                  imageLoaders.add(ImageLoaderWidget(
                                    hintText: item.arabic_name!,
                                    name: item.english_name!,
                                  ));
                                }
                                imageLoaders.forEach((element) {
                                  items.add(element);
                                  items.add(SizedBox(
                                    height: 8,
                                  ));
                                });
                                dropDownButtons.forEach((e) {
                                  items.add(e);
                                  items.add(SizedBox(
                                    height: 8,
                                  ));
                                });
                                textFields.forEach((e) {
                                  items.add(e);
                                  items.add(SizedBox(
                                    height: 8,
                                  ));
                                });
                                multiTextFields.forEach((e) {
                                  items.add(e);
                                  items.add(SizedBox(
                                    height: 8,
                                  ));
                                });

                                if (!haveBillMenu &&
                                    !haveMultiTextField &&
                                    !haveImagesLoaders &&
                                    widget.buttons != '0')
                                  items.add(Column(
                                    children: [
                                      GetBuilder(
                                          init: BillsController(
                                              bounce: widget.bounce ?? 0),
                                          builder: (controller) => Column(
                                                children: [
                                                  MyTextField(
                                                    hintText: "القيمة المالية",
                                                    name: "bill",
                                                    isEmail: true,
                                                    isPassword: false,
                                                    icon: Icons.text_fields,
                                                    controller: billController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    function: (value) {
                                                      (controller
                                                              as BillsController)
                                                          .myUpdate(
                                                              double.parse(
                                                                  value == ""
                                                                      ? "0"
                                                                      : value));
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        child: MyText(
                                                          content:
                                                              "القيمة المقطوعة",
                                                        ),
                                                        width: Get
                                                                    .mediaQuery
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            20,
                                                      ),
                                                      Container(
                                                          width: Get
                                                                      .mediaQuery
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              20,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    spreadRadius:
                                                                        1,
                                                                    blurRadius:
                                                                        0.3)
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          35)),
                                                          child: Center(
                                                            child: MyText(
                                                                content: (controller
                                                                        as BillsController)
                                                                    .finalValue
                                                                    .toString()),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      widget.buttons == "1" ? Container() :MyText(
                                        content:
                                            "في حال كنت تريد الاستعلام عن معلوماتك المدخلة فقط اترك حقل القيمة المالية فارغ ",
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ));

                                return Column(
                                  children: [
                                    Column(
                                      children: items,
                                    ),
                                    if (widget.buttons == '0')
                                      Row(
                                        children: [
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              bool testForEmptyInput = false;
                                              textFields.forEach((element) {
                                                if (element
                                                    .controller!.text.isEmpty)
                                                  testForEmptyInput = true;
                                              });
                                              dropDownButtons
                                                  .forEach((element) {
                                                if (element.chosenItem!.isEmpty)
                                                  testForEmptyInput = true;
                                              });
                                              imageLoaders.forEach((element) {
                                                if (element.getFile() == null)
                                                  testForEmptyInput = true;
                                              });
                                              multiTextFields
                                                  .forEach((element) {
                                                if (element.controller!
                                                    .getNumberValues()
                                                    .isEmpty)
                                                  testForEmptyInput = true;
                                                if (element.controller!
                                                        .getBillsValues()
                                                        .isEmpty &&
                                                    !element.controller!
                                                        .checkInput())
                                                  testForEmptyInput = true;
                                              });
                                              if (testForEmptyInput) {
                                                showAlertDialog(context, [
                                                  Center(
                                                    child: Text(
                                                      "يرجى ملئ كافة البيانات بالأسلوب الصحيح",
                                                      style: GoogleFonts.cairo(
                                                          color: blueColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ], [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        "إلغاء",
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )),
                                                ]);
                                              } else {
                                                showAlertDialog(context, [
                                                  Center(
                                                    child: Text(
                                                      "هل أنت متأكد؟؟",
                                                      style: GoogleFonts.cairo(
                                                          color: blueColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ], [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        "إلغاء",
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )),
                                                  TextButton(
                                                    onPressed: () {
                                                      textFields
                                                          .forEach((element) {
                                                        widget.data[
                                                                element.name!] =
                                                            element
                                                                .controller!.text
                                                                .toString();
                                                      });
                                                      dropDownButtons
                                                          .forEach((element) {
                                                        widget.data[
                                                            element.name!] = [
                                                          element.chosenItem![0]
                                                              .name
                                                              .toString(),
                                                          element.chosenItem![0]
                                                              .bill
                                                              .toString()
                                                        ].toString();
                                                      });
                                                      imageLoaders
                                                          .forEach((element) {
                                                        widget.data[
                                                                element.name!] =
                                                            element
                                                                .getFileName();
                                                        widget.data[
                                                                element.name! +
                                                                    "_image"] =
                                                            element.getFile();
                                                      });
                                                      multiTextFields
                                                          .forEach((element) {
                                                        widget.data[
                                                            element
                                                                .name!] = element
                                                            .controller!
                                                            .getNumberValues()
                                                            .toString();
                                                      });
                                                      widget.data['bill'] = '0';
                                                      widget.data['type'] = "0";
                                                      widget.data['subcat_id'] =
                                                          widget.subCatId;
                                                      
                                                      Get.to(() => Container(
                                                            color: Colors.white,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          ));
                                                      MyConst
                                                          .afterSubCatPagesController
                                                          .addOrder(widget.data,
                                                              1, false);
                                                    },
                                                    child: Text(
                                                      "تأكيد",
                                                      style: GoogleFonts.cairo(
                                                          color: Colors.red,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ]);
                                              }
                                            },
                                            child: Center(
                                              child: Container(

                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    gradient: linearGradient),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(Icons.done_all,
                                                          color: Colors.white),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      MyText(
                                                        content: "إستعلام",
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      )
                                    else if (widget.buttons == '1')
                                      Row(
                                        children: [
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              bool testForEmptyInput = false;
                                              textFields.forEach((element) {
                                                if (element
                                                    .controller!.text.isEmpty)
                                                  testForEmptyInput = true;
                                              });
                                              dropDownButtons
                                                  .forEach((element) {
                                                if (element.chosenItem!.isEmpty)
                                                  testForEmptyInput = true;
                                              });
                                              imageLoaders.forEach((element) {
                                                if (element.getFile() == null)
                                                  testForEmptyInput = true;
                                              });
                                              multiTextFields
                                                  .forEach((element) {
                                                if (element.controller!
                                                    .getNumberValues()
                                                    .isEmpty)
                                                  testForEmptyInput = true;
                                                if (element.controller!
                                                        .getBillsValues()
                                                        .isEmpty &&
                                                    !element.controller!
                                                        .checkInput())
                                                  testForEmptyInput = true;
                                              });
                                              if (testForEmptyInput) {
                                                showAlertDialog(context, [
                                                  Center(
                                                    child: Text(
                                                      "يرجى ملئ كافة البيانات بالأسلوب الصحيح",
                                                      style: GoogleFonts.cairo(
                                                          color: blueColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ], [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        "إلغاء",
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )),
                                                ]);
                                              } else {
                                                showAlertDialog(context, [
                                                  Center(
                                                    child: Text(
                                                      "هل أنت متأكد؟؟",
                                                      style: GoogleFonts.cairo(
                                                          color: blueColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ], [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        "إلغاء",
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )),
                                                  TextButton(
                                                    onPressed: () {
                                                      textFields
                                                          .forEach((element) {
                                                        widget.data[
                                                                element.name!] =
                                                            element
                                                                .controller!.text
                                                                .toString();
                                                      });
                                                      dropDownButtons
                                                          .forEach((element) {
                                                        widget.data[
                                                            element.name!] = [
                                                          element.chosenItem![0]
                                                              .name
                                                              .toString(),
                                                          element.chosenItem![0]
                                                              .bill
                                                              .toString()
                                                        ].toString();
                                                      });
                                                      imageLoaders
                                                          .forEach((element) {
                                                        widget.data[
                                                                element.name!] =
                                                            element
                                                                .getFileName();
                                                        widget.data[
                                                                element.name! +
                                                                    "_image"] =
                                                            element.getFile();
                                                      });
                                                      multiTextFields
                                                          .forEach((element) {
                                                        widget.data[
                                                            element
                                                                .name!] = element
                                                            .controller!
                                                            .getNumberValues()
                                                            .toString();
                                                      });
                                                     
                                                      widget.data['bill'] =
                                                          haveBillMenu
                                                              ? billMenu!
                                                                  .chosenItem![0]
                                                                  .bill
                                                              : (haveMultiTextField
                                                                  ? billFormMultiTextField!
                                                                      .controller!
                                                                      .getMoneyValues() 
                                                                      .toString()
                                                                  : billController
                                                                      .text);
                                                      widget.data['type'] = "1";
                                                      widget.data['subcat_id'] =
                                                          widget.subCatId;
                                                      
                                                      Get.to(() => Container(
                                                            color: Colors.white,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          ));
                                                      MyConst
                                                          .afterSubCatPagesController
                                                          .addOrder(widget.data,
                                                              1, false);
                                                    },
                                                    child: Text(
                                                      "تأكيد",
                                                      style: GoogleFonts.cairo(
                                                          color: Colors.red,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ]);
                                              }
                                            },
                                            child: Center(
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    gradient: linearGradient),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(Icons.done_all,
                                                          color: Colors.white),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      MyText(
                                                        content: "دفع",
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      )
                                    else if (widget.buttons == '3')
                                      Row(
                                        children: [
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              bool testForEmptyInput = false;
                                              textFields.forEach((element) {
                                                if (element
                                                    .controller!.text.isEmpty)
                                                  testForEmptyInput = true;
                                              });
                                              dropDownButtons
                                                  .forEach((element) {
                                                if (element.chosenItem!.isEmpty)
                                                  testForEmptyInput = true;
                                              });
                                              imageLoaders.forEach((element) {
                                                if (element.getFile() == null)
                                                  testForEmptyInput = true;
                                              });
                                              multiTextFields
                                                  .forEach((element) {
                                                if (element.controller!
                                                    .getNumberValues()
                                                    .isEmpty)
                                                  testForEmptyInput = true;
                                                if (element.controller!
                                                        .getBillsValues()
                                                        .isEmpty &&
                                                    !element.controller!
                                                        .checkInput())
                                                  testForEmptyInput = true;
                                              });
                                              if (testForEmptyInput) {
                                                showAlertDialog(context, [
                                                  Center(
                                                    child: Text(
                                                      "يرجى ملئ كافة البيانات بالأسلوب الصحيح",
                                                      style: GoogleFonts.cairo(
                                                          color: blueColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ], [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        "إلغاء",
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )),
                                                ]);
                                              } else {
                                                showAlertDialog(context, [
                                                  Center(
                                                    child: Text(
                                                      "هل أنت متأكد؟؟",
                                                      style: GoogleFonts.cairo(
                                                          color: blueColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ], [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        "إلغاء",
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )),
                                                  TextButton(
                                                    onPressed: () {
                                                      textFields
                                                          .forEach((element) {
                                                        widget.data[
                                                                element.name!] =
                                                            element
                                                                .controller!.text
                                                                .toString();
                                                      });
                                                      dropDownButtons
                                                          .forEach((element) {
                                                        widget.data[
                                                            element.name!] = [
                                                          element.chosenItem![0]
                                                              .name
                                                              .toString(),
                                                          element.chosenItem![0]
                                                              .bill
                                                              .toString()
                                                        ].toString();
                                                      });
                                                      imageLoaders
                                                          .forEach((element) {
                                                        widget.data[
                                                                element.name!] =
                                                            element
                                                                .getFileName();
                                                        widget.data[
                                                                element.name! +
                                                                    "_image"] =
                                                            element.getFile();
                                                      });
                                                      multiTextFields
                                                          .forEach((element) {
                                                        widget.data[
                                                            element
                                                                .name!] = element
                                                            .controller!
                                                            .getNumberValues() 
                                                            .toString();
                                                      });
                                                      
                                                      widget.data[
                                                              'bill'] = 
                                                          '0';
                                                      widget.data['type'] = "3";
                                                      widget.data['subcat_id'] =
                                                          widget.subCatId;
                                                      
                                                      Get.to(() => Container(
                                                            color: Colors.white,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          ));
                                                      MyConst
                                                          .afterSubCatPagesController
                                                          .addOrder(widget.data,
                                                              1, false);
                                                    },
                                                    child: Text(
                                                      "تأكيد",
                                                      style: GoogleFonts.cairo(
                                                          color: Colors.red,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ]);
                                              }
                                            },
                                            child: Center(
                                              child: Container(

                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    gradient: linearGradient),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(Icons.done_all,
                                                          color: Colors.white),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      MyText(
                                                        content: "تقديم الطلب",
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      )
                                    else
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  bool testForEmptyInput =
                                                      false;
                                                  textFields.forEach((element) {
                                                    if (element.controller!.text
                                                        .isEmpty)
                                                      testForEmptyInput = true;
                                                  });
                                                  dropDownButtons
                                                      .forEach((element) {
                                                    if (element
                                                        .chosenItem!.isEmpty)
                                                      testForEmptyInput = true;
                                                  });
                                                  imageLoaders
                                                      .forEach((element) {
                                                    if (element.getFile() ==
                                                        null)
                                                      testForEmptyInput = true;
                                                  });
                                                  multiTextFields
                                                      .forEach((element) {
                                                    if (element.controller!
                                                        .getNumberValues()
                                                        .isEmpty)
                                                      testForEmptyInput = true;
                                                    if (element.controller!
                                                            .getBillsValues()
                                                            .isEmpty &&
                                                        !element.controller!
                                                            .checkInput())
                                                      testForEmptyInput = true;
                                                  });
                                                  if (testForEmptyInput) {
                                                    showAlertDialog(context, [
                                                      Center(
                                                        child: Text(
                                                          "يرجى ملئ كافة البيانات بالأسلوب الصحيح",
                                                          style:
                                                              GoogleFonts.cairo(
                                                                  color:
                                                                      blueColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      )
                                                    ], [
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                            "إلغاء",
                                                            style: GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                    ]);
                                                  } else {
                                                    showAlertDialog(context, [
                                                      Center(
                                                        child: Text(
                                                          "هل أنت متأكد؟؟",
                                                          style:
                                                              GoogleFonts.cairo(
                                                                  color:
                                                                      blueColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ], [
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                            "إلغاء",
                                                            style: GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                      TextButton(
                                                        onPressed: () {
                                                          textFields.forEach(
                                                              (element) {
                                                            widget.data[element
                                                                    .name!] =
                                                                element
                                                                    .controller!
                                                                    .text
                                                                    .toString();
                                                          });
                                                          dropDownButtons
                                                              .forEach(
                                                                  (element) {
                                                            widget.data[element
                                                                .name!] = [
                                                              element
                                                                  .chosenItem![0]
                                                                  .name
                                                                  .toString(),
                                                              element
                                                                  .chosenItem![0]
                                                                  .bill
                                                                  .toString()
                                                            ].toString();
                                                          });
                                                          imageLoaders.forEach(
                                                              (element) {
                                                            widget.data[element
                                                                    .name!] =
                                                                element
                                                                    .getFileName();
                                                            widget.data[element
                                                                        .name! +
                                                                    "_image"] =
                                                                element
                                                                    .getFile();
                                                          });
                                                          multiTextFields
                                                              .forEach(
                                                                  (element) {
                                                            widget.data[
                                                                element
                                                                    .name!] = element
                                                                .controller!
                                                                .getNumberValues() 
                                                                .toString();
                                                          });
                                                          
                                                          widget.data['bill'] =
                                                            
                                                              '0';
                                                          widget.data['type'] =
                                                              "0";
                                                          widget.data[
                                                                  'subcat_id'] =
                                                              widget.subCatId;
                                                          
                                                          Get.to(() =>
                                                              Container(
                                                                color: Colors
                                                                    .white,
                                                                child: Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ),
                                                              ));
                                                          MyConst
                                                              .afterSubCatPagesController
                                                              .addOrder(
                                                                  widget.data,
                                                                  1,
                                                                  false);
                                                        },
                                                        child: Text(
                                                          "تأكيد",
                                                          style:
                                                              GoogleFonts.cairo(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      )
                                                    ]);
                                                  }
                                                },
                                                child: Center(
                                                  child: Container(

                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        gradient:
                                                            linearGradient),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Icon(Icons.done_all,
                                                              color:
                                                                  Colors.white),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          MyText(
                                                            content: "إستعلام",
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer()
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  bool testForEmptyInput =
                                                      false;
                                                  textFields.forEach((element) {
                                                    if (element.controller!.text
                                                        .isEmpty)
                                                      testForEmptyInput = true;
                                                  });
                                                  dropDownButtons
                                                      .forEach((element) {
                                                    if (element
                                                        .chosenItem!.isEmpty)
                                                      testForEmptyInput = true;
                                                  });
                                                  imageLoaders
                                                      .forEach((element) {
                                                    if (element.getFile() ==
                                                        null)
                                                      testForEmptyInput = true;
                                                  });
                                                  multiTextFields
                                                      .forEach((element) {
                                                    if (element.controller!
                                                        .getNumberValues()
                                                        .isEmpty)
                                                      testForEmptyInput = true;
                                                    if (element.controller!
                                                            .getBillsValues()
                                                            .isEmpty &&
                                                        !element.controller!
                                                            .checkInput())
                                                      testForEmptyInput = true;
                                                  });
                                                  if (testForEmptyInput) {
                                                    showAlertDialog(context, [
                                                      Center(
                                                        child: Text(
                                                          "يرجى ملئ كافة البيانات بالأسلوب الصحيح",
                                                          style:
                                                              GoogleFonts.cairo(
                                                                  color:
                                                                      blueColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      )
                                                    ], [
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                            "إلغاء",
                                                            style: GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                    ]);
                                                  } else {
                                                    showAlertDialog(context, [
                                                      Center(
                                                        child: Text(
                                                          "هل أنت متأكد؟؟",
                                                          style:
                                                              GoogleFonts.cairo(
                                                                  color:
                                                                      blueColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ], [
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                            "إلغاء",
                                                            style: GoogleFonts.cairo(
                                                                color:
                                                                    blueColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                      TextButton(
                                                        onPressed: () {
                                                          textFields.forEach(
                                                              (element) {
                                                            widget.data[element
                                                                    .name!] =
                                                                element
                                                                    .controller!
                                                                    .text
                                                                    .toString();
                                                          });
                                                          imageLoaders.forEach(
                                                              (element) {
                                                            widget.data[element
                                                                    .name!] =
                                                                element
                                                                    .getFileName();
                                                            widget.data[element
                                                                        .name! +
                                                                    "_image"] =
                                                                element
                                                                    .getFile();
                                                          });
                                                          dropDownButtons
                                                              .forEach(
                                                                  (element) {
                                                            widget.data[element
                                                                .name!] = [
                                                              element
                                                                  .chosenItem![0]
                                                                  .name
                                                                  .toString(),
                                                              element
                                                                  .chosenItem![0]
                                                                  .bill
                                                                  .toString()
                                                            ].toString();
                                                          });
                                                          multiTextFields
                                                              .forEach(
                                                                  (element) {
                                                            widget.data[
                                                                element
                                                                    .name!] = element
                                                                .controller!
                                                                .getNumberValues() 
                                                                .toString();
                                                          });
                                                          
                                                          widget.data['bill'] =
                                                              haveBillMenu
                                                                  ? billMenu!
                                                                      .chosenItem![
                                                                          0]
                                                                      .bill
                                                                  : (haveMultiTextField
                                                                      ? billFormMultiTextField!
                                                                          .controller!
                                                                          .getMoneyValues() 
                                                                          .toString()
                                                                      : billController
                                                                          .text);
                                                          widget.data['type'] =
                                                              "1";
                                                          widget.data[
                                                                  'subcat_id'] =
                                                              widget.subCatId;
                                                          
                                                          Get.to(() =>
                                                              Container(
                                                                color: Colors
                                                                    .white,
                                                                child: Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ),
                                                              ));
                                                          MyConst
                                                              .afterSubCatPagesController
                                                              .addOrder(
                                                                  widget.data,
                                                                  1,
                                                                  false);
                                                        },
                                                        child: Text(
                                                          "تأكيد",
                                                          style:
                                                              GoogleFonts.cairo(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      )
                                                    ]);
                                                  }
                                                },
                                                child: Center(
                                                  child: Container(
                                                    // height: 50,

                                                    alignment: Alignment.center,  
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        gradient:
                                                            linearGradient),
                                                    // width: 200,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Icon(Icons.done_all,
                                                              color:
                                                                  Colors.white),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          MyText(
                                                            content: "دفع",
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer()
                                            ],
                                          )
                                        ],
                                      )
                                  ],
                                );
                              }
                            })),
                  
                ]),
              ),
            ]),
          )),
    );
  }
}
