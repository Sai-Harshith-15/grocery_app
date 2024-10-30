import 'package:cloud_firestore/cloud_firestore.dart';

class WishListModel {
  String wishlistId; // Auto-generated
  String userId; // Reference to users
  String productId; // Reference to products
  Timestamp createdAt; // Now using Timestamp

  WishListModel({
    required this.wishlistId,
    required this.userId,
    required this.productId,
    required this.createdAt,
  });

  // Convert a WishListModel to a Map (to store in database)
  Map<String, dynamic> toMap() {
    return {
      'wishlistId': wishlistId,
      'userId': userId,
      'productId': productId,
      'createdAt': createdAt, // No need to convert to string
    };
  }

  // Create a WishListModel from a Map (retrieved from database)
  factory WishListModel.fromMap(Map<String, dynamic> map) {
    return WishListModel(
      wishlistId: map['wishlistId'] ?? '',
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }
}
