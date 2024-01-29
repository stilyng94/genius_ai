import 'dart:async';

import 'package:dio/dio.dart';
import 'package:genius_ai/features/auth/data/data_source/auth_data_source.dart';
import 'package:genius_ai/features/auth/data/dto/login_dto.dart';
import 'package:genius_ai/features/auth/domain/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

abstract class IAuthRepository {
  TaskEither<String, UserModel> signIn(
      {required CancelToken cancelToken, required SignInDto signInDto});
  TaskEither<String, UserModel> signUp(
      {required CancelToken cancelToken, required SignInDto signInDto});
  TaskOption<UserModel> autoAuth();
}

class AuthRepository implements IAuthRepository {
  final HttpAuthDataSource httpAuthDataSource;

  AuthRepository(this.httpAuthDataSource);

  @override
  TaskEither<String, UserModel> signIn(
      {required CancelToken cancelToken, required SignInDto signInDto}) {
    return TaskEither.tryCatch(
      () async => await httpAuthDataSource.signIn(
          cancelToken: cancelToken, loginDto: signInDto),
      (error, stackTrace) => "Parsing error: $error",
    );
  }

  @override
  TaskOption<UserModel> autoAuth() {
    return TaskOption.tryCatch(() async => Future.delayed(
          const Duration(milliseconds: 200),
        ));
  }

  @override
  TaskEither<String, UserModel> signUp(
      {required CancelToken cancelToken, required SignInDto signInDto}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}

@riverpod
IAuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(httpAuthDataSourceProvider));
}
