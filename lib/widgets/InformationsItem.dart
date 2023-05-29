// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class InformationItem extends StatelessWidget {
  String? url;
  String? headers;
  String? description;
  InformationItem({Key? key, this.description, this.headers, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          shadowColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                  height: height / 8,
                  width: width / 5,
                  child: Image(image: AssetImage(url!))),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: headers,
                    style: GoogleFonts.cairo(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: TextSpan(
                        text: description,
                        style: GoogleFonts.cairo(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                        ))),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
