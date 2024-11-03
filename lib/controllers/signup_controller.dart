import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import '../data/models/user_model.dart';
import '../data/repositories/firebase_auth_repo.dart';

class SignupController extends GetxController {
  final FirebaseAuthRepo firebaseAuthRepo;

  SignupController({required this.firebaseAuthRepo});
  var isLoading = false.obs;
  var toggleIcon = false.obs;


  final usersList = <UserModel>[].obs;

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

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Method to check if user exists
  Future<bool> isUserExist(String email) async {
    List<UserModel> users = await firebaseAuthRepo.fetchUsersFromFirebase();
    return users.any((user) => user.email == email);
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

  Future<void> submitForm() async {
    try {
      isLoading.value = true;
      //check the user is already exixts or not
      bool userExists = await isUserExist(emailController.text.trim());
      if (userExists) {
        Get.snackbar(
          "User Exists",
          "The user with ${emailController.text} already exists",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      usersList.value = await firebaseAuthRepo.signup(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      Get.snackbar(
        'Success',
        '${nameController.text.trim()} singup successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      Get.toNamed(Routes.tab);
    } on Exception catch (e) {
      if (e.toString().contains("already registered")) {
        Get.snackbar(
          "Account Exists",
          "The email is already registered. Please use another email.",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar('Error', 'Failed to sign up: $e');
      }
      print("Error in the signup controller: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
