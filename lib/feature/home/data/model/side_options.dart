class SideOptionModel {
  final int id;
  final String name;
  final String image;

  SideOptionModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory SideOptionModel.fromJson(Map<String, dynamic> json) {
    return SideOptionModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
