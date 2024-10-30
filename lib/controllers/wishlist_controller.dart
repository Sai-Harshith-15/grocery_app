import 'package:get/get.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';
import '../presentation/widgets/custom_snackbar.dart';

class WishlistController extends GetxController {
  final ProductRepository productRepository;

  WishlistController({required this.productRepository});

  RxList<ProductModel> wishlist = <ProductModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  // Fetch wishlist items with product details

/*   Future<void> fetchWishlist() async {
    try {
      isLoading(true);
      // Fetch wishlist items directly as ProductModel objects
      final fetchedWishlistItems = await productRepository.fetchWishlistItems();
      if (fetchedWishlistItems.isEmpty) {
        showErrorSnackbar('No items found in the wishlist.');
      }
      // Clear and update the wishlist with fetched items
      wishlist.assignAll(fetchedWishlistItems);
    } catch (e) {
      showErrorSnackbar('Failed to fetch Wishlist items: $e');
    } finally {
      isLoading(false);
    }
  } */

  void fetchWishlist() {
    productRepository.fetchWishlistItems().listen((fetchedWishlistItems) {
      wishlist.assignAll(fetchedWishlistItems);
    });
  }

  // Check if a product is in the wishlist
  bool isInWishlist(String productId) {
    return wishlist.any((product) => product.productId == productId);
  }

  // Toggle wishlist item: Add or remove
  Future<void> toggleWishlistItem(String productId) async {
    try {
      isLoading(true);
      if (isInWishlist(productId)) {
        await productRepository.removeItemFromWishlist(productId);
        wishlist.removeWhere((product) => product.productId == productId);
        showSuccessSnackbar('Item removed from Wishlist');
      } else {
        await productRepository.addItemToWishlist(productId);
        final productData =
            await productRepository.getWishlistDetailsByProductById(productId);
        if (productData != null) {
          wishlist.add(productData);
          showSuccessSnackbar('Item added to Wishlist');
        }
      }
    } catch (e) {
      showErrorSnackbar('Error toggling wishlist item: $e');
    } finally {
      isLoading(false);
    }
  }

  // Add an item to the wishlist
  Future<void> addItemToWishlist(String productId) async {
    try {
      isLoading(true);
      final result = await productRepository.addItemToWishlist(productId);

      if (result == 'Success') {
        final productData =
            await productRepository.getWishlistDetailsByProductById(productId);
        if (productData != null) {
          wishlist.add(productData);
          showSuccessSnackbar('Item added to Wishlist successfully');
        }
      } else {
        showErrorSnackbar('Failed to add item to Wishlist: $result');
        print("Failed to add item to Wishlist: $result");
      }
    } catch (e) {
      showErrorSnackbar('Failed to add item to Wishlist: $e');
      print("Failed to add item to Wishlist: $e");
    } finally {
      isLoading(false);
    }
  }

  // Remove an item from the wishlist
  Future<void> removeItemFromWishlist(String productId) async {
    try {
      isLoading(true);
      final result = await productRepository.removeItemFromWishlist(productId);

      if (result == 'Success') {
        wishlist.removeWhere((product) => product.productId == productId);
        showSuccessSnackbar('Item removed from Wishlist successfully');
      } else {
        showErrorSnackbar('Failed to remove item from Wishlist: $result');
      }
    } catch (e) {
      showErrorSnackbar('Error removing item from Wishlist: $e');
    } finally {
      isLoading(false);
    }
  }
}
