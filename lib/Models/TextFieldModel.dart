// ignore_for_file: file_names, unnecessary_this

class TextFieldModel {
  String? name;
  String? arabicName;
  String? englishName;
  TextFieldModel(this.arabicName, this.name);
  TextFieldModel.fromJson(Map json)
      : this.name = json['english_name'],
        this.arabicName = json['arabic_name'];
  // this.englishName = json['english_name'];
  Map<String, dynamic> toJson() => {
        'name': name,
        'arabic_name': arabicName,
        // 'english_name': this.englishName
      };
}
