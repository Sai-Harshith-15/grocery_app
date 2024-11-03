import 'package:get/get.dart';

import '../data/models/cart_model.dart';
import '../data/models/order_model.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';
import '../presentation/widgets/custom_snackbar.dart';
import '../routes/routes.dart';

class CartController extends GetxController {
  final ProductRepository productRepository;

  CartController({required this.productRepository});

  var cartItems = <CartModel>[].obs;
  // var selectedItems = <CartModel>[].obs;
  var productDetails = <String, ProductModel>{}.obs;
  var isLoading = false.obs;
  var isLoadingquant = true.obs;

  @override
  onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final fetchedCartItems = await productRepository.fetchCartItems();
      cartItems.assignAll(fetchedCartItems);
      // selectedItems.clear();
      // selectedItems.assignAll(fetchedCartItems);
    } catch (e) {
      showErrorSnackbar('Error fetching cart items $e');
    }
  }

  Future<void> addItemToCart(CartModel cartModel) async {
    try {
      isLoading(true);
      bool itemExists =
          cartItems.any((item) => item.productId == cartModel.productId);
      if (itemExists) {
        showErrorSnackbar('Item already exists in the cart.');
        return; // Exit the method if the item already exists
      }

      String result = await productRepository.addItemToCart(cartModel);

      if (result == 'Success') {
        await fetchCartItems();
        showSuccessSnackbar('Item added to cart successfully');
      } else {
        showErrorSnackbar('Failed to add item to cart: $result');
        print(result);
      }
    } catch (e) {
      showErrorSnackbar('Error adding item to cart: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> removeItemFromCart(String cartId) async {
    try {
      isLoading(true);

      String result = await productRepository.removeItemFromCart(cartId);

      if (result == 'Success') {
        await fetchCartItems();
        showSuccessSnackbar('Item removed from cart successfully');
      } else {
        showErrorSnackbar('Failed to remove item from cart: $result');
        print(result);
      }
    } catch (e) {
      showErrorSnackbar('Error removing item from cart: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSingleProductByCategory(String productId) async {
    try {
      if (!productDetails.containsKey(productId)) {
        // Only fetch if not already fetched
        ProductModel? product =
            await productRepository.fetchSingleProductByCategory(productId);
        if (product != null) {
          productDetails[productId] = product;
        }
      }
    } catch (e) {
      print("error fetching product details:$e");
    }
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      if (item.isSelected.value) {
        total += item.quantity * item.price;
      }
    }
    return total;
  }

  Future<void> incrementQuantity(String cartId, int currentQuantity) async {
    try {
      isLoadingquant.value = true;
      int newQuantity = currentQuantity + 1;
      await productRepository.incrementProductQuantity(cartId, newQuantity);

      // Update the quantity in the cartItems list
      final item = cartItems.firstWhere((item) => item.cartId == cartId);
      item.quantity.value = newQuantity; // Update the quantity in the model

      //  // Also update in selectedItems if it exists
      // if (selectedItems.contains(item)) {
      //   final selectedItem = selectedItems.firstWhere((selected) => selected.cartId == cartId);
      //   selectedItem.quantity = newQuantity; // Update the quantity in the selected item
      // }

      update(); // Notify listeners of the change
    } catch (e) {
      print("Error incrementing quantity: $e");
    } finally {
      isLoadingquant.value = false;
    }
  }

  Future<void> decrementQuantity(String cartId, int currentQuantity) async {
    try {
      isLoadingquant.value = true;
      if (currentQuantity > 1) {
        // Prevent quantity from going below 1
        int newQuantity = currentQuantity - 1;
        await productRepository.decrementProductQuantity(cartId, newQuantity);

        // Update the quantity in the cartItems list
        final item = cartItems.firstWhere((item) => item.cartId == cartId);
        item.quantity.value = newQuantity; // Update the quantity in the model
        // Also update in selectedItems if it exists
        // if (selectedItems.contains(item)) {
        //   final selectedItem = selectedItems.firstWhere((selected) => selected.cartId == cartId);
        //   selectedItem.quantity = newQuantity; // Update the quantity in the selected item
        // }

        update(); // Notify listeners of the change
      }
    } catch (e) {
      print("Error decrementing quantity: $e");
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }

  Future<void> orderConfirm(
    String userId,
    String address,
    OrderStatus status, // Keep as enum
  ) async {
    try {
      final selectedItems =
          cartItems.where((item) => item.isSelected.value).toList();
      String result = await productRepository.saveOrder(
          userId, selectedItems, address, status);
      if (result == 'Success') {
        for (var item in selectedItems) {
          await productRepository.removeItemFromCart(item.cartId);
        }
        cartItems.removeWhere((item) => selectedItems.contains(item));

        // selectedItems.clear();
        update();

        Get.toNamed(Routes.orderConfirmation);
      } else {
        // Handle failure
        print("Failed to place order: $result");
      }
    } catch (e) {
      // Error handling if there's an exception
      print("Error in order placement: $e");
    }
  }

  void toggleItemSelection(int index) {
    final item = cartItems[index];
    item.isSelected.value = !item.isSelected.value;
    update(); // Notify listeners of the change
  }
}
