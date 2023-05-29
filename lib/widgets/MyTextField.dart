// ignore_for_file: file_names, prefer_if_null_operators, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/GetXController/CompanyBillsController.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  int? id;
  bool? bill;
  IconData? icon;
  String? name;
  String? hintText;
  bool? isPassword;
  bool? isEmail;
  TextInputType? keyboardType;
  Function(String)? function;
  TextEditingController? controller;

  MyTextField(
      {Key? key,
      this.id,
      this.icon,
      this.hintText,
      this.isEmail,
      this.isPassword,
      this.controller,
      this.name,
      this.keyboardType,
      this.function,
      this.bill})
      : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        onChanged: (widget.id == null
            ? (widget.function ?? (String s) {})
            : (value) {
                if (widget.bill!) {
                  Get.find<CompanyBillsController>().getMoneyValues().isEmpty
                      ? Get.find<CompanyBillsController>()
                          .getMoneyValues()
                          .add("")
                      : {};
                  Get.find<CompanyBillsController>()
                      .getMoneyValues()[widget.id!] = value;
                } else {
                  Get.find<CompanyBillsController>().getNumberValues().isEmpty
                      ? Get.find<CompanyBillsController>()
                          .getNumberValues()
                          .add("")
                      : {};
                  Get.find<CompanyBillsController>()
                      .getNumberValues()[widget.id!] = value;
                }
              }),
        controller: widget.controller == null ? null : widget.controller,
        // autofocus: true,
        textAlign: TextAlign.right,
        obscureText: widget.isPassword!,
        keyboardType: widget.keyboardType ?? TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: IconButton(
              icon: Icon(
                widget.icon,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                if (widget.icon == Icons.lock_sharp) {
                  setState(() {
                    widget.isPassword = !widget.isPassword!;
                  });
                }
              }),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greenColor),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: widget.hintText != null ? widget.hintText : "",
          hintStyle: GoogleFonts.cairo(
              fontSize: 18, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
