import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/category_model.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

class ExploreController extends GetxController {
  final ProductRepository repository;

  ExploreController({required this.repository});
  var isLoading = false.obs;
  var categoriesList = <Category>[].obs;
  var productsList = <ProductModel>[].obs;
  var selectedCategoryProducts = <ProductModel>[].obs;

  //filter
  var filterproductsList = <ProductModel>[].obs;
  var filterCategoriesList = <Category>[].obs;

  var searchText = ''.obs;
  TextEditingController searchController = TextEditingController();
  RxBool isOverlayVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
    searchController.addListener(() {
      filterItems(searchController.text);
      updateSearchResults(searchController.text);
    });
    /* searchController.addListener(() {
      searchText.value = searchController.text; // Update reactive variable
      // filterItems(searchController.text);
      updateSearchResults(
          searchController.text); // Filter products based on search
      isOverlayVisible.value = searchController.text.isNotEmpty;
    }); */
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await repository.fetchCategories();
      categoriesList.assignAll(fetchedCategories);

      // filterCategoriesList.value = fetchedCategories;
      filterCategoriesList.assignAll(fetchedCategories);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories: $e');
    }
  }

  Future<void> fetchProducts() async {
    try {
      final products = await repository.getAllProducts();
      productsList.assignAll(products);

      // filterproductsList.value = products;
      filterproductsList.assignAll(products);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    }
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      selectedCategoryProducts.clear();
      final products = await repository.fetchProductsByCategory(categoryId);
      selectedCategoryProducts.assignAll(products);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    }
  }

/*   void filterItems(String query) {
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
  } */
  void filterItems(String query, {Category? selectedCategory}) {
    if (query.isEmpty) {
      filterproductsList.value =
          selectedCategory != null ? selectedCategoryProducts : productsList;
      filterCategoriesList.value = categoriesList;
    } else {
      final lowerCaseQuery = query.toLowerCase();

      // Filter products by selected category and query
      final productsToFilter =
          selectedCategory != null ? selectedCategoryProducts : productsList;
      filterproductsList.value = productsToFilter
          .where((product) =>
              product.productName.toLowerCase().contains(lowerCaseQuery))
          .toList();

      // Filter categories if needed
      filterCategoriesList.value = categoriesList
          .where((category) =>
              category.categoryName.toLowerCase().contains(lowerCaseQuery))
          .toList();
    }
    isOverlayVisible.value = query.isNotEmpty;
  }

  void updateSearchResults(String query) {
    final lowerCaseQuery = query.toLowerCase();

    // Filter products and categories based on search text
    filterproductsList.value = productsList
        .where((product) =>
            product.productName.toLowerCase().contains(lowerCaseQuery))
        .toList();

    filterCategoriesList.value = categoriesList
        .where((category) =>
            category.categoryName.toLowerCase().contains(lowerCaseQuery))
        .toList();

    filterproductsList.value = selectedCategoryProducts
        .where((product) =>
            product.productName.toLowerCase().contains(lowerCaseQuery))
        .toList();
  }
}
