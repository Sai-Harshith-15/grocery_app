import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/home_controller.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/product_model.dart';
import '../../globals/globals.dart';
import '../../routes/routes.dart';
import 'mytext.dart';
import 'paraText.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  ProductCard({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  RxInt count = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: SizedBox(
        height: 184,
        width: 128,
        child: Card(
          elevation: 0,
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // widget.onTap;
                  Get.toNamed(Routes.productdetails, arguments: widget.product);
                  // Add any action you want to trigger on tap
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.coverImg,
                          height: 96.0,
                          // width: 140.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // Product title
                    HeadText(
                      text: widget.product.productName,
                      textColor: AppColors.primaryBlack,
                      textWeight: FontWeight.w700,
                      textSize: 14.0,
                      // maxLines: 2,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product quantity
                  ParaText(
                    text: '${widget.product.stockQuantity}pcs',
                    textColor: AppColors.secondaryBlack,
                    textSize: 14,
                    textWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadText(
                        text: '\$${widget.product.productPrice}',
                        textColor: AppColors.primaryBlack,
                        textSize: 16.8,
                        textWeight: FontWeight.w600,
                      ),
                      Obx(
                        () => Container(
                          child: count.value >= 1
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        count.value--;
                                        if (count.value <= 0) {
                                          print(
                                              '+++++++++ product removed from cart');
                                          cartController.removeItemFromCart(
                                              widget.product.categoryId);
                                        }
                                        // cartController.decrementQuantity(
                                        //     widget.product.categoryId,
                                        //     count.value);
                                      },
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColors.secondaryBlack,
                                        ),
                                        child: const Icon(
                                          size: 16,
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 24,
                                      child: ParaText(
                                        textAlign: TextAlign.center,
                                        text: '${count.value}',
                                        textSize: 11.62,
                                        textWeight: FontWeight.w600,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        count.value++;
                                        // cartController.incrementQuantity(
                                        //     widget.product.categoryId,
                                        //     count.value);
                                      },
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColors.primaryGreen,
                                        ),
                                        child: const Icon(
                                          size: 16,
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : InkWell(
                                  onTap: () {
                                    count.value = 1;
                                    cartController.addItemToCart(CartModel(
                                      cartId: widget.product.categoryId,
                                      userId: Globals.userId!,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      productId:
                                          widget.product.productDescription,
                                      quantity: widget.product.productQuantity,
                                      price: widget.product.productPrice,
                                      productImg: widget.product.coverImg,
                                      productQuantity:
                                          widget.product.productQuantity,
                                      productname: widget.product.productName,
                                    ));
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.primaryGreen,
                                    ),
                                    child: const Icon(
                                      size: 16,
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
