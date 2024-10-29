import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive.dart';
import '../../../controllers/login_controller.dart';
import '../../../data/interfaces/auth_interface.dart';
import '../../../data/repositories/firebase_auth_repo.dart';
import '../../../data/services/auth_services.dart';
import '../../../routes/routes.dart';
import '../../widgets/inkwell_button.dart';
import '../../widgets/mytext.dart';
import '../../widgets/paraText.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context) ||
                        Responsive.isDesktopLarge(context)
                    ? 200
                    : 20),
            child: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Placeholder for the image (adjust size as needed)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        HeadText(
                          text: 'Welcome!',
                          textSize: 28,
                          textWeight: FontWeight.w600,
                          textColor: AppColors.primaryBlack,
                          letterSpacing: -0.6,
                        ),
                        ParaText(
                          text: "Let's get you started.",
                          textSize: 16,
                          textColor: AppColors.secondaryBlack,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 80,
                        ),
                        SvgPicture.asset(
                          'assets/images/welcome.svg',
                          width: 270,
                          height: 287,
                        ),
                      ],
                    ), // Replace with your image path
                  ),

                  const SizedBox(height: 40),
                  // Log in with Google button
                  SizedBox(
                    width: Responsive.isDesktopLarge(context) ||
                            Responsive.isDesktop(context)
                        ? 400
                        : 800,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your Google sign-in logic here
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/google.svg',
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          HeadText(
                            text: 'Log In with Google',
                            textColor: AppColors.background,
                            textSize: 20,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.primaryGreen, // Background color
                        padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: Responsive.isDesktop(context) ||
                                    Responsive.isDesktopLarge(context)
                                ? 80
                                : 20),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              36.0), // Add your desired radius here
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Log in with Email button
                  SizedBox(
                    width: Responsive.isDesktopLarge(context) ||
                            Responsive.isDesktop(context)
                        ? 400
                        : 800,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.lazyPut<AuthInterface>(
                            () => FirebaseAuthServices());
                        Get.lazyPut<FirebaseAuthRepo>(() => FirebaseAuthRepo(
                            interfaces: Get.find<AuthInterface>()));
                        Get.lazyPut<LoginController>(() => LoginController(
                            firebaseAuthRepo: Get.find<FirebaseAuthRepo>()));
                        Get.toNamed(Routes.login);
                        // Add your email login logic here
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          HeadText(
                            text: 'Log In with Email',
                            textColor: AppColors.background,
                            textSize: 20,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.primaryGreen, // Background color
                        padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: Responsive.isDesktop(context) ||
                                    Responsive.isDesktopLarge(context)
                                ? 80
                                : 20),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              36.0), // Add your desired radius here
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Register link
                  GestureDetector(
                    onTap: () {
                      // Add register navigation logic here
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ParaText(
                          text: "Don't have an account? ",
                          textSize: 16,
                          textColor: AppColors.primaryBlack,
                          letterSpacing: -0.6,
                          // decoration: TextDecoration.underline,
                        ),
                        GestureDetector(
                          onTap: () {
                            // write register page navigqation
                          },
                          child: ParaText(
                            text: "Register",
                            textSize: 16,
                            textColor: AppColors.primaryGreen,
                            textWeight: FontWeight.w600,
                            letterSpacing: -0.6,
                            // decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
