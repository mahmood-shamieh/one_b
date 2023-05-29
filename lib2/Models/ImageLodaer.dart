// ignore_for_file: file_names

import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class ImageLoader {
  String? id = "";
  String? english_name = "";
  String? arabic_name = "";
  String? type = "";
  String? percent = "";
  ImageLoader({
     this.id,
     this.english_name,
     this.arabic_name,
     this.type,
     this.percent,
  });

  ImageLoader copyWith({
    String? id,
    String? english_name,
    String? arabic_name,
    String? type,
    String? percent,
  }) {
    return ImageLoader(
      id: id ?? this.id,
      english_name: english_name ?? this.english_name,
      arabic_name: arabic_name ?? this.arabic_name,
      type: type ?? this.type,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'english_name': english_name,
      'arabic_name': arabic_name,
      'type': type,
      'percent': percent,
    };
  }

  factory ImageLoader.fromMap(Map<String, dynamic> map) {
    return ImageLoader(
      id: map['id'] ?? '',
      english_name: map['english_name'] ?? '',
      arabic_name: map['arabic_name'] ?? '',
      type: map['type'] ?? '',
      percent: map['percent'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageLoader.fromJson(String source) => ImageLoader.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageLoader(id: $id, english_name: $english_name, arabic_name: $arabic_name, type: $type, percent: $percent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ImageLoader &&
      other.id == id &&
      other.english_name == english_name &&
      other.arabic_name == arabic_name &&
      other.type == type &&
      other.percent == percent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      english_name.hashCode ^
      arabic_name.hashCode ^
      type.hashCode ^
      percent.hashCode;
  }
}
