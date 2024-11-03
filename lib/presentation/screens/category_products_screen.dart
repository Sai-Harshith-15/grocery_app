import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/explore_controller.dart';
import '../../controllers/home_controller.dart';
import '../../data/models/category_model.dart';
import '../widgets/mytext.dart';
import '../widgets/products_card.dart';
import '../widgets/rounded_textfield.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  final productController = Get.find<ProductController>();

  final ExploreController exploreController = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    Category category = Get.arguments;
    return SafeArea(
      child: Obx(
        () => Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: AppColors.primaryBlack,
                size: 36,
                weight: 20,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: HeadText(
              text: '${category.categoryName}',
              textColor: AppColors.primaryBlack,
              textWeight: FontWeight.w700,
              textSize: 18,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                RoundedTextField(
                  controller: exploreController.searchController,
                  prefixIcon: Icons.search,
                  hintText: "Search ${category.categoryName}",
                  onChanged: (value) {},
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.75, // Aspect ratio for product cards
                    ),
                    itemCount:
                        productController.selectedCategoryProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product:
                            productController.selectedCategoryProducts[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
