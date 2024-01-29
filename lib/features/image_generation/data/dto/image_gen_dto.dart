// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:equatable/equatable.dart';

const List<({int value, String label})> amountOptions = [
  (label: "1 photo", value: 1),
  (label: "2 photo", value: 2),
  (label: "3 photo", value: 3),
];

const List<({OpenAIImageSize value, String label})> resolutionOptions = [
  (label: "256x256", value: OpenAIImageSize.size256),
  (label: "512x512", value: OpenAIImageSize.size512),
  (label: "1024x1024", value: OpenAIImageSize.size1024),
];

class ImageGenDto with EquatableMixin {
  final String prompt;
  final int amount;
  final OpenAIImageSize resolution;

  const ImageGenDto({
    required this.prompt,
    required this.amount,
    required this.resolution,
  });

  ImageGenDto copyWith({
    String? prompt,
    int? amount,
    OpenAIImageSize? resolution,
  }) {
    return ImageGenDto(
      prompt: prompt ?? this.prompt,
      amount: amount ?? this.amount,
      resolution: resolution ?? this.resolution,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prompt': prompt,
      'amount': amount,
      'resolution': resolution,
    };
  }

  factory ImageGenDto.fromMap(Map<String, dynamic> map) {
    return ImageGenDto(
      prompt: (map['prompt'] ?? '') as String,
      amount: (map['amount'] ?? 0) as int,
      resolution: (map['resolution'] ?? OpenAIImageSize.size256),
    );
  }

  factory ImageGenDto.base() {
    return ImageGenDto(
        amount: 1, prompt: "", resolution: resolutionOptions.first.value);
  }

  String toJson() => json.encode(toMap());

  factory ImageGenDto.fromJson(String source) =>
      ImageGenDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [prompt, amount, resolution];
}

enum AuthType { signIn, signUp }
