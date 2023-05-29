// ignore_for_file: file_names

import 'package:get/get.dart';

class RatingController extends GetxController {
  var i = (0.0).obs;
  void myUpdate(double i) {
    this.i.value = i;
    update();
  }
}
