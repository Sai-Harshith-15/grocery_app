import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/responsive.dart';
import '../widgets/mytext.dart';
import '../widgets/paraText.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobile(context)
                ? 24
                : Responsive.isMobileLarge(context)
                    ? 36
                    : 60,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // User Profile Section
                SizedBox(
                  height: Responsive.isDesktop(context)
                      ? 25
                      : Responsive.isDesktopLarge(context)
                          ? 30
                          : Responsive.isTablet(context)
                              ? 140
                              : Responsive.isMobileLarge(context)
                                  ? 120
                                  : 18,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/man.png",
                        fit: BoxFit.cover,
                        height: Responsive.isMobile(context)
                            ? 60
                            : Responsive.isMobileLarge(context)
                                ? 80
                                : Responsive.isTablet(context)
                                    ? 100
                                    : Responsive.isDesktop(context)
                                        ? 120
                                        : 140,
                        width: Responsive.isMobile(context)
                            ? 60
                            : Responsive.isMobileLarge(context)
                                ? 80
                                : Responsive.isTablet(context)
                                    ? 100
                                    : Responsive.isDesktop(context)
                                        ? 120
                                        : 140,
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadText(
                          text: 'John Doe',
                          textWeight: FontWeight.w700,
                          textSize: Responsive.isDesktop(context)
                              ? 35.0
                              : Responsive.isDesktopLarge(context)
                                  ? 40.0
                                  : Responsive.isTablet(context)
                                      ? 30.0
                                      : Responsive.isMobileLarge(context)
                                          ? 25.0
                                          : 20.16,
                          textHeight: 18.0,
                          letterSpacing: -0.5,
                        ),
                        ParaText(
                          text: 'lmshuvo97@gmail.com',
                          textWeight: FontWeight.w400,
                          textSize: 16.8,
                          textHeight: 18.0,
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit_outlined,
                            color: AppColors.primaryGreen)),
                    // SizedBox(
                    //   width: 28,
                    // )
                  ],
                ),
                SizedBox(
                  height: Responsive.isDesktop(context)
                      ? 25
                      : Responsive.isDesktopLarge(context)
                          ? 30
                          : Responsive.isTablet(context)
                              ? 60
                              : 15,
                ),

                // List of Options
                Column(
                  children: [
                    Column(
                      // child: ListView(
                      children: [
                        optionItem(
                            context, "assets/images/bag.svg", 'Orders', () {}),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? 25
                              : Responsive.isDesktopLarge(context)
                                  ? 30
                                  : Responsive.isTablet(context)
                                      ? 60
                                      : 15,
                        ),
                        optionItem(context, "assets/images/location.svg",
                            'Delivery Address', () {}),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? 25
                              : Responsive.isDesktopLarge(context)
                                  ? 30
                                  : Responsive.isTablet(context)
                                      ? 60
                                      : 15,
                        ),
                        optionItem(context, "assets/images/payment.svg",
                            'Payment Methods', () {}),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? 25
                              : Responsive.isDesktopLarge(context)
                                  ? 30
                                  : Responsive.isTablet(context)
                                      ? 60
                                      : 15,
                        ),
                        optionItem(context, "assets/images/profile.svg",
                            'Profile', () {}),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? 25
                              : Responsive.isDesktopLarge(context)
                                  ? 30
                                  : Responsive.isTablet(context)
                                      ? 60
                                      : 15,
                        ),
                        optionItem(
                            context, "assets/images/help.svg", 'Help', () {}),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? 25
                              : Responsive.isDesktopLarge(context)
                                  ? 30
                                  : Responsive.isTablet(context)
                                      ? 60
                                      : 15,
                        ),
                        optionItem(
                            context, "assets/images/about.svg", 'About', () {}),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 1.0,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 24, horizontal: 30),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                  backgroundColor: AppColors
                                      .primaryGreen, // Light background color
                                  // color: Colors.green, // Text color
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: AppColors.background,
                                    ),
                                    SizedBox(
                                        width: Responsive.isDesktop(context) ||
                                                Responsive.isDesktopLarge(
                                                    context)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.44
                                            : Responsive.isTablet(context)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2),
                                    Center(
                                      widthFactor: Responsive.isMobile(context)
                                          ? 1.0
                                          : Responsive.isMobileLarge(context)
                                              ? 2
                                              : Responsive.isTablet(context)
                                                  ? 0
                                                  : Responsive.isDesktop(
                                                          context)
                                                      ? 0
                                                      : 0,
                                      child: HeadText(
                                        text: 'Log Out',
                                        textColor: AppColors.background,
                                        textWeight: FontWeight.w700,
                                        textSize: Responsive.isDesktop(context)
                                            ? 35.0
                                            : Responsive.isDesktopLarge(context)
                                                ? 40.0
                                                : Responsive.isTablet(context)
                                                    ? 30.0
                                                    : Responsive.isMobileLarge(
                                                            context)
                                                        ? 25.0
                                                        : 20.16,
                                        textHeight: 18,
                                        textAlign: TextAlign.center,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ],
                                )))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget optionItem(BuildContext context, String image, String text,
      void Function()? onPressed) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: SvgPicture.asset(image, color: AppColors.primaryGreen),
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: HeadText(
            text: text,
            textWeight: FontWeight.w600,
            textSize: Responsive.isDesktop(context)
                ? 35.0
                : Responsive.isDesktopLarge(context)
                    ? 40.0
                    : Responsive.isTablet(context)
                        ? 30.0
                        : Responsive.isMobileLarge(context)
                            ? 25.0
                            : 20.16,
            textHeight: 22.5,
            letterSpacing: -0.6),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
