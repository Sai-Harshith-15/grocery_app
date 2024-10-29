import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../data/models/category_model.dart';
import 'mytext.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 84,
        width: 84,
        child: Card(
          elevation: 0,
          color: AppColors.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: category.categoryImageUrl,
                  fit: BoxFit.cover,
                  height: 52,
                  width: 56,
                ),
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: HeadText(
                  text: category.categoryName,
                  textSize: 9.62,
                  textWeight: FontWeight.w600,
                  textColor: AppColors.primaryBlack,
                  isTextOverflow: false,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
