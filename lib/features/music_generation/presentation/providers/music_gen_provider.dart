import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/features/music_generation/data/repository/music_gen_repository.dart';
import 'package:replicate/replicate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_gen_provider.g.dart';

@riverpod
class MusicGenNotifier extends _$MusicGenNotifier {
  @override
  FutureOr<Unit> build() {
    return unit;
  }

  FutureOr<Unit> genMusic({required String prompt}) async {
    state = const AsyncLoading();

    final failureOrSuccess = await ref
        .read(iMusicGenRepositoryProvider)
        .genMusic(prompt: prompt)
        .run();
    state =
        failureOrSuccess.fold((l) => AsyncError(l, StackTrace.current), (r) {
      ref.read(predictionIdNotifierProvider.notifier).setPredictionIdState(r);
      return const AsyncData(unit);
    });

    return unit;
  }
}

@riverpod
class PredictionIdNotifier extends _$PredictionIdNotifier {
  @override
  Option<String> build() {
    return none();
  }

  void setPredictionIdState(String? predictionId) {
    state = optionOf(predictionId);
  }
}

@riverpod
Stream<Prediction?> musicGenStream(MusicGenStreamRef ref) {
  return ref.watch(predictionIdNotifierProvider).fold(
      () => const Stream.empty(),
      (t) => ref
          .watch(iMusicGenRepositoryProvider)
          .streamResponse(predictionId: t));
}
