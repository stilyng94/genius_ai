import 'package:flutter/material.dart';

abstract class CustomSnackbar {
  static void showLoadingSnackbar({
    required BuildContext context,
    String message = 'Loading....',
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(message),
        ),
      );
  }

  static void showErrorSnackbar({
    required BuildContext context,
    String error = 'error',
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
  }
}
