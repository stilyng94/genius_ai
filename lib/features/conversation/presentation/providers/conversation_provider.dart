import 'package:dart_openai/dart_openai.dart';
import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/features/conversation/data/repository/conversation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_provider.g.dart';

@riverpod
class ConversationListNotifier extends _$ConversationListNotifier {
  @override
  List<OpenAIChatCompletionChoiceMessageModel> build() {
    return const [];
  }

  void updateList(
      ({
        OpenAIChatCompletionChoiceMessageModel userPrompt,
        OpenAIChatCompletionChoiceMessageModel aiResponse
      }) messages) {
    state = [...state, messages.userPrompt, messages.aiResponse];
  }
}

@riverpod
class ConversationNotifier extends _$ConversationNotifier {
  @override
  FutureOr<Unit> build() {
    return unit;
  }

  FutureOr<Unit> chatAsync(String prompt) async {
    state = const AsyncLoading();
    final newPrompt = OpenAIChatCompletionChoiceMessageModel(
        content: prompt, role: OpenAIChatMessageRole.user);
    final prompts = [...ref.read(conversationListNotifierProvider), newPrompt];

    final failureOrSuccess = await ref
        .read(conversationRepositoryProvider)
        .chatAsync(prompts: prompts)
        .run();
    state =
        failureOrSuccess.fold((l) => AsyncError(l, StackTrace.current), (r) {
      ref
          .read(conversationListNotifierProvider.notifier)
          .updateList((userPrompt: newPrompt, aiResponse: r));
      return const AsyncData(unit);
    });

    return unit;
  }
}

@riverpod
int conversationIndex(ConversationIndexRef ref) {
  throw UnimplementedError("Pass a valid index");
}
