import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'mytext.dart';

class SectionView extends StatelessWidget {
  final String title;
  final bool isShowSeeAllButton;
  void Function()? onTap;
  final EdgeInsets? padding;

  SectionView({
    super.key,
    required this.title,
    this.isShowSeeAllButton = true,
    this.padding,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 24,
        // width: 360,
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadText(
              text: title,
              textColor: AppColors.primaryBlack,
              textSize: 16.8,
              textWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
            // SizedBox(
            //   width: 128,
            // ),
            GestureDetector(
              onTap: onTap,
              child: HeadText(
                text: "See all",
                textColor: AppColors.secondaryGreen,
                textSize: 16.8,
                textWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
