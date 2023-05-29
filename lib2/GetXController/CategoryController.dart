// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_application/Controller/CategoryController.dart';

class CategoryGetXController extends GetxController {
  @override
  void onClose() {
    
    super.onClose();
  }

  @override
  InternalFinalCallback<void> get onDelete => super.onDelete;

  var categoryModels = [].obs;
  var subCatsModels = [].obs;
  RxBool isLoading = RxBool(true);
  CategoryController categoryController =  CategoryController();

  void staticCategoryRequest() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoading(true);
        await categoryController
            .getDynamicCat()
            .then((value) => categoryModels.value = value!);
      } finally {
        isLoading(false);
        update();
      }
    });
    
  }

  void getSubCats(int catId) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
    
        isLoading(true);
        await categoryController
            .getSubCats(catId)
            .then((value) => subCatsModels.value = value!);
      } finally {
    
        isLoading(false);
        update();
      }
    });
    
  }
}
