import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/features/image_generation/data/data_source/image_gen_data_source.dart';
import 'package:genius_ai/features/image_generation/data/dto/image_gen_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_gen_repository.g.dart';

abstract class IImageGenRepository {
  TaskEither<String, List<String>> genImageAsync(
      {required ImageGenDto imageGenDto});
}

class ImageGenRepository implements IImageGenRepository {
  final HttpImageGenDataSource httpImageGenDataSource;

  ImageGenRepository(this.httpImageGenDataSource);

  @override
  TaskEither<String, List<String>> genImageAsync(
      {required ImageGenDto imageGenDto}) {
    return TaskEither.tryCatch(
      () async {
        final resp = await httpImageGenDataSource.genImageAsync(
            imageGenDto: imageGenDto);
        return resp.map((e) => e.url!).toList();
      },
      (error, stackTrace) => error.toString(),
    );
  }
}

class NonHttpImageGenRepository implements IImageGenRepository {
  static const List<String> _images = [
    "https://upload.wikimedia.org/wikipedia/commons/e/e4/GatesofArctic.jpg",
    'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg',
  ];

  @override
  TaskEither<String, List<String>> genImageAsync(
      {required ImageGenDto imageGenDto}) {
    return TaskEither.tryCatch(
      () async {
        return _images;
      },
      (error, stackTrace) => error.toString(),
    );
  }
}

@riverpod
IImageGenRepository imageGenRepository(ImageGenRepositoryRef ref) {
  throw UnimplementedError();
}
