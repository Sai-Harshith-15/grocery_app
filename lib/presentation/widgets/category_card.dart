import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../controllers/home_controller.dart';
import '../../data/models/category_model.dart';
import '../../routes/routes.dart';
import 'mytext.dart';

class CategoryCard extends StatefulWidget {
  final Category? category;

  CategoryCard({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
        height: 120,
        width: 128,
        child: GestureDetector(
          onTap: () async {
            if (widget.category?.categoryId != null) {
              await productController
                  .fetchProductsByCategory(widget.category!.categoryId);
              Get.toNamed(Routes.categoryproducts, arguments: widget.category);
            } else {
              // Handle the case when categoryId is null (e.g., show a message or do nothing)
              print('Category ID is null, cannot fetch products.');
            }
          },
          child: Card(
            elevation: 2,
            color: AppColors.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.category?.categoryImg ?? '',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: HeadText(
                    text: widget.category?.categoryName ?? '',
                    textSize: 14,
                    textWeight: FontWeight.w600,
                    textColor: AppColors.primaryBlack,
                    isTextOverflow: false,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
