// ignore_for_file: must_be_immutable, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/widgets/AppBar.dart';

class SubADSLPAge extends StatefulWidget {
  List<Widget> items;

  SubADSLPAge({Key? key, required this.items}) : super(key: key);

  @override
  _SubADSLPAgeState createState() => _SubADSLPAgeState();
}

class _SubADSLPAgeState extends State<SubADSLPAge> {
  List<Widget> finalItems() {
    List<Widget> innerItems = [];
    if (widget.items.length % 2 == 0) {
      // ignore: curly_braces_in_flow_control_structures
      for (var i = 0; i < widget.items.length; i += 2) {
        innerItems.add(Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              widget.items.elementAt(i),
              widget.items.elementAt(i + 1)
            ],
          ),
        ));
      }
    } else {
      for (var i = 0; i < widget.items.length - 1; i += 2) {
        innerItems.add(Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              widget.items.elementAt(i),
              widget.items.elementAt(i + 1)
            ],
          ),
        ));
      }
      innerItems.add(widget.items.elementAt(widget.items.length - 1));
    }

    return innerItems;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: MyAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: GetPlatform.isWeb
                  ? Center(
                    child: Wrap(
                        alignment: WrapAlignment.center,
                        children: widget.items,
                      ),
                  )
                  : Column(
                      children: finalItems(),
                    ),
            ),
          )),
    );
  }
}
