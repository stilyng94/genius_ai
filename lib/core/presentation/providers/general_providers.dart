// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:replicate/replicate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:genius_ai/core/config/auth_interceptor.dart';
import 'package:genius_ai/core/config/env/env.dart';
import 'package:genius_ai/core/utils.dart';

part 'general_providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreference(SharedPreferenceRef ref) {
  throw UnimplementedError("sharedPreferences not initialized");
}

@Riverpod(keepAlive: true)
Dio dioInstance(DioInstanceRef ref) {
  final BaseOptions options = BaseOptions(
    connectTimeout: const Duration(milliseconds: 6000),
    receiveTimeout: const Duration(milliseconds: 6000),
    sendTimeout: const Duration(milliseconds: 6000),
    responseType: ResponseType.json,
  );

  final dio = Dio(options);

  dio.interceptors.addAll([
    AuthInterceptor(ref: ref),
    LogInterceptor(
      responseBody: true,
    )
  ]);

  return dio;
}

@Riverpod(keepAlive: true)
InternetConnection internetConnection(InternetConnectionRef ref) {
  return InternetConnection.createInstance(
    checkInterval: const Duration(seconds: 10),
  );
}

@Riverpod(keepAlive: true)
Stream<InternetStatus> networkInfo(NetworkInfoRef ref) {
  final status =
      ref.watch(internetConnectionProvider).onStatusChange.distinct();
  return status;
}

@Riverpod(keepAlive: true)
OpenAI openAI(OpenAIRef ref) {
  OpenAI.apiKey = Env.openAiKey;
  OpenAI.showLogs = kDebugMode;
  return OpenAI.instance;
}

@riverpod
class Downloader extends _$Downloader {
  @override
  Unit build() {
    return unit;
  }

  Future<bool> checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }
      return await Permission.storage.request() == PermissionStatus.granted;
    }
    return false;
  }

  Future<String> _prepareSaveDir() async {
    String localPath = (await _getSavedDir())!;
    final savedDir = Directory(localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
    return localPath;
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        debugLog('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      var dir = (await getLibraryDirectory());
      externalStorageDirPath = dir.absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<void> retryRequestPermission() async {
    final hasGranted = await checkPermission();
    if (hasGranted) {
      await _prepareSaveDir();
    }
  }

  Future<Unit> download(String url, String dir) async {
    await FlutterDownloader.enqueue(
        url: url, savedDir: dir, saveInPublicStorage: true);
    return unit;
  }

  Future<Unit> prepareDownload(String url) async {
    bool permissionReady = await checkPermission();
    if (permissionReady) {
      final savedDir = await _prepareSaveDir();
      await download(url, savedDir);
    }
    return unit;
  }
}

@Riverpod(keepAlive: true)
Replicate replicateAI(ReplicateAIRef ref) {
  Replicate.apiKey = Env.replicateAiKey;
  Replicate.showLogs = true;
  return Replicate.instance;
}
