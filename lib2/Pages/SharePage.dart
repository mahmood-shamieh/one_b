// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:web_application/widgets/MyText.dart';



class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  get linearGradient => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        SizedBox(
          height: 200,
        ),
        Row(
          children: [
            Spacer(),
            InkWell(
              onTap: () {
                Share.share("https://play.google.com/store/apps/details?id=com.nour.web_application");
              },
              child: Center(
                child: Container(
                  // color: Colors.black,
                  // height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(63, 108, 176, 1),
                            Color.fromRGBO(71, 190, 153, 1)
                          ])),
                  // width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.share, color: Colors.white),
                        MyText(
                          color: Colors.white,
                          content: "مشاركة التطبيق",
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
