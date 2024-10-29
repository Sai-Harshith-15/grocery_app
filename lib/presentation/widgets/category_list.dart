import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  CategoryList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              // Handle category selection
            },
            child: Container(
              width: 100,
              child: Column(
                children: [
                  Image.network(category.categoryImageUrl, height: 50, width: 50),
                  Text(category.categoryName, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
