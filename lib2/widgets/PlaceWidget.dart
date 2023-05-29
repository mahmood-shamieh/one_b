// ignore_for_file: file_names, prefer_const_constructors, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PlaceWidget extends StatelessWidget {
  String? name;
  String? address;
  String? mobile;
  String? phone;
  PlaceWidget({
    Key? key,
    this.name,
    this.address,
    this.mobile,
    this.phone,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: const Color(0x000000),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.2), BlendMode.dstATop),
                          image: AssetImage('images/HomeIcon.png'))),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor),
                  width: MediaQuery.of(context).size.width - 20,
                  // color: Theme.of(context).primaryColor,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: name,
                      style: GoogleFonts.cairo(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width:GetPlatform.isWeb ? 140: MediaQuery.of(context).size.width - 90,
                            child: RichText(
                                text: TextSpan(
                                    text: phone,
                                    style: GoogleFonts.cairo(
                                        fontSize: 25,
                                        color:
                                            Theme.of(context).primaryColor))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_android,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width:GetPlatform.isWeb ? 140: MediaQuery.of(context).size.width - 90,
                            child: RichText(
                                text: TextSpan(
                                    text: mobile,
                                    style: GoogleFonts.cairo(
                                        fontSize: 25,
                                        color:
                                            Theme.of(context).primaryColor))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width:GetPlatform.isWeb ? 140: MediaQuery.of(context).size.width - 90,
                            child: RichText(
                                text: TextSpan(
                                    text: address,
                                    style: GoogleFonts.cairo(
                                        fontSize: 25,
                                        color:
                                            Theme.of(context).primaryColor))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
