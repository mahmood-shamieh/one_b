// ignore_for_file: file_names, invalid_use_of_protected_member

import 'package:get/get.dart';

class CompanyBillsController extends GetxController {
  var phones = [].obs;
  var phonesnumber = 1.obs;
  var numberValues = [].obs;
  var moneyValues = [].obs;
  var billsValues = [].obs;
  void addWidget() {
    phonesnumber.value = phonesnumber.value + 1;
    update();
  }

  void deleteWidget(int j) {
    List templist1 = [];
    phonesnumber.value = phonesnumber.value - 1;
    for (int i = 0; i < numberValues.length; i++) {
      if (i != j) templist1.add(numberValues.value.elementAt(i));
    }
    numberValues.value = templist1;
    List templist2 = [];
    for (int i = 0; i < moneyValues.length; i++) {
      if (i != j) templist2.add(moneyValues.value.elementAt(i));
    }
    moneyValues.value = templist2;
    List templist3 = [];
    for (int i = 0; i < billsValues.length; i++) {
      if (i != j) templist3.add(billsValues.value.elementAt(i));
    }
    billsValues.value = templist3;
    update();
  }

  List getNumberValues() {
    return numberValues.value;
  }

  List getMoneyValues() {
    return moneyValues.value;
  }

  List getBillsValues() {
    return billsValues.value;
  }

  void myUpdate(String phone) {
    phones.add(phone);
    update();
  }

  bool checkInput() {
    bool testForInput = true;
    getNumberValues().forEach((element) {
      if (element.length < 8) {
        testForInput = false;
        return;
      }
      if (element.length > 11) {
        testForInput = false;
        return;
      }
    });
    return testForInput;
  }
}
