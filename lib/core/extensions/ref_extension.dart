import 'dart:async';

import 'package:dio/dio.dart';
import 'package:genius_ai/core/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefExtension on Ref {
  CancelToken cancelToken() {
    final token = CancelToken();
    onDispose(token.cancel);
    return token;
  }

  FutureOr<void> debounce(Duration duration) {
    final completer = Completer<void>();
    final timer = Timer(duration, () {
      if (!completer.isCompleted) {
        completer.complete();
      }
    });
    onDispose(() {
      timer.cancel();
      if (!completer.isCompleted) {
        completer.completeError(StateError('cancelled'));
      }
    });

    return completer.future;
  }
}

extension AsyncValueUIExtension<T> on AsyncValue<T> {
  void showSnackbarOnLoading(BuildContext context) => whenOrNull(
      loading: () => CustomSnackbar.showLoadingSnackbar(context: context));
  void showSnackbarOnError(BuildContext context) => whenOrNull(
      error: (error, _) => CustomSnackbar.showErrorSnackbar(
          context: context, error: error.toString()));
}
