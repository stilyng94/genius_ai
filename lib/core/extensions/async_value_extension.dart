import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue<dynamic> {
  void showSnackBarOnError(BuildContext context) => whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.redAccent,
              ),
            );
        },
      );

  void showSnackBarOnLoading(BuildContext context) => whenOrNull(
        loading: () {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('Loading ....'),
              ),
            );
        },
      );

  String? errorMessage() => whenOrNull(
        error: (error, stackTrace) => error.toString(),
      );
}
