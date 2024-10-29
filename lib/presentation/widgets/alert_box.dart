import 'package:flutter/material.dart';

import 'inkwell_button.dart';
import 'mytext.dart';

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close),
                  ),
                ),
                SizedBox(height: 48),
                // Asset Image in the center
                Image.asset(
                  'assets/images/worng.svg',
                  height: 100,
                ),
                SizedBox(height: 24),
                // Heading and Subtext
                HeadText(
                  text: "Oops! Order Failed",
                  textSize: 24,
                  textWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                HeadText(
                  text: "Something went terribly wrong.",
                  textSize: 18,
                  textWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 50),
                InkWellButton(text: "Try Again", onPressed: () {}),

                SizedBox(height: 16),
                // Back to Home Button
                TextButton(
                  onPressed: () {
                    // Handle Back to Home action here
                  },
                  child: HeadText(
                    text: "Back to home",
                    textSize: 18,
                    textWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
