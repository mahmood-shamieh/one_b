// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_application/Controller/CaruselController.dart';

class CaruselGetXController extends GetxController {
  var isLoading = true.obs;
  var images = [].obs;
  CaruselConroller caruselConroller = CaruselConroller();
  void getImages() async {
    if (isLoading.value == false) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoading(true);
        await caruselConroller.getImages().then((value) {
          images.value = value ?? [];
          // print(value);
        });
      } finally {
        isLoading(false);
        update();
      }
    });
  }
}
