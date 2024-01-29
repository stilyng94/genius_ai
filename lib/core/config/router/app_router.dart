import 'package:genius_ai/core/config/router/router_observer.dart';
import 'package:genius_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:genius_ai/features/auth/presentation/screens/login_screen.dart';
import 'package:genius_ai/features/code_generation/presentation/screens/code_gen_screen.dart';
import 'package:genius_ai/features/conversation/presentation/screens/conversation_screen.dart';
import 'package:genius_ai/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:genius_ai/features/home/presentation/widgets/home_shell.dart';
import 'package:genius_ai/features/image_generation/presentation/screens/image_generation_screen.dart';
import 'package:genius_ai/features/music_generation/presentation/screens/music_generation_screen.dart';
import 'package:genius_ai/features/splash/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genius_ai/features/video_generation/presentation/screens/video_generation_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'app_router.g.dart';

final _rootNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: "rootNavigation");
final _shellNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: "shellNavigation");

List<RouteBase> _routes = [
  GoRoute(
    path: SplashScreen.pathName,
    name: SplashScreen.routeName,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: LoginScreen.pathName,
    name: LoginScreen.routeName,
    builder: (context, state) => const LoginScreen(),
  ),
  StatefulShellRoute.indexedStack(
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: DashboardScreen.pathName,
            name: DashboardScreen.routeName,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DashboardScreen()),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ConversationScreen.pathName,
            name: ConversationScreen.routeName,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ConversationScreen()),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ImageGenerationScreen.pathName,
            name: ImageGenerationScreen.routeName,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ImageGenerationScreen()),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: VideoGenerationScreen.pathName,
            name: VideoGenerationScreen.routeName,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: VideoGenerationScreen()),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: MusicGenerationScreen.pathName,
            name: MusicGenerationScreen.routeName,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MusicGenerationScreen()),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: CodeGenScreen.pathName,
            name: CodeGenScreen.routeName,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CodeGenScreen()),
          ),
        ],
      ),
    ],
    builder: (context, state, navigationShell) => ScaffoldWithNestedNavigation(
      navigationShell: navigationShell,
    ),
  )
];

const List<String> _publicScreens = [
  LoginScreen.pathName,
  SplashScreen.pathName,
];

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final routerListenable = ValueNotifier<bool?>(null);

  ref.listen(
    authNotifierProvider.select((user) {
      return user.isSome();
    }),
    (_, current) {
      routerListenable.value = current;
    },
  );

  final router = GoRouter(
    navigatorKey: _rootNavigationKey,
    observers: [RouterObserver()],
    debugLogDiagnostics: kDebugMode,
    refreshListenable: routerListenable,
    initialLocation: ConversationScreen.pathName,
    routes: _routes,
    errorBuilder: (context, state) =>
        Center(child: Text('Page ${state.error} not found')),
    redirect: (context, state) {
      // final currentAuth = ref.read(authNotifierProvider);

      // if (_publicScreens.notElem(state.matchedLocation)) {
      //   return currentAuth.fold(() => LoginScreen.pathName, (t) => null);
      // }
      // if (currentAuth.isSome() && _publicScreens.elem(state.matchedLocation)) {
      //   return DashboardScreen.pathName;
      // }
      return null;
    },
  );

  ref.onDispose(() {
    routerListenable.dispose();
    router.dispose();
  });
  return router;
}
