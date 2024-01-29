// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ConversationDto with EquatableMixin {
  final String prompt;
  const ConversationDto({
    required this.prompt,
  });

  ConversationDto copyWith({
    String? prompt,
  }) {
    return ConversationDto(
      prompt: prompt ?? this.prompt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prompt': prompt,
    };
  }

  factory ConversationDto.fromMap(Map<String, dynamic> map) {
    return ConversationDto(
      prompt: (map['prompt'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationDto.fromJson(String source) =>
      ConversationDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [prompt];
}

enum AuthType { signIn, signUp }
