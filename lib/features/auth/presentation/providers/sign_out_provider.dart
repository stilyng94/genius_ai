import 'package:genius_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out_provider.g.dart';

@riverpod
class SignOutNotifier extends _$SignOutNotifier {
  @override
  FutureOr<Unit> build() {
    return unit;
  }

  void signOut() {
    state = const AsyncData(unit);
    ref.read(authNotifierProvider.notifier).setAuthState(null);
  }
}
