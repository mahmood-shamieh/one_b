// ignore_for_file: file_names

import 'package:get/get.dart';

class BillsController extends GetxController {
  double? bounce ;
  var finalValue = 0.0.obs;
  BillsController({this.bounce});
  void myUpdate(double value) {
    finalValue.value = (value * bounce!/100) + value;
    update();
  }
}
