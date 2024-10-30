import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/wishlist_controller.dart';
import '../../data/models/product_model.dart';
import '../widgets/inkwell_button.dart';
import '../widgets/mytext.dart';
import '../../constants/responsive.dart';
import '../widgets/paraText.dart';

class ProductdetailsScreen extends StatefulWidget {
  const ProductdetailsScreen({
    super.key,
  });

  @override
  State<ProductdetailsScreen> createState() => _ProductdetailsScreenState();
}

class _ProductdetailsScreenState extends State<ProductdetailsScreen> {
  final productController = Get.find<ProductController>();
  final wishlistController = Get.find<WishlistController>();

  String? productId;
  @override
  void initState() {
    super.initState();

    productId = (Get.arguments as ProductModel?)?.productId;
    if (productId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        productController.fetchSingleProductById(productId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Obx(() {
          final product = productController.selectedProducts.value;

          if (productController.isLoading.value) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (product == null) {
            return const Center(
              child: ParaText(text: "No  product found"),
            );
          }
          bool isFavorited = wishlistController.isInWishlist(product.productId);
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: AppColors.background,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.chevron_left),
                  iconSize: 30.0,
                ),
                centerTitle: true,
                title: ParaText(
                  text: "${product.productName} Details",
                  textSize: 20,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      // Handle exit logic here
                    },
                    icon: const Icon(Icons.share),
                  ),
                ],
              ),
              body: Padding(
                padding: Responsive.isDesktop(context) ||
                        Responsive.isDesktopLarge(context)
                    ? const EdgeInsets.all(100.0)
                    : Responsive.isTablet(context) ||
                            Responsive.isMobileLarge(context)
                        ? const EdgeInsets.all(50)
                        : const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        SizedBox(
                            width: Responsive.isDesktop(context) ||
                                    Responsive.isDesktopLarge(context)
                                ? 600
                                : Responsive.isTablet(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 400
                                    : 300,
                            child: CachedNetworkImage(
                              imageUrl: product!.coverImg,
                              width: Responsive.isDesktop(context) ||
                                      Responsive.isDesktopLarge(context)
                                  ? 600
                                  : Responsive.isTablet(context) ||
                                          Responsive.isMobile(context)
                                      ? 400
                                      : 300,
                              height: Responsive.isDesktop(context) ||
                                      Responsive.isDesktopLarge(context)
                                  ? 400
                                  : Responsive.isTablet(context) ||
                                          Responsive.isMobile(context)
                                      ? 300
                                      : 200,
                            )),
                        // Product Information
                        SizedBox(
                          width: 500, // Adjust width to control how it wraps
                          child: Container(
                            width: Responsive.isDesktop(context) ||
                                    Responsive.isDesktopLarge(context)
                                ? 400
                                : Responsive.isTablet(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 300
                                    : 200, // Wider on desktop
                            // Narrower on mobile
                            padding: Responsive.isDesktop(context) ||
                                    Responsive.isDesktopLarge(context)
                                ? const EdgeInsets.all(
                                    20.0) // More padding on desktop
                                : const EdgeInsets.all(
                                    10.0), // Less padding on mobile
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Name and Heart Button in a Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadText(
                                      text: product.productName.toString(),
                                      textSize: Responsive.isDesktop(context) ||
                                              Responsive.isDesktopLarge(context)
                                          ? 30
                                          : 24,
                                      textWeight: FontWeight.w700,
                                    ),
                                    Obx(() {
                                      bool isFavorited = wishlistController
                                          .isInWishlist(product.productId);
                                      return IconButton(
                                        icon: Icon(
                                          isFavorited
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavorited
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () async {
                                          await wishlistController
                                              .toggleWishlistItem(
                                                  product.productId);
                                        },
                                      );
                                    }),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Product Weight and Price
                                HeadText(
                                  // text: '1Kg, Price',
                                  text:
                                      "${product.stockQuantity.toString()}Kgs in stock",
                                  textSize: Responsive.isDesktop(context) ||
                                          Responsive.isDesktopLarge(context)
                                      ? 18
                                      : 16,
                                  textColor: AppColors.primaryBlack,
                                ),
                                const SizedBox(height: 16),
                                // Quantity Selector
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            /*  if (_quantity > 1) {
                                              setState(() {
                                                _quantity--;
                                              });
                                            } */
                                          },
                                          icon: const Icon(Icons.remove),
                                          color: Colors.black,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 30,
                                              child: Center(
                                                child: HeadText(
                                                  text: /* '$_quantity' */
                                                      product.productQuantity
                                                          .toString(),
                                                  textSize: 18,
                                                  textWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            /* setState(() {
                                              _quantity++;
                                            }); */
                                          },
                                          icon: const Icon(Icons.add),
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    HeadText(
                                      text: /* '\$4.99' */
                                          "\$${product.productPrice.toString()}",
                                      textSize: Responsive.isDesktop(context) ||
                                              Responsive.isDesktopLarge(context)
                                          ? 28
                                          : 24,
                                      textWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Product Details Expansion Tile
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryBackground,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ExpansionTile(
                                    title: HeadText(
                                      text: 'Product Details',
                                      textColor: AppColors.primaryBlack,
                                      textSize: Responsive.isDesktop(context) ||
                                              Responsive.isDesktopLarge(context)
                                          ? 18
                                          : 16,
                                      textWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        child: HeadText(
                                          isTextOverflow: false,
                                          text: product.productDescription,
                                          textSize: 14,
                                          textColor: AppColors.primaryBlack,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                    tilePadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    collapsedShape:
                                        const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryBackground,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ExpansionTile(
                                    title: HeadText(
                                      text: product.productDescription,
                                      textColor: AppColors.primaryBlack,
                                      textSize: Responsive.isDesktop(context) ||
                                              Responsive.isDesktopLarge(context)
                                          ? 18
                                          : 16,
                                      textWeight: FontWeight.w600,
                                    ),
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        child: HeadText(
                                          isTextOverflow: false,
                                          text:
                                              'Apples are nutritious. They may be good for weight loss and heart health. Eating apples as part of a varied diet is beneficial.',
                                          textSize: 14,
                                          textColor: AppColors.primaryBlack,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                    tilePadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    backgroundColor:
                                        AppColors.secondaryBackground,
                                    collapsedBackgroundColor:
                                        AppColors.secondaryBackground,
                                    collapsedIconColor: AppColors.primaryBlack,
                                    iconColor: AppColors.primaryBlack,
                                    collapsedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Center(
                                  child: InkWellButton(
                                    text: 'Add to Cart',
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
