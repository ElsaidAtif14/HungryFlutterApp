class ProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String rating;
  final String price;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      rating: json['rating'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'rating': rating,
      'price': price,
    };
  }
}
