import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../controllers/home_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/mytext.dart';
import '../widgets/product_card.dart';
import '../../constants/responsive.dart';
import '../widgets/rounded_textfield.dart';
import '../widgets/section_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productController = Get.find<ProductController>();

  static final List<String> offerImages = [
    'https://static.vecteezy.com/system/resources/previews/001/381/216/non_2x/special-offer-sale-banner-with-megaphone-free-vector.jpg',
    'https://static.vecteezy.com/system/resources/previews/000/177/648/original/colorful-limited-time-sale-offer-discount-deal-banner-vector.jpg',
    'https://static.vecteezy.com/system/resources/previews/000/676/564/original/offer-sale-abstract-background-with-bold.jpg',
    'https://th.bing.com/th/id/OIP.z0Y_jVgwzp8eHL9G3SqeWAAAAA?w=474&h=222&rs=1&pid=ImgDetMain'
  ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://i.ibb.co/F0s3FHQ/Apricots.png",
                        width: 25,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: Responsive.isMobile(context) ||
                            Responsive.isMobileLarge(context)
                        ? MainAxisAlignment.center
                        : Responsive.isDesktop(context) ||
                                Responsive.isDesktopLarge(context) ||
                                Responsive.isTablet(context)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_pin),
                      const SizedBox(
                        width: 8,
                      ),
                      HeadText(
                        text: "MyHomes, Gachibowli",
                        textColor: AppColors.primaryBlack,
                        textWeight: FontWeight.w600,
                        textSize: 16.8,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  //search
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: Responsive.isDesktop(context) ||
                                  Responsive.isDesktopLarge(context)
                              ? 60
                              : Responsive.isMobile(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? 52
                                  : Responsive.isTablet(context)
                                      ? 56
                                      : 60,
                          width: Responsive.isDesktop(context) ||
                                  Responsive.isDesktopLarge(context)
                              ? screenSize.width * 0.5
                              : Responsive.isMobile(context) ||
                                      Responsive.isMobileLarge(context)
                                  ? screenSize.width * 0.9
                                  : Responsive.isTablet(context)
                                      ? screenSize.width * 0.7
                                      : screenSize.width,
                          child: RoundedTextField(
                            controller: productController.searchController,
                            hintText: "Search store",
                            prefixIcon: Icons.search,
                            onChanged: (value) {
                              productController.updateSearchResults(value);
                            },
                          ),
                        ),
                        Obx(() {
                          final searchText = productController.searchText.value;

                          // Show results container only when search text is not empty
                          if (searchText.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: screenSize.height * 0.4,
                            width: Responsive.isDesktop(context) ||
                                    Responsive.isDesktopLarge(context)
                                ? screenSize.width * 0.5
                                : Responsive.isMobile(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? screenSize.width * 0.9
                                    : Responsive.isTablet(context)
                                        ? screenSize.width * 0.7
                                        : screenSize.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              itemCount:
                                  productController.filterproductsList.length,
                              itemBuilder: (context, index) {
                                final item =
                                    productController.filterproductsList[index];
                                final isProduct = productController
                                    .filterproductsList
                                    .contains(item);

                                return ListTile(
                                  leading: Image.network(
                                    item.coverImg, // Display image for both products and categories
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title: HeadText(
                                    text: item.productName ?? item.categoryName,
                                  ),
                                  subtitle: Text(
                                    isProduct
                                        ? "Product Category: ${item.categoryName}"
                                        : "Category",
                                  ),
                                  onTap: () {
                                    // Handle selection here
                                  },
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  //Carousel
                  Container(
                    child: CarouselSlider(
                        items: offerImages
                            .map((item) => Container(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(item),
                                                fit: BoxFit.fill)),
                                      )),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            height: Responsive.isDesktop(context) ||
                                    Responsive.isDesktopLarge(context)
                                ? 220
                                : Responsive.isMobile(context) ||
                                        Responsive.isMobileLarge(context)
                                    ? 160
                                    : Responsive.isTablet(context)
                                        ? 180
                                        : 220,
                            autoPlay: true,
                            // autoPlayAnimationDuration: Duration(seconds: 1),
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            autoPlayInterval: const Duration(seconds: 3))),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SectionView(
                    title: "Recommended for you",
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController
                            . /* filterproductsList */ productsList
                            .take(10)
                            .length,
                        itemBuilder: (context, index) {
                          final products = productController
                              . /* filterproductsList */ productsList[index];
                          return ProductCard(
                            product: products,
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //Shop By Category
                  SectionView(
                    title: "Shop By Category",
                    isShowSeeAllButton: false,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 84,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController
                            . /* filterCategoriesList */ categoriesList.length,
                        itemBuilder: (context, index) {
                          final category = productController
                                  . /* filterCategoriesList */ categoriesList[
                              index];
                          return CategoryCard(category: category);
                        }),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  //best selling
                  SectionView(
                    title: "Best Selling",
                    onPressed: () {},
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Container(
                    height: 260,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            productController.selectedCategoryProducts.length,
                        itemBuilder: (context, index) {
                          final products =
                              productController.selectedCategoryProducts[index];
                          return ProductCard(
                            product: products,
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
