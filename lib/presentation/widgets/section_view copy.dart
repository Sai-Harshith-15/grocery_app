import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../widgets/mytext.dart';

class SectionView extends StatefulWidget {
  final String title;
  final bool isShowSeeAllButton;
  final VoidCallback? onTap;
  final EdgeInsets? padding;

  const SectionView(
      {super.key,
      required this.title,
      this.isShowSeeAllButton = true,
      this.padding,
      required this.onTap});

  @override
  State<SectionView> createState() => _SectionViewState();
}

class _SectionViewState extends State<SectionView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 24,
        padding: widget.padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadText(
              text: widget.title,
              textColor: AppColors.primaryBlack,
              textSize: 16.8,
              textWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
            if (widget.isShowSeeAllButton)
              GestureDetector(
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!();
                  }
                },
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
