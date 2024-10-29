import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/mytext.dart';
import '../../widgets/paraText.dart';

void showCheckoutBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: HeadText(
                        text: 'Checkout',
                        textSize: 24,
                        textColor: AppColors.primaryBlack,
                        textWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First ExpansionTile - Delivery
                    ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      childrenPadding: EdgeInsets.zero,
                      collapsedBackgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(0),
                            bottom: Radius.circular(0)),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadText(
                            text: 'Delivery',
                            textSize: 18,
                            textColor: AppColors.secondaryBlack,
                            textWeight: FontWeight.w600,
                          ),
                          HeadText(
                            text: 'Select Method',
                            textSize: 16,
                            textColor: AppColors.primaryBlack,
                            textWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ParaText(
                              text: "Collection",
                              textSize: 14,
                              textWeight: FontWeight.w400,
                              textColor: AppColors.secondaryBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Second ExpansionTile - Payment
                    ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      childrenPadding: EdgeInsets.zero,
                      collapsedBackgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(0),
                            bottom: Radius.circular(0)),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadText(
                            text: 'Payment',
                            textSize: 18,
                            textColor: AppColors.secondaryBlack,
                            textWeight: FontWeight.w600,
                          ),
                          Image.asset(
                            'assets/images/master.png',
                            height: 24,
                          ),
                        ],
                      ),
                      children: <Widget>[
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          title: ParaText(
                            text: "COD",
                            textSize: 14,
                            textWeight: FontWeight.w400,
                            textColor: AppColors.secondaryBlack,
                          ),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          title: ParaText(
                            text: "Online",
                            textSize: 14,
                            textWeight: FontWeight.w400,
                            textColor: AppColors.secondaryBlack,
                          ),
                        ),
                      ],
                    ),
                    // Third ExpansionTile - Total Cost
                    ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      childrenPadding: EdgeInsets.zero,
                      collapsedBackgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(0),
                            bottom: Radius.circular(0)),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadText(
                            text: 'Total Cost',
                            textSize: 18,
                            textColor: AppColors.secondaryBlack,
                            textWeight: FontWeight.w600,
                          ),
                          HeadText(
                            text: '\$13.97',
                            textSize: 16,
                            textColor: AppColors.primaryBlack,
                            textWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ParaText(
                              text: "Discount",
                              textSize: 14,
                              textColor: AppColors.secondaryBlack,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: MaterialButton(
                    onPressed: () {},
                    height: 80,
                    color: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HeadText(
                          text: 'Place Order',
                          textSize: 18.0,
                          textColor: AppColors.background,
                          textWeight: FontWeight.w600,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: HeadText(
                            text: '\$12.99',
                            textSize: 12,
                            textColor: AppColors.background,
                            textWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
