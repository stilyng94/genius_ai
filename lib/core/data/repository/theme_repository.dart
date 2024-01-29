import 'dart:async';

import 'package:genius_ai/core/presentation/providers/general_providers.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_repository.g.dart';

abstract class IThemeRepository {
  ThemeMode getThemeMode();
  Future<void> saveTheme(ThemeMode theme);
}

class ThemeRepository implements IThemeRepository {
  ThemeRepository({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const _kThemePersistenceKey = '__theme_persistence_key__';

  @override
  ThemeMode getThemeMode() {
    final themeMode = _sharedPreferences.getString(_kThemePersistenceKey);
    if (themeMode == null) {
      return ThemeMode.system;
    } else if (themeMode == ThemeMode.dark.name) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  @override
  Future<void> saveTheme(ThemeMode themeMode) {
    return _sharedPreferences.setString(_kThemePersistenceKey, themeMode.name);
  }
}

@riverpod
IThemeRepository themeRepository(ThemeRepositoryRef ref) {
  return ThemeRepository(
      sharedPreferences: ref.watch(sharedPreferenceProvider));
}
