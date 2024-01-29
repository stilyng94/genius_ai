import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_ai/core/presentation/assets_path.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12).w,
        child: Column(
          children: [
            Image.asset(
              AssetsPath.logo,
              fit: BoxFit.contain,
              height: 10.h,
              width: 10.w,
            ),
            SizedBox(
              height: 6.h,
            ),
            const Text("Genius is thinking...")
          ],
        ),
      ),
    );
  }
}
