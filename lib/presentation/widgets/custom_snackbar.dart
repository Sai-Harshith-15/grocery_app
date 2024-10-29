import 'package:get/get.dart';
import 'package:flutter/material.dart';

void showSuccessSnackbar(String message, {String title = 'Success'}) {
  Get.snackbar(
    title,  // Title of the snackbar
    message,  // Message of the snackbar
    snackPosition: SnackPosition.BOTTOM,  // Position of snackbar
    backgroundColor: Colors.green,  // Background color
    colorText: Colors.white,  // Text color
    borderRadius: 6,  // Border radius
    margin: EdgeInsets.all(10),  // Margin around the snackbar
    icon: Icon(Icons.check_circle, color: Colors.white),  // Icon in the snackbar
    duration: Duration(seconds: 3),  // Duration for which the snackbar is shown
    isDismissible: true,  // Whether the snackbar can be dismissed by user
    forwardAnimationCurve: Curves.easeOutBack,  // Animation while showing
    reverseAnimationCurve: Curves.easeIn,  // Animation while hiding
  );
}

void showErrorSnackbar(String message, {String title = 'Error'}) {
  Get.snackbar(
    title,  // Title of the snackbar
    message,  // Message of the snackbar
    snackPosition: SnackPosition.TOP,  // Position of snackbar
    backgroundColor: Colors.red,  // Background color
    colorText: Colors.white,  // Text color
    borderRadius: 6,  // Border radius
    margin: EdgeInsets.all(10),  // Margin around the snackbar
    icon: Icon(Icons.error, color: Colors.white),  // Icon in the snackbar
    duration: Duration(seconds: 3),  // Duration for which the snackbar is shown
    isDismissible: true,  // Whether the snackbar can be dismissed by user
    forwardAnimationCurve: Curves.easeInOut,  // Animation while showing
    reverseAnimationCurve: Curves.easeInOut,  // Animation while hiding
  );
}