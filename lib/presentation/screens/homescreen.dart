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
                      Icon(Icons.location_pin),
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
                  SizedBox(
                    height: 12,
                  ),
                  Center(
                      child: Container(
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
                    ),
                  )),
                  SizedBox(
                    height: 16,
                  ),
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
                            autoPlayInterval: Duration(seconds: 3))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SectionView(
                    title: "Recommended for you",
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController.filterproductsList
                            .take(10)
                            .length,
                        itemBuilder: (context, index) {
                          final products =
                              productController.filterproductsList[index];
                          return ProductCard(
                            product: products,
                          );
                        }),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SectionView(
                    title: "Shop By Category",
                    isShowSeeAllButton: false,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 84,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            productController.filterCategoriesList.length,
                        itemBuilder: (context, index) {
                          final category =
                              productController.filterCategoriesList[index];
                          return CategoryCard(category: category);
                        }),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SectionView(
                    title: "Best Selling",
                    onPressed: () {},
                  ),
                  SizedBox(
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
                  SizedBox(
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
