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
          .doc()
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
  Future<List<WishListModel>> addItemToWishlist(String productId) async {
    List<WishListModel> wishlistList = [];
    try {
      User? user = Globals.auth.currentUser;
      if (user == null) {
        print('User not logged in');
        return [];
      }

      DocumentReference docRef = Globals.firestore
          .collection("users")
          .doc(user.uid)
          .collection('wishlist')
          .doc(productId);
      final String wishlistId = docRef.id;

      final WishListModel wishListModel = WishListModel(
        wishlistId: wishlistId,
        userId: user.uid,
        productId: productId,
        createdAt: Timestamp.now(),
      );
      await docRef.set(wishListModel.toMap());

      wishlistList.add(wishListModel);
    } catch (e) {
      print("Error in adding the wishlist $e");
    }
    return wishlistList;
  }

  @override
  Stream<List<ProductModel>> fetchWishlistItems() {
    String? userId = Globals.userId;
    if (userId == null) {
      throw Exception("User not logged in");
    }

    // Listen to the user's wishlist collection
    final wishlistRef = Globals.firestore
        .collection("users")
        .doc(userId)
        .collection('wishlist');

    return wishlistRef.snapshots().asyncMap((wishlistSnapshot) async {
      List<ProductModel> products = [];

      // Extract product IDs from wishlist items
      List<String> productIds = wishlistSnapshot.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      // Fetch each product’s details based on its ID
      for (String productId in productIds) {
        final productSnapshot =
            await Globals.firestore.collection("products").doc(productId).get();

        if (productSnapshot.exists) {
          final productData = productSnapshot.data();
          if (productData != null) {
            products.add(ProductModel.fromMap(productData));
          }
        } else {
          print("Product not found for ID: $productId");
        }
      }
      return products;
    });
  }

  @override
  Future<ProductModel?> getWishlistDetailsByProductById(
      String productId) async {
    try {
      User? user = Globals.auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      final doc = await Globals.firestore
          .collection('users')
          .doc(user.uid)
          .collection('wishlist')
          .doc(productId)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel.fromMap(data);
      } else {
        print("No wishlist item found for product ID: $productId");
        return null;
      }
    } catch (e) {
      print("Error fetching product: $e");
      return null;
    }
  }

  @override
  Future<String> removeItemFromWishlist(String wishlistId) async {
    try {
      String? userId = Globals.userId;
      if (userId == null) {
        return 'User not Logged in';
      }

      CollectionReference wishlistRef = Globals.firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist');

      await wishlistRef.doc(wishlistId).delete();
      return 'Success';
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<String> saveOrder(String userId, List<CartModel> cartItems,
      String address, OrderStatus status) async {
    try {
      final CollectionReference userOrderRef = Globals.firestore
          .collection('users')
          .doc(userId)
          .collection('userOrders');

      String orderId = userOrderRef.doc().id;

      List<Map<String, dynamic>> items = cartItems
          .map((item) => {
                'productId': item.productId,
                'quantity': item.quantity,
                'price': item.price,
              })
          .toList();

      // Create the order model
      OrderModel order = OrderModel(
        orderId: orderId,
        userId: userId,
        items: items,
        createdAt: DateTime.now(),
        address: address,
        orderStatus: status, // Keep as enum
        applyCoupon: true,
        deliveryTip: 23,
        deliveryInstructions: '',
      );

      await userOrderRef.doc(orderId).set(order.toMap());

      return 'Success';
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<List<OrderModel>> fetchOrders() async {
    try {
      // final CollectionReference orderRef = Globals.firestore.collection('orders');
      //
      // QuerySnapshot snapshot = await orderRef.get();
      //
      // List<OrderModel> orders = snapshot.docs.map((doc) {
      //   return OrderModel.fromMap(doc.data() as Map<String, dynamic>)
      //     ..createdAt = (doc['createdAt'] as Timestamp).toDate();
      // }).toList();

      return [];
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

  //increament product quantity in firebase
  @override
  Future<void> incrementProductQuantity(String cartId, int newQuantity) async {
    try {
      await Globals.firestore
          .collection('users')
          .doc(Globals.userId)
          .collection('cart')
          .doc(cartId)
          .update({
        'quantity': newQuantity,
      });
    } catch (e) {
      print("Error in incrementing product quantity: $e");
    }
  }

  // Decrement product quantity in Firebase
  @override
  Future<void> decrementProductQuantity(String cartId, int newQuantity) async {
    try {
      await Globals.firestore
          .collection('users')
          .doc(Globals.userId)
          .collection('cart')
          .doc(cartId)
          .update({
        'quantity': newQuantity,
      });
    } catch (e) {
      print("Error in decrementing product quantity: $e");
    }
  }
}
