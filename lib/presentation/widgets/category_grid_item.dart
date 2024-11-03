import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../controllers/home_controller.dart';
import '../../routes/routes.dart';
import '../widgets/mytext.dart';
import '../../data/models/category_model.dart';

class CategoryGridItem extends StatefulWidget {
  final Category category;

  const CategoryGridItem({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> {
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.category.categoryId != null) {
          await productController
              .fetchProductsByCategory(widget.category!.categoryId);
          Get.toNamed(Routes.categoryproducts, arguments: widget.category);
        } else {
          print('Category ID is null, cannot fetch products.');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: /* Colors.deepPurple.withOpacity(0.1) */ AppColors.background,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              color: /* Colors.deepPurple.withOpacity(0.6) */
                  AppColors.primaryGreen,
              width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: /* Colors.deepPurple.withOpacity(0.1) */
                    AppColors.background,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.category!.categoryImg,
                    height: 130,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: HeadText(
                  text: widget.category.categoryName,
                  textSize: 16,
                  textWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
