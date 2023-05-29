// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:web_application/widgets/AppBar.dart';

class UserGuidePage extends StatefulWidget {
  const UserGuidePage({ Key? key }) : super(key: key);

  @override
  _UserGuidePageState createState() => _UserGuidePageState();
}

class _UserGuidePageState extends State<UserGuidePage> {
    var distance = 10.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: MyAppBar(),
          body: SingleChildScrollView(
            child: ListBody(),
          )),
    );
  }
}