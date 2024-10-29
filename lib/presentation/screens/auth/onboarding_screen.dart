import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/inkwell_button.dart';
import '../../widgets/mytext.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/OnBoard 1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Logo and text
                Column(
                  children: [
                    Image.asset('assets/images/VectorLef.png'),
                    HeadText(
                      text: 'A taste of home\nawaits',
                      textSize: 41,
                      textWeight: FontWeight.w600,
                      textColor: AppColors.background,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                // Get Started button
                InkWellButton(
                    text: "Get Satarted",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()));
                    }),

                const SizedBox(height: 40), // Add space below the button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
