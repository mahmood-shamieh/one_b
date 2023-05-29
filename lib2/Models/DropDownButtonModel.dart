// ignore_for_file: file_names, unnecessary_this

import 'package:web_application/Models/DropDownItemModel.dart';

class DropDownButtonModel {
  String? arabicName = "";
  String? englishName = "";
  List<DropDownMenuItemModel>? data = [];
  bool? bill;
  DropDownButtonModel(this.arabicName, this.data);
  DropDownButtonModel.fromJson(Map json) {
    this.bill = (json['type'] == "dropdown_bill") ? true : false;
    this.arabicName = json['arabic_name'];
    this.englishName = json['english_name'];
    if (json['data'] != null) {
      data = [];
      for (var cuurentContent in json['data']) {
        data!.add(DropDownMenuItemModel.fromJson(cuurentContent));
    
      }
    }
  }
  Map<String, dynamic> toJson() => {
        'arabic_name': this.arabicName,
        'content': this.data,
        'english_name': this.englishName
      };
}
