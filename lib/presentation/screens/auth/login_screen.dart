import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/login_controller.dart';
import '../../../controllers/signup_controller.dart';
import '../../../data/interfaces/auth_interface.dart';
import '../../../data/repositories/firebase_auth_repo.dart';
import '../../../data/services/auth_services.dart';
import '../../../routes/routes.dart';
import '../../widgets/inkwell_button.dart';
import '../../widgets/mytext.dart';
import '../../widgets/paraText.dart';
import '../../widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.find<LoginController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100), // To push the content down
                        // Title "Login"
                        const HeadText(
                          text: 'Login',
                          textSize: 26,
                          textWeight: FontWeight.w600,
                        ),
                        // Subtitle
                        const ParaText(
                          text: 'Enter your email and password',
                          textSize: 16,
                          textWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 32),
                        // Email TextFormField
                        HeadText(
                          text: 'Email',
                          textSize: 16,
                          textWeight: FontWeight.w600,
                          textColor: AppColors.secondaryBlack,
                        ),
                        CustomTextField(
                          controller: controller.emailController,
                          onChanged: controller.validateEmail,
                          errorText: controller.isEmailValid.value
                              ? null
                              : "Please enter a valid email",
                        ),
                        const SizedBox(height: 50),
                        // Password TextFormField
                        HeadText(
                          text: 'Password',
                          textSize: 16,
                          textWeight: FontWeight.w600,
                          textColor: AppColors.secondaryBlack,
                        ),
                        CustomTextField(
                            errorText: controller.isPasswordValid.value
                                ? null
                                : "Please enter a valid password",
                            controller: controller.passwordController,
                            onChanged: controller.validatePassword,
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.visibility_off))),
                        const SizedBox(height: 12),
                        // Forgot Password?
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.forgotPassword);
                              },
                              child: ParaText(
                                text: 'Forgot Password?',
                                textSize: 14,
                                textWeight: FontWeight.w400,
                                textColor: AppColors.primaryBlack,
                              )),
                        ),
                        const SizedBox(height: 24),
                        // Log In Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWellButton(
                                text: 'Login',
                                onPressed: () async {
                                  if (formKey.currentState!.validate() &&
                                      controller
                                          .emailController.text.isNotEmpty &&
                                      controller
                                          .passwordController.text.isNotEmpty) {
                                    await controller.login();
                                  } else {
                                    Get.snackbar(
                                      'Invalid Input',
                                      'Please provide valid details in all fields.',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                }),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Sign Up link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ParaText(
                              text: "Don't have an account?",
                              textSize: 16,
                              textWeight: FontWeight.w600,
                              textColor: AppColors.primaryBlack,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.signup);
                                },
                                child: ParaText(
                                    text: 'Register',
                                    textSize: 16,
                                    textWeight: FontWeight.w600,
                                    textColor: AppColors.primaryBlack)),
                          ],
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
