import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/core/presentation/assets_path.dart';

class EmptyWidget extends StatelessWidget {
  final Option<String> message;

  const EmptyWidget({
    super.key,
    this.message = const None(),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12).w,
        child: Column(
          children: [
            Image.asset(
              AssetsPath.empty,
              fit: BoxFit.contain,
              height: 150.h,
              width: 150.w,
            ),
            SizedBox(
              height: 6.h,
            ),
            message.fold(() => const SizedBox(), (t) => Text(t))
          ],
        ),
      ),
    );
  }
}
