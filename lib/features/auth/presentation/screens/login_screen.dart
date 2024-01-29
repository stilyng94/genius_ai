import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_ai/core/extensions/async_value_extension.dart';
import 'package:genius_ai/features/auth/data/dto/login_dto.dart';
import 'package:genius_ai/features/auth/presentation/providers/sign_in_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String pathName = '/loginScreen';
  static const String routeName = 'loginScreen';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(signInNotifierProvider, (previous, next) {
      next.showSnackBarOnLoading(context);
    });

    return Scaffold(
        body: SafeArea(
            child: Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 250, minHeight: 200).w,
          child: Card(
            elevation: 4,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sign in"),
                    SizedBox(
                      height: 6.h,
                    ),
                    const Text("to continue to genius-ai"),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Email address"),
                          hintText: "mail@mail.com"),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Password"), hintText: "******"),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.all(
                                      const Radius.circular(4).w))),
                          onPressed: () async {
                            formKey.currentState?.validate();
                            formKey.currentState?.save();
                            await ref
                                .read(signInNotifierProvider.notifier)
                                .signIn(
                                    loginDto: const SignInDto(
                                        email: "mail@mail.com"));
                          },
                          child: const Text("Continue")),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    RichText(
                      text: const TextSpan(text: "No Account?", children: [
                        TextSpan(
                            text: "Sign up",
                            style: TextStyle(fontWeight: FontWeight.w800))
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    )));
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }
}
