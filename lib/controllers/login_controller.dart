import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../data/repositories/firebase_auth_repo.dart';
import '../routes/routes.dart';


class LoginController extends GetxController {
  final FirebaseAuthRepo firebaseAuthRepo;
  LoginController({required this.firebaseAuthRepo});

  final isLoading = false.obs;

  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Forgot Email COntroller

  final forgotPasswordController = TextEditingController();

  // Observables for validation states
  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;

  // Method to validate email
  void validateEmail(String value) => isEmailValid.value = value.isNotEmpty &&
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(value);

  // Method to validate password
  void validatePassword(String value) => isPasswordValid.value = value
          .isNotEmpty &&
      RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%?&]{8,}$")
          .hasMatch(value);

  // Method to handle form submission
  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Invalid Input',
        'Email and password are required.',
      );
      return;
    }
    try {
      isLoading.value = true;
      await firebaseAuthRepo.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      emailController.clear();
      passwordController.clear();

      Get.toNamed(Routes.tab);
    } catch (e) {
      Get.snackbar(
        'Login Error',
        e.toString().replaceAll('Exception: ', ''),
      );
      print("Error in the login controller: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    if (forgotPasswordController.text.isEmpty) {
      Get.snackbar(
        'Invalid Input',
        'A valid email is required.',
      );
      return;
    }
    try {
      isLoading.value = true;
      String email = forgotPasswordController.text.trim();

      await firebaseAuthRepo.forgotPassword(email);

      Get.snackbar(
        'Reset Password Email Sent',
        'An email has been sent to $email to reset your password.',
      );
      forgotPasswordController.clear(); // Clear after feedback
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send reset email. ${e.toString().replaceAll('Exception: ', '')}',
      );
      print("Error in forgotPassword: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //google sign in

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      bool loginSuccess = await firebaseAuthRepo.loginWithGoogle();

      if (loginSuccess) {
        Get.snackbar('Success', "Login with Google Account Successfully");
        Get.toNamed(Routes.tab);
      } else {
        Get.snackbar('Cancelled', "Google sign-in was canceled.");
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to login with Google: $e');
      print("Error logging in with Google - $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    forgotPasswordController.clear();
    super.onClose();
  }
}
