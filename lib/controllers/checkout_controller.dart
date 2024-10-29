import 'package:get/get.dart';

import '../data/models/cart_model.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

class CheckoutController extends GetxController {
  final ProductRepository productRepository;

  CheckoutController({required this.productRepository});

  var totalPrice = 0.0.obs;
  var discountAmount = 0.0.obs;

  void calculateTotal(List<ProductModel> products, List<int> quantities) {
    totalPrice.value = 0.0;
    discountAmount.value = 0.0;

    for (int i = 0; i < products.length; i++) {
      var product = products[i];
      var quantity = quantities[i];

      var price = product.productPrice * quantity;
      var discount = product.productDiscount > 0
          ? (price * (product.productDiscount / 100))
          : 0;

      totalPrice.value += price;
      discountAmount.value += discount;
    }
  }

  Future<void> checkout(
      List<CartModel> cartItems, String userId, String address) async {
    await productRepository.saveOrder(userId, cartItems, address);
  }
}
