class OrderHistoryModel {
  int id;
  String status;
  String totalPrice;
  String createdAt;
  String productImage;

  OrderHistoryModel({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.productImage,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'],
      status: json['status'],
      totalPrice: json['total_price'],
      createdAt: json['created_at'],
      productImage: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total_price': totalPrice,
      'created_at': createdAt,
      'product_image': productImage,
    };
  }
}
