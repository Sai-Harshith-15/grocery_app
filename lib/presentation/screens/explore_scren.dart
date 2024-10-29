import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive.dart';
import '../../controllers/home_controller.dart';
import '../widgets/category_grid_item.dart';
import '../widgets/mytext.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Center(
          child: HeadText(
            text: 'Find Products',
            textColor: AppColors.primaryBlack,
            textSize: 20,
            textWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_sharp,
                  color: AppColors.primaryBlack,
                ),
                hintText: 'Search Store',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none, // Removes the outline border
                ),
                filled: true, // Ensures the background color is applied
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;

                // Adjust grid columns based on screen width
                if (Responsive.isDesktop(context) ||
                    Responsive.isDesktopLarge(context)) {
                  crossAxisCount = 5; // Desktop
                } else if (Responsive.isTablet(context)) {
                  crossAxisCount = 4; // Tablet Landscape
                } else if (Responsive.isMobileLarge(context)) {
                  crossAxisCount = 3; // Tablet Portrait
                } else {
                  crossAxisCount = 2; // Mobile
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio:
                        3 / 4, // Adjust for image/text proportions
                  ),
                  itemCount: productController.categoriesList.length,
                  itemBuilder: (context, index) {
                    final category = productController.categoriesList[index];
                    return CategoryGridItem(category: category);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
