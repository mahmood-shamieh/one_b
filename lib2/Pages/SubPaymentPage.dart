// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';

import 'package:web_application/Models/SubCategoryModel.dart';
import 'package:web_application/widgets/AppBar.dart';

import 'package:web_application/widgets/MyText.dart';

import 'package:web_application/widgets/SubPaymentCateggoryWidget.dart';

import '../main.dart';

// ignore: must_be_immutable
class SubPaymentPage extends StatefulWidget {
  int catId;
  Function()? function;
  
  SubPaymentPage({Key? key,required this.catId, this.function}) : super(key: key);

  @override
  _SubPaymentPageState createState() => _SubPaymentPageState();
}

class _SubPaymentPageState extends State<SubPaymentPage> {
  @override
  void initState() {
    
    MyConst.subCatController.getSubCats(widget.catId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> subCatWidget = [];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: MyAppBar(),
          
          body: SingleChildScrollView(
            child: ListBody(
              children: [
                Obx(() {
                  if (MyConst.subCatController.isLoading.value)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  // ignore: invalid_use_of_protected_member
                  else if (MyConst.subCatController.subCatsModels.value ==
                      null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: MyText(
                          content:
                              "لا يوجد اتصال بالإنترنت يرجى المحاولة لاحقا",
                        ),
                      ),
                    );
                  } else {
                    subCatWidget.clear();

                    for (SubCategoryModel item
                        // ignore: invalid_use_of_protected_member
                        in MyConst.subCatController.subCatsModels.value) {
                      subCatWidget.add(SubPaymentCateggoryWidget(
                        bounce:item.bounce!,
                        function: widget.function,
                        useAsset: false,
                        content: item.arabicName!,
                        url:
                            MyApp.hostName+"/admin/files/subcat/" +
                                item.image!,
                        subCatId: item.id!,
                        buttons: item.buttons!,
                      ));
                    }
                    return Column(
                      children: subCatWidget,
                    );
                  }
                })
              ],
            ),
          )),
    );
  }
}
