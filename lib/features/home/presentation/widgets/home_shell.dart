import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_ai/core/presentation/providers/general_providers.dart';
import 'package:genius_ai/core/presentation/widgets/toasts.dart';
import 'package:genius_ai/features/auth/presentation/providers/sign_out_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ScaffoldWithNestedNavigation extends ConsumerWidget {
  static const String pathName = '/';
  static const String routeName = 'homeShell';

  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNestedNavigation({
    key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(networkInfoProvider, (previous, next) {
      next.whenData((value) {
        Toasts.showNetworkInfoToast(context: context, internetStatus: value);
      });
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const CircleAvatar(child: Text("JA")),
            position: PopupMenuPosition.under,
            tooltip: "account",
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4)
                          .w,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.settings),
                          SizedBox(width: 12.w),
                          const Text("manage account")
                        ],
                      ))),
              PopupMenuItem(
                  value: 2,
                  onTap: ref.read(signOutNotifierProvider.notifier).signOut,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4)
                          .w,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.logout),
                          SizedBox(width: 12.w),
                          const Text("sign out")
                        ],
                      )))
            ],
          )
        ],
      ),
      drawer: HomeShellDrawer(navigationShell: navigationShell),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: navigationShell,
      )),
      floatingActionButton: FloatingActionButton(
          tooltip: "help desk",
          onPressed: () {},
          child: const Icon(Icons.live_help)),
    );
  }
}

class HomeShellDrawer extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const HomeShellDrawer({
    required this.navigationShell,
    super.key,
  });

  static List<({Icon icon, String label})> routes = [
    (
      label: "dashboard",
      icon: Icon(Icons.space_dashboard, color: Colors.blue.shade600),
    ),
    (
      label: "conversation",
      icon: Icon(Icons.chat_bubble, color: Colors.indigo.shade600),
    ),
    (
      label: "image generation",
      icon: Icon(Icons.image, color: Colors.pink.shade700),
    ),
    (
      label: "video generation",
      icon: Icon(Icons.videocam, color: Colors.orange.shade700),
    ),
    (
      label: "music generation",
      icon: Icon(Icons.music_note, color: Colors.amber.shade500),
    ),
    (
      label: "code generation",
      icon: Icon(Icons.code, color: Colors.green.shade700),
    ),
    (
      label: "settings",
      icon: const Icon(Icons.settings),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationDrawer(
      onDestinationSelected: (index) {
        navigationShell.goBranch(index,
            initialLocation: index == navigationShell.currentIndex);
        Scaffold.of(context).closeDrawer();
      },
      indicatorShape: RoundedRectangleBorder(
          borderRadius:
              BorderRadiusDirectional.all(const Radius.circular(4).w)),
      selectedIndex: navigationShell.currentIndex,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
          margin: const EdgeInsets.only(bottom: 16).w,
          child: Row(
            children: [
              const Icon(Icons.electric_bolt),
              Text(
                "Genius Ai",
                style: GoogleFonts.montserrat()
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20.sp),
              )
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        ...routes
            .map((e) => NavigationDrawerDestination(
                  key: Key(e.label),
                  icon: e.icon,
                  label: Text(e.label),
                ))
            .toList()
      ],
    );
  }
}
