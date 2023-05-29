// ignore_for_file: file_names, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, must_be_immutable, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/Models/CodeModel.dart';
import 'package:web_application/widgets/MyConsumedCodeWidget.dart';
import 'package:web_application/widgets/MyGeneratedCodeWidget.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';

class CodeViewPage extends StatefulWidget {
  TextEditingController textEditingController = TextEditingController();
  CodeViewPage({Key? key}) : super(key: key);

  @override
  _CodeViewPageState createState() => _CodeViewPageState();
}

class _CodeViewPageState extends State<CodeViewPage> {
  @override
  void initState() {
    MyConst.codePageGetXController.getAllCodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyConst.profilePageController.userModel.value.canCharge == "1"
            ? Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          MyConst.codePageGetXController.toConsumedCodePage();
                        },
                        child: Obx(() => MyText(
                              color: MyConst.codePageGetXController.consumedCode
                                          .value ==
                                      true
                                  ? blueColor
                                  : Colors.grey,
                              content: "المستهلكة",
                            ))),
                    TextButton(
                        onPressed: () {
                          MyConst.codePageGetXController.toGeneratedCodePage();
                        },
                        child: Obx(() => MyText(
                              color: MyConst.codePageGetXController
                                          .generatedCode.value ==
                                      true
                                  ? blueColor
                                  : Colors.grey,
                              content: "المولدة",
                            )))
                  ],
                ),
              )
            : Container(),
        Obx(() {
          if (MyConst.codePageGetXController.isLoading.value)
            // ignore: prefer_const_constructors
            return Center(
              child: CircularProgressIndicator(),
            );
          // ignore: invalid_use_of_protected_member
          else if (MyConst.codePageGetXController.generatedCodeList.value ==
              null)
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
          else if (MyConst.codePageGetXController.generatedCode.value == true &&
                  // ignore: invalid_use_of_protected_member
                  MyConst.codePageGetXController.consumedCode.value == false
              // ignore: invalid_use_of_protected_member

              ) {
            List<Widget> codes = [];
            for (CodeModel item
                // ignore: invalid_use_of_protected_member
                in MyConst.codePageGetXController.searching.value ? MyConst.codePageGetXController.generatedCodeListSearch: MyConst.codePageGetXController.generatedCodeList.value) {
              codes.add(MyGeneratedCodeWidget(
                checked: item.checked!,
                amount: item.amount!,
                code: item.code!,
                date: item.date!,
                consumedName: item.first_name!,
                consumedDate: item.updated_at,
              ));
            }
            return Column(
              children: [
                MyTextField(
                  isEmail: true,
                  isPassword: false,
                  hintText: "أدخل اسم المستخدم المستفيد",
                  icon: Icons.search,
                  controller: widget.textEditingController,
                  function: (value) {
                    MyConst.codePageGetXController.searchOnCode(value);
                  },
                ),
                ...codes
              ],
            );
          } else if (MyConst
                  // ignore: invalid_use_of_protected_member
                  .codePageGetXController
                  .generatedCodeList
                  // ignore: invalid_use_of_protected_member
                  .value
                  .isEmpty &&
              // ignore: invalid_use_of_protected_member
              MyConst.codePageGetXController.consumedCodeList.value.isEmpty)
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: MyText(
                  content: "لا يوجد أكواد بعد",
                ),
              ),
            );
          // ignore: invalid_use_of_protected_member
          else if (MyConst.codePageGetXController.consumedCodeList.value ==
              null) {
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: MyText(
                  content:
                      "هناك مشكلة في الاتصال بالانترنت يرجى إعادة المحاولة",
                ),
              ),
            );
          } else if (MyConst.codePageGetXController.generatedCode.value ==
                      false &&
                  MyConst.codePageGetXController.consumedCode.value == true
              // ignore: invalid_use_of_protected_member

              ) {
            List<Widget> codes = [];
            for (CodeModel item
                // ignore: invalid_use_of_protected_member
                in MyConst.codePageGetXController.searching.value
                    ? MyConst
                        .codePageGetXController.consumedCodeListSearch.value
                    : MyConst.codePageGetXController.consumedCodeList.value) {
              codes.add(MyConsumedCodeWidget(
                checked: item.checked!,
                amount: item.amount!,
                code: item.code!,
                date: item.date!,
                generatorName: item.last_name!,
                consumedDate: item.updated_at!,
              ));
            }
            return Column(
              children: [
                MyTextField(
                  isEmail: true,
                  isPassword: false,
                  hintText: "أدخل اسم الشخص المولد",
                  icon: Icons.search,
                  controller: widget.textEditingController,
                  function: (value) {
                    MyConst.codePageGetXController.searchOnCode(value);
                  },
                ),
                ...codes
              ],
            );
          } else
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: MyText(
                content: "لا يوجد أكواد بعد",
              ),
            ),
          );
        }),
      ],
    );
  }
}
