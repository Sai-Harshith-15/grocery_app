import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../globals/globals.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../interfaces/api_interface.dart';
import '../models/wishlist_model.dart';

class FirebaseService implements ApiInterface {
  @override
  Future<List<Category>> getCategories() async {
    QuerySnapshot snapshot =
        await Globals.firestore.collection('categories').get();

    List<Category> categories = snapshot.docs.map((doc) {
      return Category.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    return categories;
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    QuerySnapshot snapshot = await Globals.firestore
        .collection('products')
        .where('categoryId', isEqualTo: category)
        .get();

    List<ProductModel> products = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ProductModel.fromMap(data);
    }).toList();

    return products;
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    QuerySnapshot snapshot =
        await Globals.firestore.collection('products').get();

    List<ProductModel> products = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ProductModel.fromMap(data);
    }).toList();

    return products;
  }

  @override
  Future<String> addItemToCart(CartModel cartModel) async {
    try {
      String? userId = Globals.userId;
      if (userId == null) {
        return 'User not Logged in';
      }

      cartModel.createdAt = DateTime.now();
      cartModel.updatedAt = DateTime.now();
      cartModel.cartId = Globals.firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .id;

      CollectionReference cartRef =
          Globals.firestore.collection('users').doc(userId).collection('cart');

      await cartRef.doc(cartModel.cartId).set(cartModel.toMap());
      return 'Success';
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<String> removeItemFromCart(String cartId) async {
    try {
      String? userId = Globals.userId;
      if (userId == null) {
        return 'User not Logged in';
      }

      CollectionReference cartRef =
          Globals.firestore.collection('users').doc(userId).collection('cart');

      await cartRef.doc(cartId).delete();
      return 'Success';
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<List<CartModel>> fetchCartItems() async {
    try {
      String? userId = Globals.userId;
      if (userId == null) {
        throw Exception("User not logged in");
      }

      CollectionReference cartRef =
          Globals.firestore.collection('users').doc(userId).collection('cart');

      QuerySnapshot snapshot = await cartRef.get();

      return snapshot.docs.map((doc) {
        return CartModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching cart items: $e");
      return [];
    }
  }

  //wishlist

  @override
  Future<String> addItemToWishlist(String productId) async {
    try {
      User? user = Globals.auth.currentUser;
      if (user == null) {
        print('User not logged in');
        return 'User not logged in';
      }

      if (user != null) {
        final DocumentReference docRef = Globals.firestore
            .collection("users")
            .doc(user.uid)
            .collection('wishlist')
            .doc(productId);
        final String wishlistId = docRef.id;

        final WishListModel wishListModel = WishListModel(
          wishlistId: wishlistId,
          userId: user.uid,
          productId: productId,
          createdAt: DateTime.now(),
        );
        await docRef.set(wishListModel.toMap());
      }

      print("Wishlist item added successfully with ID: $productId");
      return 'Success';
    } catch (e) {
      print("Error in adding item to wishlist: $e");
      return 'Failed to add item to Wishlist';
    }
  }

  @override
  Future<List<String>> fetchWishlistItems() async {
    try {
      String? userId = Globals.userId;
      User? user = Globals.auth.currentUser;
      if (userId == null || user == null) {
        throw Exception("User not logged in");
      }
      final wishlistRef = Globals.firestore
          .collection("users")
          .doc(userId)
          .collection('wishlist');

      final snapshot = await wishlistRef.get();

      return snapshot.docs
          .map((doc) =>
              (doc.data() as Map<String, dynamic>)['productId'] as String)
          .toList();
    } catch (e) {
      print("Error fetching cart items: $e");
      return [];
    }
  }

  @override
  Future<String> removeItemFromWishlist(String productId) async {
    try {
      User? user = Globals.auth.currentUser;
      if (user!.uid == null) {
        return 'User not Logged in';
      }
      if (user != null) {
        await Globals.firestore
            .collection("users")
            .doc(user.uid)
            .collection('wishlist')
            .doc(productId)
            .delete();
      }

      /* CollectionReference wishlistRef = Globals.firestore
          .collection('users')
          .doc(user.uid)
          .collection('wishlist');

      await wishlistRef.doc(wishlistId).delete(); */

      return 'Success';
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<String> saveOrder(
      String userId, List<CartModel> cartItems, String address) async {
    try {
      final CollectionReference orderRef = Globals.firestore
          .collection('users')
          .doc(userId)
          .collection('orders');

      for (var item in cartItems) {
        String orderId = orderRef.doc().id;

        OrderModel order = OrderModel(
          orderId: orderId,
          userId: userId,
          productId: item.productId,
          quantity: item.quantity,
          price: item.price,
          createdAt: DateTime.now(),
          address: address,
        );

        await orderRef.doc(orderId).set(order.toMap());
      }
      return 'Success';
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<List<OrderModel>> fetchOrders() async {
    try {
      String? userId = Globals.userId;
      final CollectionReference orderRef = Globals.firestore
          .collection('users')
          .doc(userId)
          .collection('orders');

      QuerySnapshot snapshot = await orderRef.get();

      List<OrderModel> orders = snapshot.docs.map((doc) {
        return OrderModel.fromMap(doc.data() as Map<String, dynamic>)
          ..createdAt = (doc['createdAt'] as Timestamp).toDate();
      }).toList();

      return orders;
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  @override
  Future<String> addRating(
      String productId, String userId, double rating) async {
    try {
      CollectionReference ratingsRef = Globals.firestore
          .collection('products')
          .doc(productId)
          .collection('ratingsAndReviews');

      DocumentReference productRef =
          Globals.firestore.collection('products').doc(productId);

      // Add or update user's rating in the ratings subcollection
      await ratingsRef.doc(userId).set({
        'rating': rating,
      }, SetOptions(merge: true)); // Only update the rating field

      // Fetch current product data to update overall rating
      DocumentSnapshot productSnapshot = await productRef.get();
      double currentOverallRating = productSnapshot.get('overAllRating') ?? 0.0;
      int reviewCount = productSnapshot.get('reviewCount') ?? 0;

      // Calculate new overall rating
      double newOverallRating =
          ((currentOverallRating * reviewCount) + rating) / (reviewCount + 1);

      // Update product's overall rating and review count
      await productRef.update({
        'overAllRating': newOverallRating,
        'reviewCount': reviewCount + 1,
      });

      return 'Success';
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<String> addReview(
      String productId, String userId, String review) async {
    try {
      CollectionReference reviewsRef = Globals.firestore
          .collection('products')
          .doc(productId)
          .collection('ratingsAndReviews');

      // Add or update user's review in the ratings subcollection
      await reviewsRef.doc(userId).set({
        'review': review,
      }, SetOptions(merge: true)); // Only update the review field

      return 'Success';
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<Map<String, dynamic>> fetchProductRating(String productId) async {
    try {
      DocumentReference productRef =
          Globals.firestore.collection('products').doc(productId);

      DocumentSnapshot productSnapshot = await productRef.get();

      if (productSnapshot.exists) {
        // Extract 'overAllRating' and 'reviewCount' from the document
        var data = productSnapshot.data() as Map<String, dynamic>;
        double overAllRating = data['overAllRating'] ?? 0.0;
        int reviewCount = data['reviewCount'] ?? 0;

        // Return them in a map
        return {
          'overAllRating': overAllRating,
          'reviewCount': reviewCount,
        };
      } else {
        print('Product not found');
        return {
          'overAllRating': 0.0,
          'reviewCount': 0,
        };
      }
    } catch (e) {
      print('Error fetching product rating: $e');
      return {
        'overAllRating': 0.0,
        'reviewCount': 0,
      };
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllReviews(String productId) async {
    try {
      CollectionReference ratingsRef = Globals.firestore
          .collection('products')
          .doc(productId)
          .collection('ratingsAndReviews');

      QuerySnapshot reviewsSnapshot = await ratingsRef.get();

      // Extract reviews from documents
      List<Map<String, dynamic>> reviews = reviewsSnapshot.docs.map((doc) {
        final data = doc.data()
            as Map<String, dynamic>; // Cast doc.data() to Map<String, dynamic>
        return {
          'userId': doc.id,
          'rating': data['rating'],
          if (data.containsKey('review'))
            'review': data['review'], // Include review only if it exists
        };
      }).toList();

      return reviews;
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
  }

  @override
  Future<ProductModel?> fetchsingleProductFromFirebase(String productId) async {
    try {
      DocumentSnapshot productDoc =
          await Globals.firestore.collection('products').doc(productId).get();
      if (productDoc.exists) {
        return ProductModel.fromMap(productDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error in fetching the single product : $e");
    }
    return null;
  }
}
