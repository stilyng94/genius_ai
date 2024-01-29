import 'dart:async';

import 'package:genius_ai/core/data/repository/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    return getThemeMode();
  }

  Future<void> toggleTheme() async {
    final selectedTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await ref.read(themeRepositoryProvider).saveTheme(selectedTheme);
    state = selectedTheme;
  }

  ThemeMode getThemeMode() {
    return ref.read(themeRepositoryProvider).getThemeMode();
  }
}
