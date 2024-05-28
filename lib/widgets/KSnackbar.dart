import 'package:flutter/material.dart';

SnackBar KSnackBar(
    {required String message,
    required String type,
    required BuildContext context}) {
  return SnackBar(
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: (type == 'success')
          ? Colors.green
          : (type == 'error')
              ? Colors.red
              : Colors.orange,
      content: Text(message));
}
