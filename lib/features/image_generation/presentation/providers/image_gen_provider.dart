import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/features/image_generation/data/dto/image_gen_dto.dart';
import 'package:genius_ai/features/image_generation/data/repository/image_gen_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_gen_provider.g.dart';

@riverpod
class ImageGenListNotifier extends _$ImageGenListNotifier {
  @override
  List<String> build() {
    return const [];
  }

  void updateList(List<String> images) {
    state = [...state, ...images];
  }
}

@riverpod
class ImageGenNotifier extends _$ImageGenNotifier {
  @override
  FutureOr<Unit> build() {
    return unit;
  }

  FutureOr<Unit> genImageAsync(ImageGenDto imageGenDto) async {
    state = const AsyncLoading();

    final failureOrSuccess = await ref
        .read(imageGenRepositoryProvider)
        .genImageAsync(imageGenDto: imageGenDto)
        .run();
    state =
        failureOrSuccess.fold((l) => AsyncError(l, StackTrace.current), (r) {
      ref.read(imageGenListNotifierProvider.notifier).updateList(r);
      return const AsyncData(unit);
    });

    return unit;
  }
}

@riverpod
int imageGenIndex(ImageGenIndexRef ref) {
  throw UnimplementedError("Pass a valid index");
}
