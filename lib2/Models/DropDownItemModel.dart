// ignore_for_file: file_names, unnecessary_this

class DropDownMenuItemModel {
  String? id = "";
  // ignore: non_constant_identifier_names
  String? dropdown_id = "";
  String? name = "";
  String? bill = "";
  String? cost = "";
  DropDownMenuItemModel({
    this.id,
    // ignore: non_constant_identifier_names
    this.dropdown_id,
    this.cost,
    this.name,
    this.bill,
  });

  DropDownMenuItemModel copyWith({
    String? id,
    // ignore: non_constant_identifier_names
    String? dropdown_id,
    String? name,
    String? bill,
  }) {
    return DropDownMenuItemModel(
      id: id ?? this.id,
      dropdown_id: dropdown_id ?? this.dropdown_id,
      name: name ?? this.name,
      bill: bill ?? this.bill,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'dropdown_id': dropdown_id,
      'name': name,
      'bill': bill,
      'cost':cost
    };
  }

  factory DropDownMenuItemModel.fromJson(Map map) {
    // print(map['id']);
    return DropDownMenuItemModel(
      id: map['id'].toString() ?? '',
      dropdown_id: map['dropdown_id'].toString() ?? '',
      name: map['name'].toString() ?? '',
      bill: map['bill'].toString() ?? '',
      cost: map['cost'].toString() ?? '',
    );
  }

  @override
  String toString() {
    return name.toString() + (cost == "0" ? "" :" بسعر $cost");
    // return '$name بسعر $cost';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropDownMenuItemModel &&
        other.id == id &&
        other.dropdown_id == dropdown_id &&
        other.name == name &&
        other.bill == bill;
  }

  @override
  int get hashCode {
    return id.hashCode ^ dropdown_id.hashCode ^ name.hashCode ^ bill.hashCode;
  }
  
}
