// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogedInController extends GetxController {
  var logedIn = (GetStorage().read('logedIn') as bool).obs;

  void myUpdate(bool value) {
    logedIn.value = value;
    update();
  }
}
