import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/login_controller.dart';
import '../../widgets/mytext.dart';
import '../../widgets/rounded_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final LoginController loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryGreen,
          title: HeadText(
            text: "Forgot Password Screen",
            textColor: AppColors.background,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 400),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    RoundedTextField(
                      controller: loginController.forgotPasswordController,
                      onChanged: loginController.validateEmail,
                      errorText: loginController.isEmailValid.value
                          ? null
                          : "Please enter a valid email",
                      hintText: "Enter Email",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    loginController.isLoading.value
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: MaterialButton(
                              color: AppColors.primaryGreen,
                              onPressed: () async {
                                if (loginController
                                    .forgotPasswordController.text.isNotEmpty) {
                                  await loginController.forgotPassword();
                                } else {
                                  Get.snackbar(
                                    'Invalid Input',
                                    'Please provide valid details in all fields.',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              child: HeadText(
                                text: "Send",
                                textColor: AppColors.background,
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
