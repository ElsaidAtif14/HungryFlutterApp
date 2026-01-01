class ToppingModel {
  final int id;
  final String name;
  final String image;

  ToppingModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
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
