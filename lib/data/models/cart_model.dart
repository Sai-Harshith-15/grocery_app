class CartModel {
  String cartId; // Auto-generated
  String userId; // Reference to users
  DateTime createdAt; // Timestamp for creation
  DateTime updatedAt; // Timestamp for last update
  String productId; // Reference to products
  int quantity; // Number of items in the cart
  double price; // Price of the product

  CartModel({
    required this.cartId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  // Convert a CartModel to a Map (to store in database)
  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }

  // Create a CartModel from a Map (retrieved from database)
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['cartId'],
      userId: map['userId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price'].toDouble(), // Ensure price is a double
    );
  }
}
