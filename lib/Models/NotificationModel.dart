// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
class NotificationModel {
  String? id = "";
  String? title = "";
  String? text = "";
  String? level_id = "";
  String? user_id = "";
  String? admin_id = "";
  DateTime? date = DateTime.now();
  NotificationModel({
      this.id,
      this.title,
      this.text,
      this.level_id,
      this.user_id,
      this.admin_id,
      this.date,
  });
  

  NotificationModel copyWith({
    String? id,
    String? title,
    String? text,
    String? level_id,
    String? user_id,
    String? admin_id,
    DateTime? date,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      level_id: level_id ?? this.level_id,
      user_id: user_id ?? this.user_id,
      admin_id: admin_id ?? this.admin_id,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'level_id': level_id,
      'user_id': user_id,
      'admin_id': admin_id,
      'date': date.toString(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      text: map['text'] ?? '',
      level_id: map['level_id'] ?? '',
      user_id: map['user_id'] ?? '',
      admin_id: map['admin_id'] ?? '',
      date: DateTime.parse(map['date']),
      
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(id: $id, text: $text, level_id: $level_id, user_id: $user_id, admin_id: $admin_id, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NotificationModel &&
      other.id == id &&
      other.title == title &&
      other.text == text &&
      other.level_id == level_id &&
      other.user_id == user_id &&
      other.admin_id == admin_id &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      text.hashCode ^
      title.hashCode ^
      level_id.hashCode ^
      user_id.hashCode ^
      admin_id.hashCode ^
      date.hashCode;
  }
}
