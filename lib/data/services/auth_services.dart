import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../globals/globals.dart';
import '../interfaces/auth_interface.dart';
import '../models/user_model.dart';

class FirebaseAuthServices implements AuthInterface {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Signup method implementation

  @override
  Future<List<UserModel>> fetchUsersFromFirebase() async {
    List<UserModel> userList = [];
    try {
      QuerySnapshot snapshot =
          await firebaseFirestore.collection('users').get();
      for (var doc in snapshot.docs) {
        userList.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print("Error in fetching users: $e");
    }
    return userList;
  }

  @override
  Future<List<UserModel>> signup(
    String fullName,
    String email,
    String password,
  ) async {
    List<UserModel> userList = [];
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential != null) {
        // Add the user data to Firestore
        UserModel userModel = UserModel(
          userId: userCredential.user!.uid,
          fullName: fullName,
          email: email,
          phoneNumber: '',
          role: UserRole.Customer, // Assign default role
          userDeviceToken: '',
          userImg: '',
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
          password: password,
        );
        await firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toMap());
      }

      userList = await fetchUsersFromFirebase();
    } on FirebaseAuthException catch (e) {
      // print("Error during signup: $e");
      if (e.code == 'email-already-in-use') {
        throw Exception(
            "This email is already registered. Please use another email.");
      } else {
        print("Error during signup: $e");
        throw Exception("An error occurred during signup.");
      }
    }
    return userList;
  }

  // Login method implementation
  @override
  Future<void> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("No user found for this email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Incorrect password. Please try again.");
      } else {
        print("Unhandled FirebaseAuthException: ${e.code}");
        throw Exception("Login failed. Please check your credentials.");
      }
    } catch (e) {
      print("Error during login: $e");
      throw Exception("An unknown error occurred during login.");
    }
  }

  //google login

  @override
  Future<bool> loginWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        // Web-specific flow
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await firebaseAuth.signInWithPopup(googleProvider);
      } else {
        // Mobile-specific flow
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();

        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          userCredential = await firebaseAuth.signInWithCredential(credential);
        } else {
          return false;
        }
      }

      final User? user = userCredential.user;
      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        final docSnapshot = await userDoc.get();

        if (!docSnapshot.exists) {
          // Only create user document if it doesn't already exist
          UserModel userModel = UserModel(
            userId: user.uid,
            fullName: user.displayName ?? '',
            email: user.email ?? '',
            phoneNumber: user.phoneNumber ?? '',
            password: '',
            role: UserRole.Customer,
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
            userDeviceToken: '',
            userImg: user.photoURL ?? '',
          );
          await userDoc.set(userModel.toMap());
        }
      }

      return true; // Return true if login is successful
    } catch (e) {
      print("Error during Google sign-in: $e");
      throw Exception("Google sign-in failed");
    }
  }

  // Logout method implementation
  @override
  Future<void> logout() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      //logout form google
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      //logout from email
      await firebaseAuth.signOut();
      print("Successfully logged out");
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error in sending password reset email: $e");
    }
  }

  @override
  Future<UserModel> getUserDetails(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await Globals.firestore.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromMap(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        print("No User found $uid");
        throw Exception("User not found");
      }
    } catch (e) {
      print("Error fetching user details: $e");
      throw Exception("Error fetching user details");
    }
  }
}
