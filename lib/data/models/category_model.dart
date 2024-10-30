import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String categoryId;
  String categoryName;
  String categoryDescription;
  String categoryImg;
  Timestamp createdAt;
  Timestamp updatedAt;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryDescription,
    required this.categoryImg,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryDescription': categoryDescription,
      'categoryImg': categoryImg,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      categoryDescription: map['categoryDescription'] as String,
      categoryImg: map['categoryImg'] as String,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
    );
  }
}
