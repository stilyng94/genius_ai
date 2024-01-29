import 'package:genius_ai/features/auth/data/repository/auth_repository.dart';
import 'package:genius_ai/features/auth/domain/user_model.dart';
import 'package:genius_ai/features/auth/presentation/providers/sign_out_provider.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  Option<UserModel> build() {
    return none();
  }

  void setAuthState(UserModel? user) {
    state = optionOf(user);
  }
}

@Riverpod(keepAlive: true)
UserModel currentUser(CurrentUserRef ref) {
  return ref.watch(authNotifierProvider).fold(() => ref.state, (t) => t);
}

@riverpod
FutureOr<Option<UserModel>> autoLogin(AutoLoginRef ref) async {
  await Future<void>.delayed(const Duration(seconds: 1)); //Min Time of splash
  ref.listenSelf((previous, next) {
    next.whenOrNull(
      data: (user) => ref
          .read(authNotifierProvider.notifier)
          .setAuthState(user.toNullable()),
      error: (error, stackTrace) =>
          ref.read(signOutNotifierProvider.notifier).signOut(),
    );
  });
  return ref.watch(authRepositoryProvider).autoAuth().run();
}
