import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (kDebugMode) {
      print('''
{
  "previousRoute": "${previousRoute?.toString()}",
  "currentRoute": "${route.toString()}",
}''');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (kDebugMode) {
      print('''
{
  "previousRoute": "${previousRoute?.toString()}",
  "currentRoute": "${route.toString()}",
}''');
    }
  }
}
