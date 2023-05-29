// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_application/Controller/CategoryController.dart';

class SubCatController extends GetxController {
  var subCatsModels = [].obs;
  var isLoading = true.obs;
  CategoryController categoryController =  CategoryController();
  void getSubCats(int catId) async {
    if (isLoading.value = false) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoading(true);
        await categoryController
            .getSubCats(catId)
            .then((value) => subCatsModels.value = value ?? []);
      } finally {
        isLoading(false);

        update();
      }
    });
  }
}
