import 'package:genius_ai/core/extensions/ref_extension.dart';
import 'package:genius_ai/features/auth/data/dto/login_dto.dart';
import 'package:genius_ai/features/auth/data/repository/auth_repository.dart';
import 'package:genius_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_provider.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  FutureOr<Unit> build() {
    return unit;
  }

  FutureOr<Unit> signIn({required SignInDto loginDto}) async {
    state = const AsyncLoading();
    final failureOrSuccess = await ref
        .read(authRepositoryProvider)
        .signIn(cancelToken: ref.cancelToken(), signInDto: loginDto)
        .run();
    state = failureOrSuccess.fold((l) {
      ref.read(authNotifierProvider.notifier).setAuthState(null);
      return AsyncError(l, StackTrace.fromString("custom stacktrace"));
    }, (r) {
      ref.read(authNotifierProvider.notifier).setAuthState(r);
      return const AsyncData(unit);
    });
    return unit;
  }
}
