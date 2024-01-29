import 'dart:io';

import 'package:dio/dio.dart';

extension DioExceptionExtension on DioException {
  bool get isNetworkConnectionError {
    return type == DioExceptionType.connectionError ||
        type == DioExceptionType.unknown && error is SocketException;
  }

  String get formattedError {
    return switch (type) {
      DioExceptionType.cancel => "Request to the server was cancelled.",
      DioExceptionType.sendTimeout => "Request to the server was cancelled.",
      DioExceptionType.receiveTimeout => "Request to the server was cancelled.",
      DioExceptionType.connectionError =>
        "Request to the server was cancelled.",
      DioExceptionType.connectionTimeout =>
        "Request to the server was cancelled.",
      DioExceptionType.badResponse => "badResponse.",
      DioExceptionType.badCertificate => "Request to the server was cancelled.",
      DioExceptionType.unknown => error is SocketException
          ? "No internet connection"
          : "Unexpected error occurred."
    };
  }

  String _handleUnknownError() {
    if (error is SocketException) {
      return "No internet connection";
    }
    return "Unexpected error occurred.";
  }
}

extension DioResponseExtension on Response {
  bool get isSuccessResponse {
    return statusCode != null && statusCode! < 400;
  }
}
