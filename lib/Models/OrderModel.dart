// ignore_for_file: file_names, unnecessary_this

import 'dart:convert';

class OrderModel {
  String? id = "";
  String? title = "";
  String? content = "";
  DateTime? dateTime;
  DateTime? finishDate;
  String? bill = "";
  String? cost = "";
  String? finished = "";
  dynamic inputs = "";
  String? subcatsId = "";
  bool? askOrderSent ;
  String? catName = "";
  OrderModel(
      {this.title,this.subcatsId,this.id,
      this.finishDate,
      this.content,
      this.dateTime,
      this.askOrderSent,
      this.bill,
      this.cost,
      this.inputs,
      this.catName,
      this.finished});

  OrderModel copyWith({
    String? title,
    String? id,
    String? content,
    DateTime? dateTime,
    String? bill,
    String? cost,
    String? finishDate,
    dynamic inputs,
    bool? askOrderSent,
    String? catName,
  }) {
    return OrderModel(
        title: title ?? this.title,
        id: id ?? this.id,
        content: content ?? this.content,
        dateTime: dateTime ?? this.dateTime,
        bill: bill ?? this.bill,
        cost: cost ?? this.cost,
        finished: finished ?? this.finished,
        finishDate:  finishDate as DateTime,
        inputs: inputs ?? this.inputs,
        askOrderSent: askOrderSent ?? this.askOrderSent,
        catName: catName ?? this.catName
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'id': id,
      'ask_order_sent': askOrderSent,
      'dateTime': dateTime!.millisecondsSinceEpoch,
      'bill': bill,
      'cost': cost,
      'finished_date': finishDate!.microsecondsSinceEpoch,
      'inputs':json.decode(inputs),
      'finished': finished,
      'subcat_id':subcatsId,
      'cat_name':catName
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      askOrderSent: map['ask_order_sent'] ?? '',
      content: map['content'] ?? 'لا يوجد نتيجة بعد',
      dateTime: map['date_time'],
      bill: map['bill'] ?? '',
      cost: map['cost'] ?? '',
      finished: map['finished'] ?? '',
      inputs: json.decode(map['inputs']) ?? '',
      finishDate: map['finished_date'] ?? '',
      subcatsId: map['subcat_id'] ?? '',
      catName: map['cat_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(title: $title, content: $content, dateTime: $dateTime, bill: $bill, cost: $cost)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.title == title &&
        other.id == id &&
        other.askOrderSent == askOrderSent &&
        other.content == content &&
        other.dateTime == dateTime &&
        other.bill == bill &&
        other.finishDate == finishDate &&
        other.cost == cost;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        content.hashCode ^
        dateTime.hashCode ^
        bill.hashCode ^
        cost.hashCode;
  }
}
