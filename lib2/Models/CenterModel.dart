// ignore_for_file: file_names

class CenterModel {
  String? id = "";
  String? name = "";
  String? address = "";
  String? phone = "";
  String? mobile = "";
  String? active = "";
  DateTime? dateTime = DateTime.now();
  CenterModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.mobile,
    this.active,
    this.dateTime,
  });

  CenterModel copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? mobile,
    String? active,
    DateTime? dateTime,
  }) {
    return CenterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      active: active ?? this.active,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'mobile': mobile,
      'active': active,
      // 'date_time': dateTime.millisecondsSinceEpoch,
    };
  }

  factory CenterModel.fromson(Map<String, dynamic> map) {
    return CenterModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      mobile: map['mobile'] ?? '',
      active: map['active'] ?? '',
      // dateTime: map['date_time'],
    );
  }

  @override
  String toString() {
    return 'CenterModel(id: $id, name: $name, address: $address, phone: $phone, mobile: $mobile, active: $active, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CenterModel &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.phone == phone &&
        other.mobile == mobile &&
        other.active == active &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        mobile.hashCode ^
        active.hashCode ^
        dateTime.hashCode;
  }
}
