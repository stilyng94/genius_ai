import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/core/presentation/assets_path.dart';
import 'package:genius_ai/core/presentation/widgets/empty_widget.dart';
import 'package:genius_ai/core/presentation/widgets/heading.dart';
import 'package:genius_ai/core/presentation/widgets/loader_widget.dart';
import 'package:genius_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:genius_ai/features/conversation/presentation/providers/conversation_provider.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  static const String pathName = '/conversation';
  static const String routeName = 'conversation';
  const ConversationScreen({super.key});

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  final conversationFormKey =
      GlobalKey<FormState>(debugLabel: "conversationForm");

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(
          icon: Icon(Icons.chat, color: Colors.indigo.shade600, size: 18.w),
          title: "Conversation",
          description: "Our most advanced conversation model",
        ),
        SizedBox(
          height: 24.h,
        ),
        Card(
          elevation: 4,
          child: Form(
              key: conversationFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(12.0).w,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: "ask me any question",
                          border: InputBorder.none),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.all(
                                      const Radius.circular(4).w))),
                          onPressed: () async {
                            conversationFormKey.currentState?.validate();
                            conversationFormKey.currentState?.save();
                            conversationFormKey.currentState?.reset();
                            await ref
                                .read(conversationNotifierProvider.notifier)
                                .chatAsync("what is your name");
                          },
                          child: const Text("Generate")),
                    ),
                  ],
                ),
              )),
        ),
        SizedBox(
          height: 24.h,
        ),
        ref.watch(conversationNotifierProvider).whenOrNull(
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const LoaderWidget(),
                ) ??
            const SizedBox(),
        ref.watch(conversationListNotifierProvider
                .select((value) => value.isEmpty))
            ? const EmptyWidget(
                message: Option.of("No conversation started"),
              )
            : const SizedBox(),
        Expanded(
            child: ListView.builder(
                reverse: true,
                itemCount: ref.watch(conversationListNotifierProvider
                    .select((value) => value.length)),
                itemBuilder: (context, index) {
                  return ProviderScope(
                    overrides: [
                      conversationIndexProvider.overrideWithValue(index)
                    ],
                    child: const ConversationItem(),
                  );
                })),
      ],
    );
  }
}

class ConversationItem extends ConsumerWidget {
  const ConversationItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(conversationIndexProvider);
    final conversation = ref.watch(conversationListNotifierProvider
        .select((value) => value.elementAt(index)));

    return Card(
      color: conversation.role == OpenAIChatMessageRole.user
          ? Colors.white
          : Colors.grey.shade500,
      child: ListTile(
        leading: conversation.role == OpenAIChatMessageRole.user
            ? const UserAvatar()
            : const BotAvatar(),
        title: Text(conversation.content),
      ),
    );
  }
}

class UserAvatar extends ConsumerWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    return CircleAvatar(
      backgroundColor: Colors.green,
      child: Text(user.email.characters.first),
    );
  }
}

class BotAvatar extends ConsumerWidget {
  const BotAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CircleAvatar(
      backgroundImage: AssetImage(AssetsPath.logo),
    );
  }
}
