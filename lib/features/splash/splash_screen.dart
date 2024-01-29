import 'package:genius_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:genius_ai/features/auth/presentation/screens/login_screen.dart';
import 'package:genius_ai/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerWidget {
  static const String pathName = '/splashScreen';
  static const String routeName = 'splashScreen';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(autoLoginProvider, (previous, next) {
      next.whenOrNull(
        data: (data) => data.fold(() => context.goNamed(LoginScreen.routeName),
            (t) => context.goNamed(DashboardScreen.routeName)),
        error: (error, stackTrace) => context.goNamed(LoginScreen.routeName),
      );
    });

    return const Scaffold(
      body: Center(
        child: Text("Splash screen"),
      ),
    );
  }
}
