import 'package:dart_openai/dart_openai.dart';
import 'package:genius_ai/core/presentation/providers/general_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_gen_data_source.g.dart';

const _instructionMessage = OpenAIChatCompletionChoiceMessageModel(
    role: OpenAIChatMessageRole.system,
    content:
        "You are a code generator. You must answer only in markdown code snippets. Use code comments for explanations.");

class HttpCodeGenDataSource {
  final OpenAI openAI;

  HttpCodeGenDataSource(this.openAI);

  Future<OpenAIChatCompletionChoiceMessageModel> codeGenAsync(
      {required List<OpenAIChatCompletionChoiceMessageModel> prompts}) async {
    try {
      final response = await openAI.chat.create(
          model: "gpt-3.5-turbo", messages: [_instructionMessage, ...prompts]);
      return response.choices.first.message;
    } on RequestFailedException catch (e) {
      throw e.message;
    } on StateError catch (_) {
      throw "Code response error";
    }
  }
}

@riverpod
HttpCodeGenDataSource httpCodeGenDataSource(HttpCodeGenDataSourceRef ref) {
  return HttpCodeGenDataSource(ref.watch(openAIProvider));
}
