// ignore_for_file: file_names

class SocialBlockModel {
  String? id;
  String? name;
  String? image;
  String? link;
  String? status;
  SocialBlockModel({
    this.id,
    this.name,
    this.image,
    this.link,
    this.status,
  });

  SocialBlockModel copyWith({
    String? id,
    String? name,
    String? image,
    String? link,
    String? status,
  }) {
    return SocialBlockModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      link: link ?? this.link,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'link': link,
      'status': status,
    };
  }

  factory SocialBlockModel.fromJson(Map<String, dynamic> map) {
    return SocialBlockModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      link: map['link'] ?? '',
      status: map['status'] ?? '',
    );
  }

  @override
  String toString() {
    return 'SocialBlockModel(id: $id, name: $name, image: $image, link: $link, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SocialBlockModel &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.link == link &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        link.hashCode ^
        status.hashCode;
  }
}
