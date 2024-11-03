import 'package:cloud_firestore/cloud_firestore.dart';

class WishListModel {
  String wishlistId;
  String userId;
  String productId;
  Timestamp createdAt;

  WishListModel({
    required this.wishlistId,
    required this.userId,
    required this.productId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'wishlistId': wishlistId,
      'userId': userId,
      'productId': productId,
      'createdAt': createdAt,
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
