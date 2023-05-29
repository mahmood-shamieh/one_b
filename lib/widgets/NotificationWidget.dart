// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class NotificationWidget extends StatelessWidget {
  String? content, title, date;
  NotificationWidget({Key? key, this.title, this.content, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title != null
                  ? MyText(
                      content: title,
                    )
                  : Container(),
              content != null
                  ? RichText(
                      text: TextSpan(
                          text: content,
                          style: GoogleFonts.cairo(
                              color: blueColor, fontSize: 18)))
                  : Container(),
              date != null
                  ? Row(
                      children: [
                        Spacer(),
                        MyText(
                          content: date,
                        )
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
