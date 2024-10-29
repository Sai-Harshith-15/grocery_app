import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../data/models/category_model.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;

  const CategoryGridItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate container height based on screen width or constraints
        final containerHeight = constraints.maxWidth * 1.315; // Adjust as needed

        return Container(
          height: containerHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.deepPurple.withOpacity(0.6), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.deepPurple.withOpacity(0.1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    category.categoryImageUrl,
                    height: containerHeight / 2, // Half the height of the container
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.deepPurple.withOpacity(0.1),
                height: containerHeight / 2, // Fill the remaining half
                child: Center(
                  child: Text(
                    category.categoryName,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
