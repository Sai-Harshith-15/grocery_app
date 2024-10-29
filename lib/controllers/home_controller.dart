import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/category_model.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository repository;

  ProductController({required this.repository});

  var isLoading = false.obs;

  var categoriesList = <Category>[].obs;
  var productsList = <ProductModel>[].obs;
//filter
  var filterproductsList = <ProductModel>[].obs;
  var filterCategoriesList = <Category>[].obs;

  var selectedCategoryProducts = <ProductModel>[].obs;

  Rx<ProductModel?> selectedProducts = Rx<ProductModel?>(null);

  Rx<Category?> slectedCategory = Rx<Category?>(null);

  String defaultCategory = "";

  String selectedLocation = 'My Home Bhooja'; // Default location

  // A list of locations to choose from
  final List<String> locations = [
    'My Home Bhooja',
    'Office',
    'Friend\'s Place',
    'Grandma\'s House',
    'Sister\'s Apartment',
  ];
//search controller
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
    searchController.addListener(() {
      filterItems(searchController.text);
    });
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }

  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await repository.fetchCategories();
      categoriesList.assignAll(fetchedCategories);

      filterCategoriesList.value = fetchedCategories;
      if (categoriesList.isNotEmpty) {
        defaultCategory = categoriesList[0].categoryId;
        fetchProductsByCategory(defaultCategory);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories: $e');
    }
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filterproductsList.value = productsList;
      filterCategoriesList.value = categoriesList;
    } else {
      final lowerCaseQuery = query.toLowerCase();

      // Filter products
      filterproductsList.value = productsList
          .where((product) =>
              product.productName.toLowerCase().contains(lowerCaseQuery))
          .toList();

      // Filter categories
      filterCategoriesList.value = categoriesList
          .where((category) =>
              category.categoryName.toLowerCase().contains(lowerCaseQuery))
          .toList();
    }
  }

  Future<void> fetchProducts() async {
    try {
      final products = await repository.getAllProducts();
      productsList.assignAll(products);

      filterproductsList.value = products;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    }
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      final products = await repository.fetchProductsByCategory(categoryId);
      selectedCategoryProducts.assignAll(products);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    }
  }

  Future<void> fetchSingleProductById(String productId) async {
    try {
      isLoading.value = true;

      final ProductModel? product =
          await repository.fetchSingleProductById(productId);

      if (product != null) {
        selectedProducts.value = product;
        try {
          slectedCategory.value = categoriesList.firstWhere(
            (category) => category.categoryId == product.categoryId,
          );
        } catch (e) {
          slectedCategory.value = null;
          print("No matching category found: $e");
        }
      } else {
        print("No Products Found");
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
