import 'package:dart_openai/dart_openai.dart';
import 'package:genius_ai/core/presentation/providers/general_providers.dart';
import 'package:genius_ai/features/image_generation/data/dto/image_gen_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_gen_data_source.g.dart';

class HttpImageGenDataSource {
  final OpenAI openAI;

  HttpImageGenDataSource(this.openAI);

  Future<List<OpenAIImageData>> genImageAsync(
      {required ImageGenDto imageGenDto}) async {
    try {
      final response = await openAI.image.create(
          prompt: imageGenDto.prompt,
          n: imageGenDto.amount,
          responseFormat: OpenAIImageResponseFormat.url,
          size: imageGenDto.resolution);
      return response.data;
    } on RequestFailedException catch (e) {
      throw e.message;
    } on StateError catch (_) {
      throw "Image Gen response error";
    }
  }
}

@riverpod
HttpImageGenDataSource httpImageGenDataSource(HttpImageGenDataSourceRef ref) {
  return HttpImageGenDataSource(ref.watch(openAIProvider));
}
