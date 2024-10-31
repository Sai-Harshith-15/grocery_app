import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../data/models/product_model.dart';
import '../../routes/routes.dart';
import 'mytext.dart';
import 'paraText.dart';

class ProductCard extends StatefulWidget {
  ProductModel product;

  ProductCard({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  RxInt count = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: SizedBox(
        height: 220,
        width: 160,
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
                  /*  Get.toNamed(
                    Routes.productdetails,
                    arguments: widget.product,
                  ); */
                  Get.toNamed(
                      "${Routes.productdetails}?productId=${widget.product.productId}",
                      arguments: widget.product);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: widget.product.coverImg,
                        height: 132.0,
                        // width: 140.0,
                        fit: BoxFit.cover,
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
              Stack(children: [
                Row(
                  children: [
                    Column(
                      children: [
                        // Product quantity
                        ParaText(
                          text: '${widget.product.stockQuantity}pcs',
                          textColor: AppColors.secondaryBlack,
                          textSize: 14,
                          textWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 12),
                        HeadText(
                          text: '\$${widget.product.productPrice}',
                          textColor: AppColors.primaryBlack,
                          textSize: 16.8,
                          textWeight: FontWeight.w600,
                        ),
                      ],
                    )
                  ],
                ),
                Obx(
                  () => Positioned(
                    right: 8,
                    bottom: 4,
                    child: count > 1
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  count.value--;
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
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
                                  text: '${widget.product.productQuantity}',
                                  textSize: 11.62,
                                  textWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  count.value++;
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
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              count.value++;
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
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
