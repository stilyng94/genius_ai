import 'package:genius_ai/core/presentation/providers/general_providers.dart';
import 'package:genius_ai/core/utils.dart';
import 'package:replicate/replicate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_gen_data_source.g.dart';

class HttpMusicGenDataSource {
  final Replicate replicateAI;

  HttpMusicGenDataSource(this.replicateAI);

  Future<String> genMusic({required String prompt}) async {
    try {
      final response = await replicateAI.predictions.create(
          version:
              "8cf61ea6c56afd61d8f5b9ffd14d7c216c0a93844ce2d82ac1c9ecc9c7f24e05",
          input: {"prompt_a": "funky synth solo"});
      return response.id;
    } on ReplicateException catch (e) {
      debugLog(
        "ReplicateException $e",
      );
      throw e.message;
    } catch (e) {
      throw "Music Gen response error";
    }
  }

  Stream<Prediction> streamResponse({required String predictionId}) {
    return replicateAI.predictions.snapshots(
        id: predictionId, pollingInterval: const Duration(milliseconds: 200));
  }
}

@riverpod
HttpMusicGenDataSource httpMusicGenDataSource(HttpMusicGenDataSourceRef ref) {
  return HttpMusicGenDataSource(ref.watch(replicateAIProvider));
}
