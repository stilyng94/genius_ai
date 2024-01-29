import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class CustomToast {
  static void showToast(
    BuildContext context, {
    Widget? child,
    Color? backgroundColor,
    ToastGravity toastGravity = ToastGravity.CENTER,
    Duration toastDuration = const Duration(seconds: 2),
    Duration fadeDuration = const Duration(milliseconds: 350),
  }) {
    FToast().init(context);

    final toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0).w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0).w,
        color: backgroundColor,
      ),
      child: child,
    );

    FToast().removeCustomToast();
    FToast().showToast(
      child: toast,
      gravity: toastGravity,
      toastDuration: toastDuration,
      fadeDuration: fadeDuration,
    );
  }
}
