// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'4505b84efa870792ffe13be86a396a03a9ab2fca';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = Provider<UserModel>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserRef = ProviderRef<UserModel>;
String _$autoLoginHash() => r'074ab4c9dbd3e06ad8a6ddbb60a8b187f1caf93c';

/// See also [autoLogin].
@ProviderFor(autoLogin)
final autoLoginProvider = AutoDisposeFutureProvider<Option<UserModel>>.internal(
  autoLogin,
  name: r'autoLoginProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$autoLoginHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AutoLoginRef = AutoDisposeFutureProviderRef<Option<UserModel>>;
String _$authNotifierHash() => r'c67ac74c88998e509fc0a600afa4f4803be31df5';

/// See also [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    NotifierProvider<AuthNotifier, Option<UserModel>>.internal(
  AuthNotifier.new,
  name: r'authNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthNotifier = Notifier<Option<UserModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
