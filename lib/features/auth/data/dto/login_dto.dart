// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SignInDto with EquatableMixin {
  final String email;
  const SignInDto({
    required this.email,
  });

  SignInDto copyWith({
    String? email,
  }) {
    return SignInDto(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory SignInDto.fromMap(Map<String, dynamic> map) {
    return SignInDto(
      email: (map['email'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInDto.fromJson(String source) =>
      SignInDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email];
}

enum AuthType { signIn, signUp }
