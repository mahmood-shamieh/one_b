// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';

import 'package:web_application/widgets/MyText.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingAppPage extends StatefulWidget {
  RatingAppPage({Key? key}) : super(key: key);

  @override
  _RatingAppPageState createState() => _RatingAppPageState();
}

class _RatingAppPageState extends State<RatingAppPage> {
  @override
  Widget build(BuildContext context) {
    
    return Column(
      
      children: [
        FittedBox(
          fit: BoxFit.fitHeight,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  content: "تقييمك للتطبيق",
                ),
                Divider(
                  color: blueColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => MyText(
                    content: MyConst.ratingController.i.value == 1.0
                        ? "سيئة جدا"
                        : (MyConst.ratingController.i.value == 2.0
                            ? "سيئة"
                            : (MyConst.ratingController.i.value == 3.0
                                ? "جيدة"
                                : (MyConst.ratingController.i.value == 4.0
                                    ? "جيدة جدا"
                                    : (MyConst.ratingController.i.value == 5.0
                                        ? "ممتازة"
                                        : (MyConst.ratingController.i.value ==
                                                0.0
                                            ? "لا يوجد تقييم بعد"
                                            : ""))))),
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RatingBar.builder(
                    minRating: 1,
                    maxRating: 5,
                    itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {
                      
                      MyConst.ratingController.myUpdate(rating);
                    })
              ],
            ),
          ),
        ),
        Obx(() {
          return Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 3,
            child: MyConst.ratingController.i.value == 0.0
                ? MyText(
                    content: "",
                  )
                : Image(
                    image: MyConst.ratingController.i.value == 1.0
                        ? AssetImage('images/vereyBad.png')
                        : (MyConst.ratingController.i.value == 2.0
                            ? AssetImage('images/bad.png')
                            : (MyConst.ratingController.i.value == 3.0
                                ? AssetImage('images/good.png')
                                : (MyConst.ratingController.i.value == 4.0
                                    ? AssetImage('images/vereyGood.png')
                                    : AssetImage('images/exellent.png'))))),
          );
        }),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Spacer(),
            InkWell(
              onTap: () {
                showAlertDialog(context, [
                  Center(
                    child: Text(
                      "هل أنت متأكد؟؟",
                      style: GoogleFonts.cairo(
                          color: blueColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
                            color: blueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                  TextButton(
                    onPressed: () {
                      // StoreRedirect.redirect(
                      //     androidAppId: 'com.nour.web_application');
                    },
                    child: Text(
                      "تأكيد",
                      style: GoogleFonts.cairo(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]);
              },
              child: Center(
                child: Container(
                  
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: linearGradient),
                  
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.done_all, color: Colors.white),
                        MyText(content: "تقييم", color: Colors.white)
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
          height: 200,
        )
      ],
    );
  }
}
