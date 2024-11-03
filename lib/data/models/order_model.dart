import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderStatus {orderConfirmed, outForDelivery, delivered}

class OrderModel {
   final String orderId;
  final String userId;
  final List<Map<String, dynamic>> items;
  final DateTime createdAt;
  final String address;
  final OrderStatus orderStatus; 
  final bool applyCoupon;
  final double deliveryTip;
  final String deliveryInstructions;


  OrderModel({
    required this.orderId,
    required this.userId,
    required this. items,
    required this.createdAt,
    required this.address,
    required this.orderStatus,
    required this.applyCoupon,
    required this.deliveryTip,
    required this.deliveryInstructions,
  });

  // Method to convert the OrderModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'orderId' : orderId,
      'userId': userId,
      'items':items,
      'createdAt': FieldValue.serverTimestamp(),
      'address': address,
      'orderStatus': orderStatusToString(orderStatus),
      'applyCoupon':applyCoupon,
      'deliveryTip':deliveryTip,
      'deliveryInstructions':deliveryInstructions,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
     items:map['items'] ?? '',
    createdAt: map['createdAt'] ?? '',
    address: map['address'] ?? '',
    orderStatus: OrderStatus.values.firstWhere(
        (status) => status.name == map['orderStatus'],
        orElse: () => OrderStatus.orderConfirmed,
      ),
    applyCoupon:map['applyCoupon'] ?? '',
    deliveryTip:map['deliveryTip'] ?? '',
    deliveryInstructions:map['deliveryInstructions'] ?? '',
    );
  }
}
String orderStatusToString(OrderStatus status) {
  switch (status) {
    case OrderStatus.orderConfirmed:
      return 'pending';
    case OrderStatus.outForDelivery:
      return 'completed';
    case OrderStatus.delivered:
      return 'canceled';
    default:
      return 'unknown';
  }
}