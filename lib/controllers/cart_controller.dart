import 'package:get/get.dart';

import '../data/models/cart_model.dart';
import '../data/repositories/product_repository.dart';
import '../presentation/widgets/custom_snackbar.dart';

class CartController extends GetxController {
  final ProductRepository productRepository;

  CartController({required this.productRepository});

  var cartItems = <CartModel>[].obs;
  var isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final fetchedCartItems = await productRepository.fetchCartItems();
      cartItems.assignAll(fetchedCartItems);
    } catch (e) {
      showErrorSnackbar('Error fetching cart items $e');
    }
  }

  Future<void> addItemToCart(CartModel cartModel) async {
    try {
      isLoading(true);

      String result = await productRepository.addItemToCart(cartModel);

      if (result == 'Success') {
        await fetchCartItems();
        showSuccessSnackbar('Item added to cart successfully');
      } else {
        showErrorSnackbar('Failed to add item to cart: $result');
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
      }
    } catch (e) {
      showErrorSnackbar('Error removing item from cart: $e');
    } finally {
      isLoading(false);
    }
  }
}
