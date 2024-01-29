import 'package:genius_ai/core/presentation/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class Toasts {
  static void showNetworkInfoToast(
      {required BuildContext context, required InternetStatus internetStatus}) {
    return CustomToast.showToast(
      context,
      backgroundColor: Colors.red,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          if (internetStatus == InternetStatus.disconnected)
            Icon(
              Icons.wifi_off,
              size: 24.sp,
              color: Colors.redAccent,
            )
          else
            Icon(
              Icons.wifi,
              size: 24.sp,
              color: Colors.greenAccent,
            ),
          SizedBox(
            width: 12.w,
          ),
          Text(
            internetStatus == InternetStatus.disconnected
                ? "Offline"
                : "Online",
            style: Theme.of(context)
                .primaryTextTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
