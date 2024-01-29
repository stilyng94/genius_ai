import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  static const String pathName = '/dashboard';
  static const String routeName = 'dashboardScreen';
  static const int shellIndex = 0;

  const DashboardScreen({super.key});

  static List<({Icon icon, String label, int routeIndex})> routes = [
    (
      label: "conversation",
      icon: Icon(Icons.chat, color: Colors.indigo.shade600),
      routeIndex: 1
    ),
    (
      label: "image generation",
      icon: Icon(Icons.image, color: Colors.pink.shade700),
      routeIndex: 2
    ),
    (
      label: "video generation",
      icon: Icon(Icons.videocam, color: Colors.orange.shade700),
      routeIndex: 3
    ),
    (
      label: "music generation",
      icon: Icon(Icons.music_note, color: Colors.amber.shade500),
      routeIndex: 4
    ),
    (
      label: "code generation",
      icon: Icon(Icons.code, color: Colors.green.shade700),
      routeIndex: 5
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Explore the power of AI",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
          Text(
            "Chat with the smartest AI - experience the power of ai",
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withOpacity(0.7)),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).w,
              child: Column(
                children: routes
                    .map((route) => Card(
                          key: ValueKey(route.routeIndex),
                          child: ListTile(
                            onTap: () => StatefulNavigationShell.of(context)
                                .goBranch(route.routeIndex),
                            leading: route.icon,
                            title: Text(route.label),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ))
                    .toList(),
              ))
        ],
      ),
    );
  }
}
