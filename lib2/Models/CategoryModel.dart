// ignore_for_file: non_constant_identifier_names, file_names

class CategoryModel {
  String? id = "";
  String? name = "";
  String? image = "";
  String? arabicName = "";
  String? ADSL = "";
  
  CategoryModel(this.name, this.image);
  CategoryModel.fromJson(Map json) {
    name = json['name'];
    arabicName = json['arabic_name'];
    image = json['image'];
    id = json['id'];
    ADSL = json['ADSL'];
    
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'image': image,
      'id': id,
      'arabic_name': arabicName,
      'ADSL': ADSL
    };
    return map;
  }
}
