import 'package:fitness_app_premium/core/util/my_dimens.dart';
import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons(
      {required this.isLogin,
      required this.onSubmit,
      required this.isLoading,
      required this.onTrySignUp,
      super.key});
  final bool isLogin;
  final ValueNotifier<bool> isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onTrySignUp;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, bool isLoad, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLoad) ...[
            const CircularProgressIndicator(),
          ] else ...[
            // signIn text
            GestureDetector(
              onTap: onSubmit,
              child: Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: MyDimens.loginGradient,
                ),
                child: Center(
                  child: Text(
                    isLogin ? 'Sign In' : 'Sign Up',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
            // create & already have account text
            Center(
              child: TextButton(
                onPressed: onTrySignUp,
                child: Text(
                  isLogin ? 'Create new account' : 'I already have an account',
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
