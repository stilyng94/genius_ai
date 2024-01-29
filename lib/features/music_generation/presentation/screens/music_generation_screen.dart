import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_ai/core/presentation/assets_path.dart';
import 'package:genius_ai/core/utils.dart';
import 'package:just_audio/just_audio.dart';
import 'package:replicate/replicate.dart';
import 'package:rxdart/rxdart.dart';

import 'package:genius_ai/core/presentation/widgets/heading.dart';
import 'package:genius_ai/core/presentation/widgets/loader_widget.dart';
import 'package:genius_ai/features/music_generation/presentation/providers/music_gen_provider.dart';

class MusicGenerationScreen extends ConsumerStatefulWidget {
  static const String pathName = '/music-gen';
  static const String routeName = 'musicGenScreen';
  const MusicGenerationScreen({super.key});

  @override
  ConsumerState<MusicGenerationScreen> createState() =>
      _MusicGenerationScreenState();
}

class _MusicGenerationScreenState extends ConsumerState<MusicGenerationScreen> {
  final imageGenFormKey = GlobalKey<FormState>(debugLabel: "imageGenForm");

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(
          icon: Icon(Icons.image, color: Colors.pink.shade700, size: 18.w),
          title: "Music Generation",
          description: "Generate music using descriptive text",
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
                          hintText: "A roaring lion", border: InputBorder.none),
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
                                .read(musicGenNotifierProvider.notifier)
                                .genMusic(prompt: "an african drum");
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
        ref.watch(musicGenNotifierProvider).whenOrNull(
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const LoaderWidget(),
                ) ??
            const SizedBox(),
        ref.watch(musicGenStreamProvider).whenOrNull(
                  data: (data) => data == null
                      ? const SizedBox()
                      : data.status == PredictionStatus.processing
                          ? const LoaderWidget()
                          : data.status == PredictionStatus.succeeded
                              ? AudioArea(
                                  audioSource: data.urls.get,
                                )
                              : Text(data.status.toString()),
                  error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
                ) ??
            const SizedBox(),
        // const AudioArea(
        //   audioSource: 'asset:///${AssetsPath.testAudio}',
        // )
      ],
    );
  }
}

class AudioArea extends ConsumerStatefulWidget {
  const AudioArea({required this.audioSource, super.key});
  final String audioSource;

  @override
  ConsumerState<AudioArea> createState() => _AudioAreaState();
}

class _AudioAreaState extends ConsumerState<AudioArea> {
  final player = AudioPlayer();

  Future<void> _init() async {
    try {
      await player.setAudioSource(
        AudioSource.uri(Uri.parse(widget.audioSource)),
      );
    } catch (e) {
      debugLog("Error loading audio source: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Stream<({Duration position, Duration bufferedPosition, Duration duration})>
      get _positionDataStream => Rx.combineLatest3(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (a, b, c) =>
              (position: a, bufferedPosition: b, duration: c ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            StreamBuilder(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return Slider(
                      secondaryTrackValue: min(
                          (positionData?.bufferedPosition ?? Duration.zero)
                              .inMilliseconds
                              .toDouble(),
                          (positionData?.duration ?? Duration.zero)
                              .inMilliseconds
                              .toDouble()),
                      value: (positionData?.position ?? Duration.zero)
                          .inMilliseconds
                          .toDouble(),
                      min: 0.0,
                      max: ((positionData?.duration ?? Duration.zero)
                                  .inMilliseconds +
                              const Duration(milliseconds: 100).inMilliseconds)
                          .toDouble(),
                      onChanged: (double value) =>
                          player.seek(Duration(milliseconds: value.round())));
                }),
            StreamBuilder<PlayerState>(
                stream: player.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;

                  if (processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 64.0,
                      height: 64.0,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (playing != true) {
                    return IconButton(
                      icon: const Icon(Icons.play_arrow),
                      iconSize: 64.0,
                      onPressed: player.play,
                    );
                  } else if (processingState != ProcessingState.completed) {
                    return IconButton(
                      icon: const Icon(Icons.pause),
                      iconSize: 64.0,
                      onPressed: player.pause,
                    );
                  } else {
                    return IconButton(
                      icon: const Icon(Icons.replay),
                      iconSize: 64.0,
                      onPressed: () => player.seek(Duration.zero),
                    );
                  }
                })
          ],
        ));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}

//TODO: create own replicateAI gateway
