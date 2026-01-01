class CartModel {
  int productId;
  int quantity;
  double spicy;
  List<int> toppings;
  List<int> sideOptions;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'spicy': spicy,
      'toppings': toppings,
      'side_options': sideOptions,
    };
  }
}

class CartRequestModel {
  final List<CartModel> items;

  CartRequestModel(this.items);

  Map<String, dynamic> toJson() {
    return {'items': items.map((e) => e.toJson()).toList()};
  }
}

// ===================== RESPONSE =====================

class CartResponseModel {
  int code;
  String message;
  CartDataModel data;

  CartResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      code: json['code'],
      message: json['message'],
      data: CartDataModel.fromJson(json['data']),
    );
  }
}

class CartDataModel {
  int id;
  String totalPrice;
  List<CartItemModel> items;

  CartDataModel({
    required this.id,
    required this.totalPrice,
    required this.items,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json['id'],
      totalPrice: json['total_price'],
      items: (json['items'] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
    );
  }
}

class CartItemModel {
  int itemId;
  int productId;
  String name;
  String image;
  int quantity;
  String price;
  dynamic spicy;
  List<CartToppingModel> toppings;
  List<CartSideOptionModel> sideOptions;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['item_id'],
      productId: json['product_id'],
      name: json['name'],
      image: json['image'],
      quantity: json['quantity'],
      price: json['price'],
      spicy: json['spicy'],
      toppings: (json['toppings'] as List)
          .map((e) => CartToppingModel.fromJson(e))
          .toList(),
      sideOptions: (json['side_options'] as List)
          .map((e) => CartSideOptionModel.fromJson(e))
          .toList(),
    );
  }
}

// ===================== CART ONLY MODELS =====================

class CartToppingModel {
  int id;
  String name;

  CartToppingModel({
    required this.id,
    required this.name,
  });

  factory CartToppingModel.fromJson(Map<String, dynamic> json) {
    return CartToppingModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CartSideOptionModel {
  int id;
  String name;

  CartSideOptionModel({
    required this.id,
    required this.name,
  });

  factory CartSideOptionModel.fromJson(Map<String, dynamic> json) {
    return CartSideOptionModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
