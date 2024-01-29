// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_gen_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$musicGenStreamHash() => r'b2022714440474416825d02074aec7148261128c';

/// See also [musicGenStream].
@ProviderFor(musicGenStream)
final musicGenStreamProvider = AutoDisposeStreamProvider<Prediction?>.internal(
  musicGenStream,
  name: r'musicGenStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$musicGenStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MusicGenStreamRef = AutoDisposeStreamProviderRef<Prediction?>;
String _$musicGenNotifierHash() => r'5776d5bd9048bab616fa76132deccc02ecb80031';

/// See also [MusicGenNotifier].
@ProviderFor(MusicGenNotifier)
final musicGenNotifierProvider =
    AutoDisposeAsyncNotifierProvider<MusicGenNotifier, Unit>.internal(
  MusicGenNotifier.new,
  name: r'musicGenNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$musicGenNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MusicGenNotifier = AutoDisposeAsyncNotifier<Unit>;
String _$predictionIdNotifierHash() =>
    r'4d0d8b9a8ca791930621e412de73c9a1e90fc846';

/// See also [PredictionIdNotifier].
@ProviderFor(PredictionIdNotifier)
final predictionIdNotifierProvider =
    AutoDisposeNotifierProvider<PredictionIdNotifier, Option<String>>.internal(
  PredictionIdNotifier.new,
  name: r'predictionIdNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$predictionIdNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PredictionIdNotifier = AutoDisposeNotifier<Option<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
