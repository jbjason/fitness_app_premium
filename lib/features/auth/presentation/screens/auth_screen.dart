import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/auth/presentation/widgets/auth_body.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.logBackColor,
      body: Center(child: AuhtBody()),
    );
  }


}
