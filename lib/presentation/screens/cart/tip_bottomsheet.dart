import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/mytext.dart';

void TipBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Title
            HeadText(
              text: 'Delivery Tip',
              textSize: 18,
              textWeight: FontWeight.bold,
              textColor: AppColors.primaryBlack,
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildTipOption(context, '₹10'),
                _buildTipOption(context, '₹20'),
                _buildTipOption(context, '₹30'),
              ],
            ),
            const SizedBox(height: 20),

            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Tip Amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                minimumSize: Size(150, 60),
              ),
              child: HeadText(
                text: 'Confirm',
                textColor: AppColors.background,
                textSize: 18,
              ),
            )
          ],
        ),
      );
    },
  );
}

Widget _buildTipOption(BuildContext context, String tipAmount) {
  return GestureDetector(
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: HeadText(
        text: 'You selected $tipAmount',
        textColor: AppColors.background,
        textSize: 12,
      )));
      Navigator.pop(context);
    },
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: AppColors.primaryGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: HeadText(
          text: tipAmount,
          textSize: 18,
          textWeight: FontWeight.bold,
          textColor: AppColors.background,
        )),
  );
}
