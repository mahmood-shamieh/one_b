// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class PaymentMenuItem extends StatelessWidget {
  String? content;
  Function()? function;
  String? url;
  bool? useAsset;
  PaymentMenuItem(
      {Key? key, this.content, this.function, this.url, this.useAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: function,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                    width: Get.mediaQuery.size.width,
                    height: 100,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: MyText(
                          content: content,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                // ignore: prefer_const_literals_to_create_immutables
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        
                        spreadRadius: 3,
                      ),
                    ],
                    ),
                child: CircleAvatar(
                  maxRadius: 66,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                            width: Get.mediaQuery.size.width / 3 - 20,
                            height: Get.mediaQuery.size.width / 4 - 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    ClipRRect(
                                        child: Image(
                                          image: AssetImage("images/error.gif"),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                image: (useAsset ?? false
                                    ? AssetImage(url!)
                                    : (NetworkImage(url!) ??
                                        AssetImage('images/error.gif'))) as ImageProvider,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          
        ));
  }
}
