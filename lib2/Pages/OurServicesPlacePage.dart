// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:web_application/Constant.dart';
import 'package:web_application/GetXController/OurCenterGetXController.dart';
import 'package:web_application/Models/CenterModel.dart';

import 'package:web_application/widgets/MyText.dart';
import 'package:web_application/widgets/MyTextField.dart';
import 'package:web_application/widgets/PlaceWidget.dart';

import 'package:responsive_grid/responsive_grid.dart';

class OurServicesPlacePage extends StatefulWidget {
  @override
  _OurServicesPlacePageState createState() => _OurServicesPlacePageState();
}

class _OurServicesPlacePageState extends State<OurServicesPlacePage> {
  List<Widget> places = [];
  OurCenterGetXController ourCenterGetXController = Get.put(OurCenterGetXController());
  TextEditingController searchController =  TextEditingController();
  @override
  void initState() {
    // ourCenterGetXController = Get.put(OurCenterGetXController());
    if(ourCenterGetXController.centers!=null)
    ourCenterGetXController.centers.clear();
    ourCenterGetXController.getAllCenters("");

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
            content: "مراكزنا الموجودة بالخدمة",
            size: 28,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            height: 4,
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(color: greenColor, boxShadow: [
              BoxShadow(blurRadius: 5, spreadRadius: 3, color: Colors.grey)
            ]),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        MyTextField(
          isEmail: true,
          isPassword: false,
          hintText: "أدخل اسم المركز أو عنوانه",
          icon: Icons.search,
          controller: searchController,
          function: (adress) {
            ourCenterGetXController.centers.clear();
            ourCenterGetXController.getAllCenters(adress);
          },
        ),
        GetBuilder(
            init: new OurCenterGetXController(),
            builder: (controller) {
              places.clear();
              if ((controller as OurCenterGetXController).isLoading.value)
                return Center(
                  child: CircularProgressIndicator(),
                );
                else if((controller as OurCenterGetXController ).centers == null) return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 200,child: MyText(content: "هناك مشكلة في الاتصال بالانترنت يرجى إعادة المحاولة",),),
              );
              else if((controller as OurCenterGetXController ).centers.isNotEmpty){
                for (CenterModel item
                    in (controller as OurCenterGetXController).centers) {
                  places.add(PlaceWidget(
                    address: item.address!,
                    mobile: item.mobile!,
                    name: item.name!,
                    phone: item.phone!,
                  ));
                }
                return ResponsiveGridList(
                  desiredItemWidth: 220,
                  scroll: false,
                  children: places,
                );
                
              }
              else return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 200,child: MyText(content: "لا يوجد أماكن خدمة حالياَ",),),
              );
            }),
      ],
    );
  }
}
