// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$conversationIndexHash() => r'1aadf9f29bb5f2898ca7eed07443028fc07a2df7';

/// See also [conversationIndex].
@ProviderFor(conversationIndex)
final conversationIndexProvider = AutoDisposeProvider<int>.internal(
  conversationIndex,
  name: r'conversationIndexProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$conversationIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConversationIndexRef = AutoDisposeProviderRef<int>;
String _$conversationListNotifierHash() =>
    r'9a1c4f100e996511c412008e5f082e2033a8e5c8';

/// See also [ConversationListNotifier].
@ProviderFor(ConversationListNotifier)
final conversationListNotifierProvider = AutoDisposeNotifierProvider<
    ConversationListNotifier,
    List<OpenAIChatCompletionChoiceMessageModel>>.internal(
  ConversationListNotifier.new,
  name: r'conversationListNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$conversationListNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConversationListNotifier
    = AutoDisposeNotifier<List<OpenAIChatCompletionChoiceMessageModel>>;
String _$conversationNotifierHash() =>
    r'8de179ceca84377e47f5b24b37ffacea14c7c467';

/// See also [ConversationNotifier].
@ProviderFor(ConversationNotifier)
final conversationNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ConversationNotifier, Unit>.internal(
  ConversationNotifier.new,
  name: r'conversationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$conversationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConversationNotifier = AutoDisposeAsyncNotifier<Unit>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
