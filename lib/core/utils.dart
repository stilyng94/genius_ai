import 'package:flutter/foundation.dart';

void debugLog(Object? value) {
  if (kDebugMode) {
    print("$value\n");
  }
}
