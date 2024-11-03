import 'package:flutter/material.dart';

import '../presentation/screens/auth/forgot_password_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/onboarding_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/auth/splash_screen.dart';
import '../presentation/screens/auth/welcome_screen.dart';
import '../presentation/screens/cart/cart_screen.dart';
import '../presentation/screens/category_products_screen.dart';
import '../presentation/screens/explore_scren.dart';
import '../presentation/screens/favorurite_screen.dart';
import '../presentation/screens/homescreen.dart';
import '../presentation/screens/maintab_screen.dart';
import '../presentation/screens/order_conformation.dart';
import '../presentation/screens/productdetails_screen.dart';
import '../presentation/screens/products_screen.dart';
import '../presentation/screens/profile_screen.dart';

class Routes {
  static const String tab = '/tab';
  static const String splashscreen = '/splashscreen';
  static const String onboardscreen = '/onboardscreen';
  static const String welcomescreen = '/welcomescreen';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String home = '/home';
  static const String explore = '/explore';
  static const String cart = '/cart';
  static const String favorite = '/favorite';
  static const String productdetails = '/productdetails';
  static const String profile = '/profile';
  static const String products = '/products';
  static const String categoryproducts = '/categoryproducts';
  static const String orderConfirmation = '/OrderConfirmationScreen';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      tab: (BuildContext context) => MainTabScreen(),
      splashscreen: (BuildContext context) => SplashScreen(),
      onboardscreen: (BuildContext context) => OnboardingScreen(),
      welcomescreen: (BuildContext context) => WelcomeScreen(),
      login: (BuildContext context) => LoginScreen(),
      forgotPassword: (BuildContext context) => ForgotPasswordScreen(),
      signup: (BuildContext context) => SignupPage(),
      home: (BuildContext context) => HomeScreen(),
      explore: (BuildContext context) => ExploreScreen(),
      cart: (BuildContext context) => CartScreen(),
      favorite: (BuildContext context) => FavoriteScreen(),
      profile: (BuildContext context) => ProfileScreen(),
      productdetails: (BuildContext context) => ProductdetailsScreen(),
      products: (BuildContext context) => ProductsScreen(),
      categoryproducts: (BuildContext context) => CategoryProducts(),
      orderConfirmation: (BuildContext context) => OrderConfirmationScreen()
    };
  }
}
