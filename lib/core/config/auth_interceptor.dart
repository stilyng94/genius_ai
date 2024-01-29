// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:genius_ai/core/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Ref ref;
  AuthInterceptor({
    required this.ref,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      /// Assume 401 stands for token expired
      if (err.response!.statusCode == 401) {
        debugLog('the token has expired, need to receive new token');
      }
      return handler.next(err);
    }
    return handler.next(err);
  }
}
