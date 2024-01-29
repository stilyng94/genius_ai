import 'package:dart_openai/dart_openai.dart';
import 'package:genius_ai/core/presentation/providers/general_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_data_source.g.dart';

class HttpConversationDataSource {
  final OpenAI openAI;

  HttpConversationDataSource(this.openAI);

  Future<OpenAIChatCompletionChoiceMessageModel> chatAsync(
      {required List<OpenAIChatCompletionChoiceMessageModel> prompts}) async {
    try {
      final response = await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo",
        messages: prompts,
      );
      return response.choices.first.message;
    } on RequestFailedException catch (e) {
      throw e.message;
    } on StateError catch (_) {
      throw "No response";
    }
  }
}

@riverpod
HttpConversationDataSource httpConversationDataSource(
    HttpConversationDataSourceRef ref) {
  return HttpConversationDataSource(ref.watch(openAIProvider));
}
