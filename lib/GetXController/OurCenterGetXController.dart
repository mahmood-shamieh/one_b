// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:web_application/Controller/OurPlacesController.dart';
import 'package:web_application/Models/CenterModel.dart';

class OurCenterGetXController extends GetxController {
  var isLoading = true.obs;
  List<CenterModel> centers = [];
  OurPlacesController ourPlacesController =  OurPlacesController();
  void getAllCenters(String address) async {
    try {
      isLoading(true);
      await ourPlacesController
          .getAllCenters(address)
          .then((value) => centers = value!);
    } finally {
      isLoading(false);
      update();
    }
  }
}
