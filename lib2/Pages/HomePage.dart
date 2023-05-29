// ignore_for_file: file_names, empty_catches, prefer_const_constructors, curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:web_application/Constant.dart';

import 'package:web_application/Pages/PaymentPage.dart';
import 'package:web_application/Pages/RegesterationPage.dart';
import 'package:web_application/Pages/Settings.dart';
import 'package:web_application/Pages/UserGuide.dart';

import 'package:web_application/widgets/CarouselWidget.dart';

import 'package:web_application/widgets/InformationsItem.dart';
import 'package:web_application/widgets/MainMenuItem.dart';

import 'package:web_application/widgets/MyText.dart';

import 'package:responsive_grid/responsive_grid.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  bool? logedIn;
  HomePage({Key? key, this.logedIn}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    try {
      MyConst.caruselGetXController.getImages();
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    items.add(MainMenuItem(
      url: 'images/payment.png',
      content: "التسديد",
      navigation: () {
        MyConst.styleWidgetController.NavigateToMainPageOrPaymentPage(false);
      },
    ));

    items.add(MainMenuItem(
      url: 'images/logIn.png',
      content: "تسجيل الدخول",
      navigation: () {
        Get.to(() => RegesterationPage());
      },
    ));
    // items.add(
    //   MainMenuItem(
    //     url: 'images/info.png',
    //     content: "دليل المستخدم",
    //     navigation: () => Get.to(
    //       () => UserGuidePage(),
    //     ),
    //   ),
    // );
    // items.add(MainMenuItem(
    //   url: 'images/settings.png',
    //   content: "الإعدادت",
    //   navigation: () {
    //     Get.to(() => Settins());
    //   },
    // ));
    //
    // items.add(InformationItem(
    //   url: "images/Correct.png",
    //   headers: "سهل الاستخدام",
    //   description: "تطبيق سهل ومرن ويمكن للجميع استخدامه ببساطة",
    // ));
    // items.add(InformationItem(
    //   url: "images/Speed.png",
    //   headers: "سرعة الاستجابة",
    //   description: "دفع الفواتير يستغرق عدة دقائق وفي أي وقت",
    // ));
    // items.add(InformationItem(
    //   url: "images/Security.png",
    //   headers: "الأمان",
    //   description: "يبعدك عن أي احتكاك أو إزدحام أو انتظار لدفع الفواتير",
    // ));

    return Center(
      child: Obx(() {
        if (!MyConst.styleWidgetController.homePageOrPaymentPage.value ?? false)
          return MainPaymentPage();
        else if (MyConst.logedInController.logedIn.value ?? false)
          return MainPaymentPage();
        else
          return Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Theme.of(context).primaryColor,
                width: 500,

              ),
              Obx(() {
                if (MyConst.caruselGetXController.isLoading.value)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                // ignore: invalid_use_of_protected_member
                else if (MyConst.caruselGetXController.images.value == null) {
                  
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
                }
                // ignore: invalid_use_of_protected_member
                else {
                  // ignore: invalid_use_of_protected_member
                  List<Image> images = [];
                  for (var item
                      // ignore: invalid_use_of_protected_member
                      in MyConst.caruselGetXController.images.value) {
                    images.add(Image(
                        errorBuilder: (context, error, stackTrace) =>
                            Image(image: AssetImage("images/error.gif")),
                        fit: BoxFit.fill,
                        image: NetworkImage(item)));
                  }
                  if (images.isNotEmpty)
                    return CarouselWidget(
                      items: images,
                    );
                  else
                    return Container();
                }
              }),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 1,
                color: Theme.of(context).primaryColor,
                width: 500,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: shadowBoxDecoration,
                // width: 500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        MyText(
                          content: "خدماتنا:",
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    ResponsiveGridList(
                      children: items,
                      desiredItemWidth: 200,
                      scroll: false,
                      rowMainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    // SizedBox(
                    //   height: 120,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
      }),
    );
  }
}
