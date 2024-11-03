import 'package:get/get.dart';


import '../data/repositories/product_repository.dart';
import '../presentation/widgets/custom_snackbar.dart';

class RatingsAndReviewsController extends GetxController {

  final ProductRepository repository;

  RatingsAndReviewsController({required this.repository});

  RxBool isLoading = false.obs;
  RxMap<String, dynamic> productRating = <String, dynamic>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // addRating('AzfZfzUP9kF7KICyPZZz', '4crQkaoWRJMsaImZdBoLo6U0Df92', 3);
    // addReview('AzfZfzUP9kF7KICyPZZz', '4crQkaoWRJMsaImZdBoLo6U0Df92', 'super product');
    // fetchProductRatingsAndReview('3KU6DedXLq8Y6q4edUYm');
  }

  Future<void> addRating(String productId, String userId, double rating) async {
    try {
      isLoading(true);

      String result = await repository.addRating(productId, userId, rating);

      if (result == 'Success') {
        showSuccessSnackbar('Rating added successfully');
      } else {
        showErrorSnackbar('Failed to add rating: $result');
      }
    } catch (e) {
      showErrorSnackbar('Error adding rating: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addReview(String productId, String userId, String review) async {
    try {
      isLoading(true);

      String result = await repository.addReview(productId, userId, review);

      if (result == 'Success') {
        showSuccessSnackbar('Review added successfully');
      } else {
        showErrorSnackbar('Failed to add review: $result');
      }
    } catch (e) {
      showErrorSnackbar('Error adding review: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProductRatingsAndReview(String productId) async {
    // Fetch overall rating and review count
    productRating.value = await repository.fetchProductRating(productId);

    showSuccessSnackbar('Overall Rating: ${productRating['overAllRating']}');
    showSuccessSnackbar('Review Count: ${productRating['reviewCount']}');

    // Fetch all user reviews
    List<Map<String, dynamic>> reviews = await repository.fetchAllReviews(productId);

    for (var review in reviews) {
      showSuccessSnackbar('User ID: ${review['userId']}, Rating: ${review['rating']}');
      if (review.containsKey('review')) {
        showSuccessSnackbar('Review: ${review['review']}');
      }
    }
  }

}