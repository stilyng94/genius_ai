import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/core/presentation/widgets/empty_widget.dart';
import 'package:genius_ai/core/presentation/widgets/heading.dart';
import 'package:genius_ai/core/presentation/widgets/loader_widget.dart';
import 'package:genius_ai/features/code_generation/presentation/providers/code_gen_provider.dart';
import 'package:genius_ai/features/conversation/presentation/screens/conversation_screen.dart';
import 'package:markdown_widget/markdown_widget.dart';

class CodeGenScreen extends ConsumerStatefulWidget {
  static const String pathName = '/code-gen';
  static const String routeName = 'code-gen';
  const CodeGenScreen({super.key});

  @override
  ConsumerState<CodeGenScreen> createState() => _CodeGenScreenState();
}

class _CodeGenScreenState extends ConsumerState<CodeGenScreen> {
  final codeGenFormKey = GlobalKey<FormState>(debugLabel: "codeGenForm");

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(
          icon: Icon(Icons.code, color: Colors.green.shade700, size: 18.w),
          title: "Code Generation",
          description: "Generate code using descriptive text",
        ),
        SizedBox(
          height: 24.h,
        ),
        Card(
          elevation: 4,
          child: Form(
              key: codeGenFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(12.0).w,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: "simple toggle button using flutter",
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
                            codeGenFormKey.currentState?.validate();
                            codeGenFormKey.currentState?.save();
                            codeGenFormKey.currentState?.reset();
                            await ref
                                .read(codeGenNotifierProvider.notifier)
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
        ref.watch(codeGenNotifierProvider).whenOrNull(
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const LoaderWidget(),
                ) ??
            const SizedBox(),
        ref.watch(codeGenListNotifierProvider.select((value) => value.isEmpty))
            ? const EmptyWidget(
                message: Option.of("No code started"),
              )
            : const SizedBox(),
        Expanded(
            child: ListView.builder(
                itemCount: ref.watch(codeGenListNotifierProvider
                    .select((value) => value.length)),
                itemBuilder: (context, index) {
                  return ProviderScope(
                    overrides: [codeGenIndexProvider.overrideWithValue(index)],
                    child: const CodeGenItem(),
                  );
                })),
      ],
    );
  }
}

class CodeGenItem extends ConsumerWidget {
  const CodeGenItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(codeGenIndexProvider);
    final genCode = ref.watch(
        codeGenListNotifierProvider.select((value) => value.elementAt(index)));

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4).w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            genCode.role == OpenAIChatMessageRole.user
                ? const UserAvatar()
                : const BotAvatar(),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...MarkdownGenerator().buildWidgets(genCode.content)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
