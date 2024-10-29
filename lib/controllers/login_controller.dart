import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../data/repositories/firebase_auth_repo.dart';
import '../routes/routes.dart';

class LoginController extends GetxController {
  final FirebaseAuthRepo firebaseAuthRepo;
  LoginController({required this.firebaseAuthRepo});

  final isLoading = false.obs;

  // Text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

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
  void login() {
    if (formKey.currentState!.validate() &&
        emailController.text != "" &&
        passwordController.text != "") {
      try {
        isLoading.value = true;
        firebaseAuthRepo
            .login(emailController.text, passwordController.text)
            .then((_) => Get.toNamed(Routes.tab));
      } catch (e) {
        Get.snackbar('Error', 'Failed to sign up',
            backgroundColor: AppColors.primaryGreen);
        print("Error in the signup controller $e");
      } finally {
        isLoading.value = false;
      }

      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar(
        "Error",
        "Please give proper creaditials",
        backgroundColor: AppColors.primaryGreen,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
