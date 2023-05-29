// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/GetXController/ContactUsGetXController.dart';
import 'package:web_application/Models/SocialBlockModel.dart';
import 'package:web_application/main.dart';
import 'package:web_application/widgets/MainMenuItem.dart';
import 'package:web_application/widgets/MyText.dart';

import 'package:responsive_grid/responsive_grid.dart';

// ignore: must_be_immutable
class ContactUsPage extends StatefulWidget {
  ContactUsGetXController contactUsGetXController = Get.put(ContactUsGetXController());
  TextEditingController messageController = TextEditingController();
  ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  void initState() {
    // widget.contactUsGetXController = Get.put(ContactUsGetXController());
    widget.contactUsGetXController.contactList.clear();
    widget.contactUsGetXController.getAllSocialContactList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: MyText(
            content: "نشكر حسن تواصلكم واستخدامكم للتطبيق",
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.messageController,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 1,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greenColor),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: "أدخل وصف المشكلة هنا",
              hintStyle: GoogleFonts.cairo(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Spacer(),
            InkWell(
              child: Container(
                
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      if (widget.messageController.text.isNotEmpty) {
                        Get.to(() => Container(
                              color: Colors.white,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ));
                        widget.contactUsGetXController
                            .sendMessage(widget.messageController.text);
                      } else {
                        showAlertDialog(context, [
                          Center(
                            child: MyText(content: "الرجاء إدخال نص الرسالة"),
                          )
                        ], [
                          TextButton(onPressed: () => Get.back(), child: MyText(content: "إلغاء",),)
                        ]);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Icon(
                              Icons.send,
                              color: white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          MyText(content: "إرسال", color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: borderRadius, gradient: linearGradient),
              ),
            ),
            Spacer()
          ],
        ),
        SizedBox(
          height: 20,
        ),
        MyText(
          content: "وسائل أخرى",
        ),
        Divider(
          endIndent: 30,
          indent: 30,
          thickness: 1,
          color: Theme.of(context).primaryColor,
        ),
        Obx(() {
          if (widget.contactUsGetXController.isLoading.value)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (widget.contactUsGetXController.contactList == null)
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: MyText(
                  content:
                      "هناك مشكلة في الاتصال بالانترنت يرجى إعادة المحاولة",
                ),
              ),
            );
          // ignore: prefer_is_not_empty
          else if (!widget.contactUsGetXController.contactList.isEmpty) {
            List<MainMenuItem> contactListWidget = [];
            for (SocialBlockModel item
                in widget.contactUsGetXController.contactList) {
              
              contactListWidget.add(MainMenuItem(
                url: MyApp.hostName + "/admin/files/cat/" +
                    item.image!,
                content: item.name!,
                useNetwork: true,
                urlFunction: item.link!,
              ));
            }
            return ResponsiveGridList(
              children: contactListWidget,
              desiredItemWidth: 200,
              scroll: false,
            );
          } else
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: MyText(
                  content: "لا يوجد وسائل تواصل حالياَ",
                ),
              ),
            );
        }),
      ],
    );
  }
}
