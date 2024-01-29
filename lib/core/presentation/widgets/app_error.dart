import 'package:genius_ai/core/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorWidget extends ConsumerWidget {
  const AppErrorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: 'Error Screen',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
