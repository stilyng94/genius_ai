import 'package:dart_openai/dart_openai.dart';
import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/features/conversation/data/data_source/conversation_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_repository.g.dart';

abstract class IConversationRepository {
  TaskEither<String, OpenAIChatCompletionChoiceMessageModel> chatAsync(
      {required List<OpenAIChatCompletionChoiceMessageModel> prompts});
}

class ConversationRepository implements IConversationRepository {
  final HttpConversationDataSource httpConversationDataSource;

  ConversationRepository(this.httpConversationDataSource);

  @override
  TaskEither<String, OpenAIChatCompletionChoiceMessageModel> chatAsync(
      {required List<OpenAIChatCompletionChoiceMessageModel> prompts}) {
    return TaskEither.tryCatch(
      () async => await httpConversationDataSource.chatAsync(prompts: prompts),
      (error, stackTrace) => error.toString(),
    );
  }
}

@riverpod
IConversationRepository conversationRepository(ConversationRepositoryRef ref) {
  return ConversationRepository(ref.watch(httpConversationDataSourceProvider));
}
