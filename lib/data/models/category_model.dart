class Category {
  final String categoryId;
  final String categoryName;
  final String categoryImageUrl;

  Category({required this.categoryId, required this.categoryName, required this.categoryImageUrl});

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
        categoryId: data['categoryId'] ?? '',
        categoryName: data['categoryName'] ?? '',
        categoryImageUrl: data['categoryImg'] ?? ''
    );
  }

}
