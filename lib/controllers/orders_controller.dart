import 'package:get/get.dart';

import '../data/models/order_model.dart';
import '../data/repositories/product_repository.dart';

class OrdersController extends GetxController {
  final ProductRepository productRepository;

  OrdersController({required this.productRepository});

  var orders = <OrderModel>[].obs;

  Future<void> loadOrders() async {
    orders.value = await productRepository.fetchOrders();
  }
}
