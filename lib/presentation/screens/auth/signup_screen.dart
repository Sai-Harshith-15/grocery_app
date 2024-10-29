import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/login_controller.dart';
import '../../../controllers/signup_controller.dart';
import '../../../constants/app_colors.dart';
import '../../../data/interfaces/auth_interface.dart';
import '../../../data/repositories/firebase_auth_repo.dart';
import '../../../data/services/auth_services.dart';
import '../../../routes/routes.dart';
import '../../widgets/inkwell_button.dart';
import '../../widgets/mytext.dart';
import '../../widgets/paraText.dart';
import '../../widgets/textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SignupController controller = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100), // To push the content down
                    // Title "Register"
                    const HeadText(
                      text: 'Register',
                      textSize: 26,
                      textWeight: FontWeight.w600,
                    ),
                    // Subtitle
                    const ParaText(
                      text: 'Enter your details to continue',
                      textSize: 16,
                      textWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 32),
                    // Name TextFormField
                    HeadText(
                      text: 'Name',
                      textSize: 16,
                      textWeight: FontWeight.w600,
                      textColor: AppColors.secondaryBlack,
                    ),
                    CustomTextField(
                      onChanged: controller.validateName,
                      errorText: controller.isNameValid.value
                          ? null
                          : "Please enter your name",
                      controller: controller.nameController,
                      labelText: const HeadText(text: "Name"),
                      validator: (value) {
                        return controller.isNameValid.value
                            ? null
                            : "Please enter a valid name";
                      },
                    ),
                    const SizedBox(height: 40),
                    // Email TextFormField
                    HeadText(
                      text: 'Email',
                      textSize: 16,
                      textWeight: FontWeight.w600,
                      textColor: AppColors.secondaryBlack,
                    ),
                    CustomTextField(
                      onChanged: controller.validateEmail,
                      errorText: controller.isEmailValid.value
                          ? null
                          : "Please enter your Email",
                      controller: controller.emailController,
                      labelText: const HeadText(text: "Email"),
                      validator: (value) {
                        return controller.isEmailValid.value
                            ? null
                            : "Please enter a valid email";
                      },
                    ),

                    const SizedBox(height: 40),
                    // Password TextFormField

                    HeadText(
                      text: 'Password',
                      textSize: 16,
                      textWeight: FontWeight.w600,
                      textColor: AppColors.secondaryBlack,
                    ),
                    CustomTextField(
                      isObsecre: controller.obscureText.value,
                      controller: controller.passwordController,
                      labelText: const HeadText(text: "Password"),
                      onChanged: controller.validatePassword,
                      validator: (value) {
                        return controller.isPasswordValid.value
                            ? null
                            : "Please enter a valid password";
                      },
                      errorText: controller.isPasswordValid.value
                          ? null
                          : "Please proper password",
                      suffixIcon: IconButton(
                        onPressed: controller.togglePasswordVisibility,
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      // Update the obscureText property based on observable
                    ),
                    SizedBox(height: 20),
                    // Forgot Password?
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: ParaText(
                          text:
                              'By continnuying you agree to our Terms of Service \nand PrivecyPolicy',
                          textSize: 14,
                          textWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 80),
                    // Log In Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWellButton(
                            text: 'Sign Up',
                            onPressed: () {
                              controller.submitForm();
                            }),
                      ],
                    ),
                    SizedBox(height: 24),
                    // Sign Up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ParaText(
                          text: 'Alredy have an account?',
                          textSize: 14,
                          textWeight: FontWeight.w600,
                          textColor: AppColors.primaryBlack,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.lazyPut<AuthInterface>(
                                () => FirebaseAuthServices());
                            Get.lazyPut<FirebaseAuthRepo>(() =>
                                FirebaseAuthRepo(
                                    interfaces: Get.find<AuthInterface>()));
                            Get.lazyPut<LoginController>(() => LoginController(
                                firebaseAuthRepo:
                                    Get.find<FirebaseAuthRepo>()));
                            Get.toNamed(Routes.login);
                          },
                          child: ParaText(
                            text: 'Login',
                            textSize: 14,
                            textWeight: FontWeight.w600,
                            textColor: AppColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
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
