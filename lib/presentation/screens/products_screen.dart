import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/home_controller.dart';
import '../../data/models/product_model.dart';
import '../../routes/routes.dart';
import '../widgets/mytext.dart';
import '../widgets/products_card.dart';
import '../widgets/rounded_textfield.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    final products = Get.arguments as List<ProductModel>? ?? [];
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
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
          title: Center(
            child: HeadText(
              text: 'Products',
              textColor: AppColors.primaryBlack,
              textWeight: FontWeight.w700,
              textSize: 18,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              RoundedTextField(
                prefixIcon: Icons.search,
                hintText: "Search products",
              ),
              SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio:
                        1.5 / 2.6, // Aspect ratio for product cards
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: products[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
