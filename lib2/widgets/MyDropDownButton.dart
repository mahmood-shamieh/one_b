// ignore_for_file: file_names, avoid_unnecessary_containers, avoid_types_as_parameter_names, prefer_const_constructors, duplicate_ignore

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/Models/DropDownItemModel.dart';

// ignore: must_be_immutable
class MyDropDownButton extends StatefulWidget {
  String? label;
  String? name;
  List<DropDownMenuItemModel>? chosenItem = [];
  List<DropDownMenuItemModel>? items;
  Function()? function;
  bool? billMenu;
  MyDropDownButton(
      {Key? key,
      this.label,
      this.items,
      this.function,
      this.name,
      this.billMenu})
      : super(key: key);

  @override
  _MyDropDownButtonState createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownSearch<String>(
        popupItemBuilder: (context, contnt, bool) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: linearGradient,
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40)),
                      ),
                      child: Center(
                          child: Container(
                        child: RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                                text: contnt,
                                style: GoogleFonts.elMessiri(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        },
        dropdownSearchBaseStyle: GoogleFonts.elMessiri(
            color: Theme.of(context).primaryColor, fontSize: 30),
        dropdownSearchDecoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          hoverColor: Theme.of(context).primaryColor,
          fillColor: Theme.of(context).primaryColor,
          border: OutlineInputBorder(
              gapPadding: 3, borderRadius: BorderRadius.circular(35)),
        ),
        mode: Mode.DIALOG,
        items: widget.billMenu ?? false
            ? widget.items!.map((e) => e.toString()).toList()
            : widget.items!.map((e) => e.name!).toList(),
        // ignore: deprecated_member_use
        label: widget.label,
        onChanged: (item) {
          
          widget.chosenItem!.clear();
          
          if (!widget.billMenu!) {
            for (DropDownMenuItemModel innerItem in widget.items!) {
              if (innerItem.name.toString().compareTo(item.toString()) == 0) {
                
                widget.chosenItem!.add(innerItem);
              }
            }
          } else {
            for (DropDownMenuItemModel innerItem in widget.items!) {
              if (innerItem.toString().compareTo(item.toString()) == 0) {
                
                widget.chosenItem!.add(innerItem);
              }
            }
          }
          
        },
        selectedItem: "",
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintTextDirection: TextDirection.rtl,
            border: OutlineInputBorder(),
            labelText: "أدخل الاسم للبحث",
          ),
        ),
      ),
    );
  }
}
