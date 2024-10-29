import 'package:get/get.dart';

import '../data/models/wishlist_model.dart';
import '../data/repositories/product_repository.dart';
import '../presentation/widgets/custom_snackbar.dart';

class WishlistController extends GetxController {
  final ProductRepository productRepository;

  WishlistController({required this.productRepository});

  var wishlistItems = <WishListModel>[].obs;
  RxList<String> wishlist = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    try {
      final fetchedWishlistItems = await productRepository.fetchWishListItems();
      wishlistItems.assignAll(fetchedWishlistItems);
    } catch (e) {
      showErrorSnackbar('Falied to fetch Wishlist items $e');
    }
  }

  // Toggle wishlist item: add if not in wishlist, remove if already added

/* 
  Future<void> toggleWishlistItem(String productId) async {
    try {
      isLoading(true);
      if (isInWishlist(productId)) {
        await productRepository.removeItemFromWishlist(productId);
        showSuccessSnackbar('Item removed from Wishlist');
      } else {
        await productRepository.addItemToWishlist(productId);
        showSuccessSnackbar('Item added to Wishlist');
      }
      await fetchWishlist();
    } catch (e) {
      showErrorSnackbar('Error toggling wishlist item: $e');
    } finally {
      isLoading(false);
    }
  } */

  Future<void> toggleWishlistItem(String productId) async {
    try {
      isLoading(true);
      if (wishlist.contains(productId)) {
        await productRepository.removeItemFromWishlist(productId);
        wishlist.remove(productId); // Remove locally
        showSuccessSnackbar('Item removed from Wishlist');
      } else {
        await productRepository.addItemToWishlist(productId);
        wishlist.add(productId); // Add locally
        showSuccessSnackbar('Item added to Wishlist');
      }
    } catch (e) {
      showErrorSnackbar('Error toggling wishlist item: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addItemToWishlist(String productId) async {
    try {
      isLoading(true);
      final result = await productRepository.addItemToWishlist(productId);

      if (result == 'Success') {
        await fetchWishlist();
        showSuccessSnackbar('Item added to Wishlist successfully');
      } else {
        showErrorSnackbar('Failed to add item to Wishlist: $result');
        print("Failed to add item to Wishlist: $result");
      }
    } catch (e) {
      showErrorSnackbar('Falied to add item to Wishlist $e');
      print("Failed to add item to Wishlist: $e");
    } finally {
      isLoading(false);
    }
  }

  bool isInWishlist(String productId) {
    return wishlist.contains(productId);
  }

  Future<void> removeItemFromCart(String wishlistId) async {
    try {
      isLoading(true);

      String result =
          await productRepository.removeItemFromWishlist(wishlistId);

      if (result == 'Success') {
        await fetchWishlist();
        showSuccessSnackbar('Item removed from wishlist successfully');
      } else {
        showErrorSnackbar('Failed to remove item from wishlist: $result');
      }
    } catch (e) {
      showErrorSnackbar('Error removing item from wishlist: $e');
    } finally {
      isLoading(false);
    }
  }
}
