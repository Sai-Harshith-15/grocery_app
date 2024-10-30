import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../controllers/wishlist_controller.dart';
import '../../routes/routes.dart';
import '../widgets/mytext.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final WishlistController wishlistController = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Center(
            child: HeadText(
              text: 'Favorites',
              textColor: AppColors.primaryBlack,
              textWeight: FontWeight.w700,
              textSize: 20,
              textHeight: 18,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Obx(() {
          if (wishlistController.isLoading.value) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (wishlistController.wishlist.isEmpty) {
            return const Center(child: Text('No items in wishlist'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: wishlistController.wishlist.length,
                    itemBuilder: (context, index) {
                      final product = wishlistController.wishlist[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(Routes.productdetails,
                                arguments: product);
                          },
                          leading: CachedNetworkImage(
                            imageUrl: product.coverImg,
                            height: 40,
                            width: 40,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          title: HeadText(
                            text: product.productName,
                            textColor: AppColors.primaryBlack,
                            textWeight: FontWeight.w800,
                            textSize: 12,
                            isTextOverflow: false,
                            maxLines: 2,
                          ),
                          subtitle: const HeadText(text: 'Weight'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryGreen,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      size: 14,
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  )),

                              Container(
                                width: 24,
                                child: HeadText(
                                  textAlign: TextAlign.center,
                                  text: product.productQuantity.toString(),
                                  textSize: 12,
                                  textWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryGreen,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      size: 14,
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  )), // Display quantity

                              const SizedBox(
                                width: 30,
                              ),
                              HeadText(
                                text: "\$${product.productPrice.toString()}",
                                textColor: AppColors.primaryBlack,
                                textWeight: FontWeight.w600,
                                textSize: 16.8,
                              ),

                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.chevron_right,
                                    color: AppColors.primaryBlack,
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),
                // Checkout button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MaterialButton(
                    onPressed: () {},
                    height: 70,
                    color: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HeadText(
                              text: 'Add All to Cart',
                              textColor: AppColors.background,
                              textWeight: FontWeight.w400,
                              textSize: 18.0,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryGreen,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: HeadText(
                                text: '\$12.99',
                                textColor: AppColors.background,
                                textWeight: FontWeight.w600,
                                textSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
