
// ignore_for_file: invalid_use_of_protected_member, file_names

import 'package:get/get.dart';

class MyDrawerGetXController extends GetxController {
  var buttons = [true,false,false,false,false,false,false,false,false,false,false,false,false,false,false].obs;
  void updateDrawer(int number) {
    for (var i = 0; i < buttons.value.length; i++) {
      if (i == number) {
        buttons.value[i] = true;
      } else {
        buttons.value[i] = false;
      }
    }
  }
}
