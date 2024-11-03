import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/responsive.dart';
import '../../controllers/explore_controller.dart';
import '../widgets/category_grid_item.dart';
import '../widgets/mytext.dart';
import '../widgets/rounded_textfield.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // final ProductController productController = Get.find<ProductController>();
  final ExploreController exploreController = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () {
          final filteredCategoryDetails =
              exploreController.filterCategoriesList;
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.background,
              title: HeadText(
                text: 'Find Categories',
                textColor: AppColors.primaryBlack,
                textSize: 20,
                textWeight: FontWeight.w700,
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RoundedTextField(
                    controller: exploreController.searchController,
                    hintText: "Search store",
                    prefixIcon: Icons.search,
                    onChanged: (value) {
                      exploreController.updateSearchResults(value);
                      // exploreController.isOverlayVisible.value =
                      //     value.isNotEmpty;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isDesktop(context) ||
                              Responsive.isDesktopLarge(context)
                          ? 3
                          : 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      /* childAspectRatio: Responsive.isDesktop(context) ||
                          Responsive.isDesktopLarge(context)
                      ? 2 / 3
                      : Responsive.isMobile(context) ||
                              Responsive.isMobileLarge(context)
                          ? 2 / 2.25
                          : 2 / 25, */
                    ),
                    itemCount: filteredCategoryDetails.length,
                    itemBuilder: (context, index) {
                      final category = filteredCategoryDetails[index];
                      return CategoryGridItem(
                        category: category,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
