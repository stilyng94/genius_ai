import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoGenerationScreen extends ConsumerWidget {
  static const String pathName = '/video-gen';
  static const String routeName = 'videoGen';
  const VideoGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text("video screen"),
      ),
    );
  }
}
