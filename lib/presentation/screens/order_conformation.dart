import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../widgets/inkwell_button.dart';
import '../widgets/mytext.dart';
import '../widgets/paraText.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  _OrderConfirmationScreenState createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              // Checkmark icon with zoom animation
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.3, end: 1.0),
                duration:
                    const Duration(seconds: 1), // Duration for the zoom effect
                curve: Curves.easeInOut, // Smooth in-out curve
                builder: (context, double scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/orderconform.png',
                        height: 20,
                        width: 16,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              // Title text
              HeadText(
                text: 'Your Order has been\n          accepted!',
                textColor: AppColors.primaryBlack,
                textSize: 28,
                textWeight: FontWeight.w700,
              ),
              const SizedBox(height: 20), // Spacing
              // Subtext
              ParaText(
                text:
                    'Your order has been placed and is on\n          it\'s way to being processed.',
                textColor: AppColors.secondaryBlack,
                textSize: 16,
                textWeight: FontWeight.w400,
              ),
              const SizedBox(height: 150),
              // Track Order Button

              InkWellButton(text: 'Track Order', onPressed: () {}),

              // MaterialButton(
              //   onPressed: () {
              //     // Add functionality here
              //   },
              //   color: AppColors.primaryGreen,
              //   height: 80,
              //   minWidth: 364, // Make the button take full width
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: HeadText(
              //     text: 'Track Order',
              //     textColor: AppColors.background,
              //     textSize: 20,
              //     textWeight: FontWeight.w500,
              //   ),
              // ),
              const SizedBox(height: 25), // Spacing
              // Back to home button
              TextButton(
                onPressed: () {
                  // Add functionality here
                },
                child: HeadText(
                  text: 'Back to home',
                  textColor: AppColors.primaryBlack,
                  textSize: 20,
                  textWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
