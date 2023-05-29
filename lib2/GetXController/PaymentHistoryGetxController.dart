// ignore_for_file: file_names

import 'package:get/get.dart';

class PaymentHistoryGetXController extends GetxController {
  var graphPage = true.obs;
  var historyPage = false.obs;
  void toHistoryPage() {
    graphPage.value = false;
    historyPage.value = true;
    update();
  }

  void toGraphPage() {
    graphPage.value = true;
    historyPage.value = false;
    update();
  }
}
