// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_application/Constant.dart';

import 'package:web_application/Models/CategoryModel.dart';
import 'package:web_application/Pages/RegesterationPage.dart';

import 'package:web_application/Pages/SubADSLPage.dart';

import 'package:web_application/Pages/SubPaymentPage.dart';
import 'package:web_application/main.dart';
import 'package:web_application/widgets/ADSLWidget.dart';

import 'package:web_application/widgets/CarouselWidget.dart';

import 'package:web_application/widgets/MyText.dart';

import 'package:web_application/widgets/PaymentMenuItem.dart';

// ignore: must_be_immutable
class MainPaymentPage extends StatefulWidget {
  List<Widget> items = [];
  MainPaymentPage({Key? key}) : super(key: key);

  @override
  _MainPaymentPageState createState() => _MainPaymentPageState();
}

class _MainPaymentPageState extends State<MainPaymentPage> {
  @override
  void initState() {
    MyConst.categoryController.staticCategoryRequest();
    MyConst.caruselGetXController.getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: 500,
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 1,
                color: Theme.of(context).primaryColor,
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
                  List<Image> images = [];
                  for (var item in MyConst
                      // ignore: invalid_use_of_protected_member
                      .caruselGetXController
                      .images
                      // ignore: invalid_use_of_protected_member
                      .value) {
                    images.add(Image(
                        errorBuilder: (context, error, stackTrace) =>
                            Image(image: AssetImage("images/error.gif")),
                        fit: BoxFit.fill,
                        image: NetworkImage(item)));
                  }
                  return CarouselWidget(
                    items: images,
                  );
                }
              }),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: shadowBoxDecoration,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
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
              Obx(() {
                if (MyConst.categoryController.isLoading.value) {
                  return SizedBox(
                    child: Center(child: CircularProgressIndicator()),
                    height: 200,
                  );
                }
                // ignore: invalid_use_of_protected_member
                else if (MyConst.categoryController.categoryModels.value ==
                    null) {
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
                } else if (MyConst
                    // ignore: invalid_use_of_protected_member
                    .categoryController
                    .categoryModels
                    // ignore: invalid_use_of_protected_member
                    .value
                    .isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      child: MyText(
                        content: "لا توجد خدمات بعد",
                      ),
                    ),
                  );
                } else {
                  List<Widget> ADSLItems = [];
                  widget.items.clear();
                  for (CategoryModel cat
                      // ignore: invalid_use_of_protected_member
                      in MyConst.categoryController.categoryModels.value) {
                    if (cat.ADSL == "1") {
                      ADSLItems.add(ADSLWidget(
                        name: cat.name!,
                        function: () {
                          if (GetStorage().read("logedIn") != null) {
                            !GetStorage().read("logedIn")
                                ? Get.to(() => RegesterationPage())
                                : navigate(SubPaymentPage(
                                    catId: int.parse(cat.id!),
                                  ),context);
                          } else
                            Get.to(() => RegesterationPage());
                        },
                      ));
                    } else {
                      widget.items.add(PaymentMenuItem(
                        useAsset: false,
                        url: MyApp.hostName + "/admin/files/cat/" + cat.image!,
                        content: cat.name!,
                        function: () {
                          if (GetStorage().read("logedIn") != null) {
                            !GetStorage().read("logedIn")
                                ? Get.to(() => RegesterationPage())
                                : navigate(SubPaymentPage(
                                      catId: int.parse(cat.id!),
                                    ),context);
                          } else
                            Get.to(() => RegesterationPage());
                        },
                      ));
                    }
                  }
                  if (ADSLItems.isNotEmpty)
                    widget.items.add(PaymentMenuItem(
                      useAsset: false,
                      url: MyApp.hostName + "/admin/files/ADSL.jpg",
                      content: "ADSL",
                      function: () {
                        if (GetStorage().read("logedIn") != null) {
                          !GetStorage().read("logedIn")
                              ? Get.to(() => RegesterationPage())
                              : navigate(SubADSLPAge(
                                    items: ADSLItems,
                                  ),context);
                        } else
                          Get.to(() => RegesterationPage());
                      },
                    ));
                }
                List<Widget> test = [];
                for (var i = widget.items.length - 1; i >= 0; i--) {
                  test.add(widget.items.elementAt(i));
                }
                return Column(
                  children: test,
                );
              }),
            ],
          ),
        )
      ],
    );
  }
}
