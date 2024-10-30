import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../interfaces/api_interface.dart';
import '../models/wishlist_model.dart';

class ProductRepository {
  final ApiInterface apiInterface;

  ProductRepository({required this.apiInterface});

  Future<List<Category>> fetchCategories() async {
    return await apiInterface.getCategories();
  }

  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    return await apiInterface.getProductsByCategory(category);
  }

  Future<ProductModel?> fetchSingleProductById(String productId) async {
    return await apiInterface.fetchsingleProductFromFirebase(productId);
  }

  Future<List<ProductModel>> getAllProducts() async {
    return await apiInterface.getAllProducts();
  }

  Future<String> addItemToCart(CartModel cartModel) async {
    return await apiInterface.addItemToCart(cartModel);
  }

  /*  Future<List<ProductModel>> fetchWishlistItems() async {
    return await apiInterface.fetchWishlistItems();
  } */

  Stream<List<ProductModel>> fetchWishlistItems() {
    return apiInterface.fetchWishlistItems();
  }

  Future<List<WishListModel>> addItemToWishlist(String productId) async {
    return await apiInterface.addItemToWishlist(productId);
  }

  Future<String> removeItemFromWishlist(String wishlistId) async {
    return await apiInterface.removeItemFromWishlist(wishlistId);
  }

  Future<ProductModel?> getWishlistDetailsByProductById(
      String productId) async {
    return await apiInterface.getWishlistDetailsByProductById(productId);
  }
  //

  Future<List<CartModel>> fetchCartItems() async {
    return await apiInterface.fetchCartItems();
  }

  Future<String> saveOrder(
      String userId, List<CartModel> cartItems, String address) async {
    return await apiInterface.saveOrder(userId, cartItems, address);
  }

  Future<List<OrderModel>> fetchOrders() async {
    return await apiInterface.fetchOrders();
  }

  Future<String> removeItemFromCart(String cartId) async {
    return await apiInterface.removeItemFromCart(cartId);
  }

  Future<String> addRating(
      String productId, String userId, double rating) async {
    return await apiInterface.addRating(productId, userId, rating);
  }

  Future<String> addReview(
      String productId, String userId, String review) async {
    return await apiInterface.addReview(productId, userId, review);
  }

  Future<Map<String, dynamic>> fetchProductRating(String productId) async {
    return await apiInterface.fetchProductRating(productId);
  }

  Future<List<Map<String, dynamic>>> fetchAllReviews(String productId) async {
    return await apiInterface.fetchAllReviews(productId);
  }
}
