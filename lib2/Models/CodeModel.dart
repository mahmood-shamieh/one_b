// ignore_for_file: file_names

class CodeModel {
  String? code = "";
  String? amount = "";
  String? checked = "";
  // ignore: non_constant_identifier_names
  String? user_id = "";
  // ignore: non_constant_identifier_names
  String? user_charge_code_id = "";
  DateTime? date = DateTime.now();
  // ignore: non_constant_identifier_names
  String? first_name = "";
  // ignore: non_constant_identifier_names
  String? last_name = "";
  // ignore: non_constant_identifier_names
  DateTime? updated_at = DateTime.now();
  CodeModel({
    this.code,
    this.amount,
    this.checked,
    // ignore: non_constant_identifier_names
    this.user_id,
    // ignore: non_constant_identifier_names
    this.user_charge_code_id,
    this.date,
    // ignore: non_constant_identifier_names
    this.first_name,
    // ignore: non_constant_identifier_names
    this.last_name,
    // ignore: non_constant_identifier_names
    this.updated_at
  });

  CodeModel copyWith({
    String? code,
    String? amount,
    String? checked,
    // ignore: non_constant_identifier_names
    String? user_id,
    // ignore: non_constant_identifier_names
    String? user_charge_code_id,
    DateTime? date,
  }) {
    return CodeModel(
      code: code ?? this.code,
      amount: amount ?? this.amount,
      checked: checked ?? this.checked,
      user_id: user_id ?? this.user_id,
      user_charge_code_id: user_charge_code_id ?? this.user_charge_code_id,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'amount': amount,
      'checked': checked,
      'user_id': user_id,
      'user_charge_code_id': user_charge_code_id,
      'date': date!.millisecondsSinceEpoch,
      'username_consume':first_name,
      'username_charge':last_name,
    };
  }

  factory CodeModel.fromJson(Map<String, dynamic> map) {
    // print(map);
    return CodeModel(
      code: map['code'].toString() ?? '',
      amount: map['amount'].toString() ?? '',
      checked: map['checked'].toString() ?? '',
      user_id: map['user_id'].toString() ?? '',
      user_charge_code_id: map['user_charge_code_id'].toString() ?? '',
      updated_at: map['updated_at']!=null  ?DateTime.parse(map['updated_at']) : null,
      date: map['date'] != null ?DateTime.parse(map['date']):null,
      first_name: map['username_consume'].toString(),
      last_name: map['username_charge'].toString(),

    );
  }

  @override
  String toString() {
    return 'CodeModel(code: $code, amount: $amount, checked: $checked, user_id: $user_id, user_charge_code_id: $user_charge_code_id, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CodeModel &&
        other.code == code &&
        other.amount == amount &&
        other.checked == checked &&
        other.user_id == user_id &&
        other.user_charge_code_id == user_charge_code_id &&
        other.date == date;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        amount.hashCode ^
        checked.hashCode ^
        user_id.hashCode ^
        user_charge_code_id.hashCode ^
        date.hashCode;
  }
}
