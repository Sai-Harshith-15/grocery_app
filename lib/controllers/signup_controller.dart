import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repositories/firebase_auth_repo.dart';
import '../routes/routes.dart';

class SignupController extends GetxController {
  final FirebaseAuthRepo firebaseAuthRepo;
  var isLoading = false.obs;
  var toggleIcon = false.obs;

  SignupController({required this.firebaseAuthRepo});

  final formKey = GlobalKey<FormState>();

  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Observable variables
  var isNameValid = true.obs;
  var isEmailValid = true.obs;

  var isPasswordValid = true.obs;

  var obscureText = true.obs;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  // Validation methods
  void validateName(String value) => isNameValid.value =
      value.isNotEmpty && RegExp(r'^[a-zA-Z ]+$').hasMatch(value);
  void validateEmail(String value) => isEmailValid.value = value.isNotEmpty &&
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(value);

  void validatePassword(String value) => isPasswordValid.value = value
          .isNotEmpty &&
      RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%?&]{8,}$")
          .hasMatch(value);

  void submitForm() {
    if (formKey.currentState!.validate() &&
        emailController.text != "" &&
        passwordController.text != "" &&
        nameController.text != "") {
      try {
        isLoading.value = true;
        firebaseAuthRepo.signup(
            emailController.text, passwordController.text, nameController.text);
        Get.toNamed(Routes.tab);
      } catch (e) {
        Get.snackbar('Error', 'Failed to sign up');
        print("Error in the signup controller $e");
      } finally {
        isLoading.value = false;
      }

      nameController.clear();
      emailController.clear();
      passwordController.clear();
    } else {
      print("Please give Proper creadiatial ");
    }
  }
}
