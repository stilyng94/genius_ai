import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/features/music_generation/data/data_source/music_gen_data_source.dart';
import 'package:replicate/replicate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_gen_repository.g.dart';

abstract class IMusicGenRepository {
  TaskEither<String, String> genMusic({required String prompt});
  Stream<Prediction> streamResponse({required String predictionId});
}

class MusicGenRepository implements IMusicGenRepository {
  final HttpMusicGenDataSource httpMusicGenDataSource;

  MusicGenRepository(this.httpMusicGenDataSource);

  @override
  TaskEither<String, String> genMusic({required String prompt}) {
    return TaskEither.tryCatch(
      () async {
        final resp = await httpMusicGenDataSource.genMusic(prompt: prompt);
        return resp;
      },
      (error, stackTrace) => error.toString(),
    );
  }

  @override
  Stream<Prediction> streamResponse({required String predictionId}) {
    return httpMusicGenDataSource.streamResponse(predictionId: predictionId);
  }
}

class NonHttpMusicGenRepository implements IMusicGenRepository {
  @override
  TaskEither<String, String> genMusic({required String prompt}) {
    return TaskEither.tryCatch(
      () async {
        return "";
      },
      (error, stackTrace) => error.toString(),
    );
  }

  @override
  Stream<Prediction> streamResponse({required String predictionId}) {
    return Stream.value(Prediction(
        id: predictionId,
        version: "version",
        urls: PredictionUrls(get: "get", cancel: "cancel"),
        createdAt: DateTime.now(),
        startedAt: null,
        completedAt: null,
        status: PredictionStatus.succeeded,
        input: const {},
        output: const {},
        error: null,
        logs: "logs",
        metrics: null));
  }
}

@riverpod
IMusicGenRepository iMusicGenRepository(IMusicGenRepositoryRef ref) {
  throw UnimplementedError();
}
