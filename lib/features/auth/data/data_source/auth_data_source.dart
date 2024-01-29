import 'package:dio/dio.dart';
import 'package:genius_ai/core/config/api_config.dart';
import 'package:genius_ai/core/extensions/dio_extension.dart';
import 'package:genius_ai/core/presentation/providers/general_providers.dart';
import 'package:genius_ai/features/auth/data/dto/login_dto.dart';
import 'package:genius_ai/features/auth/domain/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_data_source.g.dart';

class HttpAuthDataSource {
  final Dio dio;

  HttpAuthDataSource(this.dio);

  Future<UserModel> signIn(
      {required CancelToken cancelToken, required SignInDto loginDto}) async {
    try {
      final response = await dio.postUri(
          Uri.parse("${ApiConfig.baseUrl}/${ApiConfig.signIn}"),
          data: loginDto.toMap(),
          cancelToken: cancelToken);
      return UserModel.fromMap(response.data);
    } on DioException catch (e) {
      if (e.isNetworkConnectionError) {
        // maybe retry
      }
      throw e.formattedError;
    }
  }

  Future<UserModel> signUp(
      {required CancelToken cancelToken, required SignInDto loginDto}) async {
    try {
      final response = await dio.postUri(
          Uri.parse("${ApiConfig.baseUrl}/${ApiConfig.signUp}"),
          data: loginDto.toMap(),
          cancelToken: cancelToken);
      return UserModel.fromMap(response.data);
    } on DioException catch (e) {
      if (e.isNetworkConnectionError) {
        // maybe retry
      }
      throw e.formattedError;
    }
  }
}

@riverpod
HttpAuthDataSource httpAuthDataSource(HttpAuthDataSourceRef ref) {
  return HttpAuthDataSource(ref.watch(dioInstanceProvider));
}
