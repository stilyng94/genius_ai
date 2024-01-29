import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  static const String pathName = '/settings';
  static const String routeName = 'settingsScreen';
  static const int shellIndex = 0;

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text("settings screen"),
      ),
    );
  }
}
