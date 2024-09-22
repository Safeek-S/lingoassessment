import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.black87,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );

  // Find the nearest ScaffoldMessenger and show the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
