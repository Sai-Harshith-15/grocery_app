import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/explore_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/ratings_reviews_controller.dart';
import '../controllers/signup_controller.dart';
import '../controllers/wishlist_controller.dart';
import '../data/interfaces/auth_interface.dart';
import '../data/repositories/firebase_auth_repo.dart';
import '../data/repositories/product_repository.dart';
import '../data/interfaces/api_interface.dart';
import '../data/services/auth_services.dart';
import '../data/services/firebase_services.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    //auth
    Get.lazyPut<AuthInterface>(() => FirebaseAuthServices());
    Get.lazyPut<FirebaseAuthRepo>(
        () => FirebaseAuthRepo(interfaces: Get.find<AuthInterface>()));

    Get.lazyPut<SignupController>(
        () => SignupController(firebaseAuthRepo: Get.find<FirebaseAuthRepo>()));
    Get.lazyPut<LoginController>(
        () => LoginController(firebaseAuthRepo: Get.find<FirebaseAuthRepo>()));

    //

    Get.lazyPut<ApiInterface>(() => FirebaseService());

    Get.lazyPut<ProductRepository>(
        () => ProductRepository(apiInterface: Get.find()));
    Get.lazyPut<ProductController>(
        () => ProductController(repository: Get.find()));
    Get.lazyPut<RatingsAndReviewsController>(
        () => RatingsAndReviewsController(repository: Get.find()));

    //profile binding
    Get.lazyPut(() =>
        ProfileController(firebaseAuthRepo: Get.find<FirebaseAuthRepo>()));
    Get.lazyPut(() =>
        WishlistController(productRepository: Get.find<ProductRepository>()));

    //Cartcontroller binding
    Get.lazyPut(
        () => CartController(productRepository: Get.find<ProductRepository>()));

    //Explorer
    Get.lazyPut<ExploreController>(
        () => ExploreController(repository: Get.find<ProductRepository>()));
  }
}
