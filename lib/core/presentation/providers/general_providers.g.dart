// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferenceHash() => r'df840dac43970e82805a86acab388b57e0501122';

/// See also [sharedPreference].
@ProviderFor(sharedPreference)
final sharedPreferenceProvider = Provider<SharedPreferences>.internal(
  sharedPreference,
  name: r'sharedPreferenceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferenceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferenceRef = ProviderRef<SharedPreferences>;
String _$dioInstanceHash() => r'0c44ef67f5ccc85a70968ed17b39b5c1c85d2162';

/// See also [dioInstance].
@ProviderFor(dioInstance)
final dioInstanceProvider = Provider<Dio>.internal(
  dioInstance,
  name: r'dioInstanceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioInstanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioInstanceRef = ProviderRef<Dio>;
String _$internetConnectionHash() =>
    r'95b2f06085b1e77244f4b07003e4db5681fb8fd8';

/// See also [internetConnection].
@ProviderFor(internetConnection)
final internetConnectionProvider = Provider<InternetConnection>.internal(
  internetConnection,
  name: r'internetConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$internetConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InternetConnectionRef = ProviderRef<InternetConnection>;
String _$networkInfoHash() => r'fa8a8a56f74f1b1c62f15ba1a3d5f4ff7518504c';

/// See also [networkInfo].
@ProviderFor(networkInfo)
final networkInfoProvider = StreamProvider<InternetStatus>.internal(
  networkInfo,
  name: r'networkInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$networkInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NetworkInfoRef = StreamProviderRef<InternetStatus>;
String _$openAIHash() => r'd71e6eb61d1642f6ee330a75905dd2f05365da53';

/// See also [openAI].
@ProviderFor(openAI)
final openAIProvider = Provider<OpenAI>.internal(
  openAI,
  name: r'openAIProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$openAIHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OpenAIRef = ProviderRef<OpenAI>;
String _$replicateAIHash() => r'ce4e82983ec31402ba1545c91e10f7455fef68c4';

/// See also [replicateAI].
@ProviderFor(replicateAI)
final replicateAIProvider = Provider<Replicate>.internal(
  replicateAI,
  name: r'replicateAIProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$replicateAIHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReplicateAIRef = ProviderRef<Replicate>;
String _$downloaderHash() => r'532e247cd77077b3000097c380dc669f9ea6bdfe';

/// See also [Downloader].
@ProviderFor(Downloader)
final downloaderProvider =
    AutoDisposeNotifierProvider<Downloader, Unit>.internal(
  Downloader.new,
  name: r'downloaderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$downloaderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Downloader = AutoDisposeNotifier<Unit>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
