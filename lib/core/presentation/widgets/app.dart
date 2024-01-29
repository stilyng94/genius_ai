import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genius_ai/core/config/router/app_router.dart';
import 'package:genius_ai/core/config/theme_config.dart';
import 'package:genius_ai/core/presentation/providers/theme_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(appThemeModeProvider);
    final appRouter = ref.watch(appRouterProvider);

    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
          title: 'Genius Ai',
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          builder: FToastBuilder(),
          themeMode: appThemeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter),
    );
  }
}
