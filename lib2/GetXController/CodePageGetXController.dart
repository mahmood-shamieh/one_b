// ignore_for_file: file_names, invalid_use_of_protected_member, prefer_is_empty

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_application/Controller/UserController.dart';
import 'package:web_application/Models/CodeModel.dart';

class CodePageGetXController extends GetxController {
  var searching = false.obs;
  var consumedCode = true.obs;
  var isLoading = true.obs;
  var generatedCode = false.obs;
  var generatedCodeList = [].obs;
  var generatedCodeListSearch = [].obs;
  var consumedCodeList = [].obs;
  var consumedCodeListSearch = [].obs;
  UserController userController = UserController();
  void getAllCodes() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoading(true);
        searching.value = false;
        await userController.getAllCode().then((value) {
          consumedCodeList.value = value['consumed'];
          generatedCodeList.value = value['generated'];
        });
      } finally {
        isLoading(false);
        update();
      }
    });
  }

  void toGeneratedCodePage() {
    consumedCode.value = false;
    generatedCode.value = true;
    update();
  }

  void toConsumedCodePage() {
    consumedCode.value = true;
    generatedCode.value = false;
    update();
  }

  void searchOnCode(String value) {
    consumedCodeListSearch.value.clear();
    generatedCodeListSearch.value.clear();
    
    if (value.length == 0 || value == ' ') {
      searching.value = false;
    } else {
      searching.value = true;
    }
    
    if (generatedCode.value) {
      for (CodeModel item in generatedCodeList.value) {
        
        if (item.first_name!.contains(value)) {
          generatedCodeListSearch.value.add(item);
        }
      }
    }
    if (consumedCode.value) {
      for (CodeModel item in consumedCodeList) {
        
        if (item.last_name!.contains(value) ) {
          consumedCodeListSearch.value.add(item);
        }
      }
    }
    update();
  }
}
