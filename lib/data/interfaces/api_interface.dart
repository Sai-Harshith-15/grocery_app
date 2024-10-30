import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/wishlist_model.dart';

abstract class ApiInterface {
  Future<List<Category>> getCategories();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<List<ProductModel>> getAllProducts();
  Future<List<CartModel>> fetchCartItems();
  Future<String> addItemToCart(CartModel cartModel);
  //wishlist
  // Future<List<ProductModel>> fetchWishlistItems();
  Stream<List<ProductModel>> fetchWishlistItems();
  Future<List<WishListModel>> addItemToWishlist(String productId);
  Future<ProductModel?> getWishlistDetailsByProductById(String productId);
  Future<String> removeItemFromWishlist(String wishlistId);
//
  Future<String> saveOrder(
      String userId, List<CartModel> cartModel, String address);
  Future<List<OrderModel>> fetchOrders();
  Future<String> removeItemFromCart(String cartId);
  Future<String> addRating(String productId, String userId, double rating);
  Future<String> addReview(String productId, String userId, String review);
  Future<Map<String, dynamic>> fetchProductRating(String productId);
  Future<List<Map<String, dynamic>>> fetchAllReviews(String productId);
  Future<ProductModel?> fetchsingleProductFromFirebase(String productId);
}
