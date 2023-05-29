// ignore_for_file: file_names, unnecessary_this

class SubCategoryModel {
  String? id;
  String? price;
  String? name;
  String? image;
  String? arabicName;
  String? buttons;
  double? bounce;

  SubCategoryModel(this.arabicName, this.name, this.image, this.buttons,this.bounce);
  SubCategoryModel.fromJson(Map json) {
    this.name = json['name'];
    this.image = json['image'];
    this.arabicName = json['arabic_name'];
    this.id = json['id'];
    this.price = json['price'];
    this.buttons = json['buttons'];
    this.bounce = double.parse(json['percent'] ?? "0");
  }

  Map<String, dynamic> toJson() {
    // List<Map<String, dynamic>> textFieldsMaps = new List();
    // for (var elem in textFields) {
    //   textFieldsMaps.add(elem.toJson());
    // }
    // List<Map<String, dynamic>> dropDownButtonsMaps = new List();
    // for (var elem in dropDownButtons) {
    //   dropDownButtonsMaps.add(elem.toJson());
    // }
    Map<String, dynamic> map = {
      'name': this.name,
      'image': this.image,
      'id': this.id,
      'price': this.price,
      'arabic_name': this.arabicName,
      'buttons': this.buttons
      // 'text': textFieldsMaps,
      // 'dropdown': dropDownButtonsMaps
    };
    return map;
  }

  // List<TextFieldModel> getTextFields() {
  //   return this.textFields;
  // }

  // List<DropDownButtonModel> getDropDownButtons() {
  //   return this.dropDownButtons;
  // }
}
