import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/core/presentation/providers/general_providers.dart';
import 'package:genius_ai/core/presentation/widgets/empty_widget.dart';
import 'package:genius_ai/core/presentation/widgets/heading.dart';
import 'package:genius_ai/core/presentation/widgets/loader_widget.dart';
import 'package:genius_ai/features/image_generation/data/dto/image_gen_dto.dart';
import 'package:genius_ai/features/image_generation/presentation/providers/image_gen_provider.dart';

class ImageGenerationScreen extends ConsumerStatefulWidget {
  static const String pathName = '/image-gen';
  static const String routeName = 'imageGen';
  const ImageGenerationScreen({super.key});

  @override
  ConsumerState<ImageGenerationScreen> createState() =>
      _ImageGenerationScreenState();
}

class _ImageGenerationScreenState extends ConsumerState<ImageGenerationScreen> {
  final imageGenFormKey = GlobalKey<FormState>(debugLabel: "imageGenForm");

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(
          icon: Icon(Icons.image, color: Colors.pink.shade700, size: 18.w),
          title: "Image Generation",
          description: "Generate image using descriptive text",
        ),
        SizedBox(
          height: 24.h,
        ),
        Card(
          elevation: 4,
          child: Form(
              key: imageGenFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(12.0).w,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: "A picture of ferrari",
                          border: InputBorder.none),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    DropdownButtonFormField(
                      value: 1,
                      items: amountOptions
                          .map((amount) => DropdownMenuItem(
                                value: amount.value,
                                child: Text(amount.label),
                              ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    DropdownButtonFormField(
                      value: OpenAIImageSize.size256,
                      items: resolutionOptions
                          .map((resolution) => DropdownMenuItem(
                                value: resolution.value,
                                child: Text(resolution.label),
                              ))
                          .toList(),
                      onChanged: (value) {},
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
                            imageGenFormKey.currentState?.validate();
                            imageGenFormKey.currentState?.save();
                            imageGenFormKey.currentState?.reset();
                            await ref
                                .read(imageGenNotifierProvider.notifier)
                                .genImageAsync(const ImageGenDto(
                                    prompt: "generate a picture of dog",
                                    amount: 1,
                                    resolution: OpenAIImageSize.size256));
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
        ref.watch(imageGenNotifierProvider).whenOrNull(
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const LoaderWidget(),
                ) ??
            const SizedBox(),
        ref.watch(imageGenListNotifierProvider.select((value) => value.isEmpty))
            ? const EmptyWidget(
                message: Option.of("No image generated"),
              )
            : const SizedBox(),
        Expanded(
            child: ListView.builder(
                itemCount: ref.watch(imageGenListNotifierProvider
                    .select((value) => value.length)),
                itemBuilder: (context, index) {
                  return ProviderScope(
                    overrides: [imageGenIndexProvider.overrideWithValue(index)],
                    child: const ImageGenItem(),
                  );
                })),
      ],
    );
  }
}

class ImageGenItem extends ConsumerWidget {
  const ImageGenItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(imageGenIndexProvider);
    final genImage = ref.watch(
        imageGenListNotifierProvider.select((value) => value.elementAt(index)));

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadiusDirectional.all(const Radius.circular(4).w)),
      child: Column(
        children: [
          Image.network(genImage,
              errorBuilder: (context, error, stackTrace) => const Text("😢")),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0).w,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.all(
                              const Radius.circular(4).w))),
                  onPressed: () async {
                    await ref
                        .read(downloaderProvider.notifier)
                        .prepareDownload(genImage);
                  },
                  icon: const Icon(Icons.file_download),
                  label: const Text("download")),
            ),
          )
        ],
      ),
    );
  }
}
