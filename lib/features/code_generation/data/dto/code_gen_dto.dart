// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CodeGenDto with EquatableMixin {
  final String prompt;
  const CodeGenDto({
    required this.prompt,
  });

  CodeGenDto copyWith({
    String? prompt,
  }) {
    return CodeGenDto(
      prompt: prompt ?? this.prompt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prompt': prompt,
    };
  }

  factory CodeGenDto.fromMap(Map<String, dynamic> map) {
    return CodeGenDto(
      prompt: (map['prompt'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeGenDto.fromJson(String source) =>
      CodeGenDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [prompt];
}

enum AuthType { signIn, signUp }
