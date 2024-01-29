import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:genius_ai/core/config/riverpod_logger.dart';
import 'package:genius_ai/core/presentation/widgets/app.dart';
import 'package:genius_ai/core/presentation/widgets/app_error.dart';
import 'package:genius_ai/core/presentation/providers/general_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:genius_ai/features/image_generation/data/repository/image_gen_repository.dart';
import 'package:genius_ai/features/music_generation/data/data_source/music_gen_data_source.dart';
import 'package:genius_ai/features/music_generation/data/repository/music_gen_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  try {
    LicenseRegistry.addLicense(() async* {
      final license =
          await rootBundle.loadString('assets/google_fonts/LICENSE.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
    await FlutterDownloader.initialize(
        debug:
            kDebugMode, // optional: set to false to disable printing logs to console
        ignoreSsl:
            kDebugMode // option: set to false to disable working with http links
        );
    final sharedPreferences = await SharedPreferences.getInstance();

    runApp(ProviderScope(
      observers: [RiverpodLogger()],
      overrides: [
        sharedPreferenceProvider.overrideWithValue(sharedPreferences),
        imageGenRepositoryProvider
            .overrideWithValue(NonHttpImageGenRepository()),
        iMusicGenRepositoryProvider.overrideWith((ref) =>
            MusicGenRepository(ref.watch(httpMusicGenDataSourceProvider)))
      ],
      child: const App(),
    ));
  } catch (e) {
    runApp(ProviderScope(
      observers: [RiverpodLogger()],
      child: const AppErrorWidget(),
    ));
  }

  if (kDebugMode) {
    FlutterError.demangleStackTrace = (StackTrace stack) {
      if (stack is stack_trace.Trace) return stack.vmTrace;
      if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
      return stack;
    };
  }
}
