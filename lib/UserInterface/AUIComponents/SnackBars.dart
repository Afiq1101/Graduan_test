
import 'package:flutter/material.dart';

class SnackBarFunctions {

void showCustomSnackBar(
    BuildContext context,
    String message, {
      Duration duration = const Duration(seconds: 2),
      Color backgroundColor = Colors.grey,
      Color textColor = Colors.white,
      SnackBarAction? action,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      duration: duration,
      backgroundColor: backgroundColor,
      action: action,
    ),
  );
}


}