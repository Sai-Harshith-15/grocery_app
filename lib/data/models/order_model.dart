import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String orderId;
  String userId;
  String productId;
  int quantity;
  double price;
  DateTime createdAt;
  String address;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.address,
  });

  // Method to convert the OrderModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'createdAt': FieldValue.serverTimestamp(),
      'address': address,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? '',
      price: map['price'] ?? '',
      createdAt: map['createdAt'] ?? '',
      address: map['address'] ?? '',
    );
  }
}
