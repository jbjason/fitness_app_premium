import 'package:fitness_app_premium/config/theme/theme.dart';
import 'package:fitness_app_premium/features/auth/presentation/screens/auth_screen.dart';
import 'package:fitness_app_premium/features/home/presentation/screens/home_screen.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_screen.dart';
import 'package:fitness_app_premium/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const SplashScreen(),
      ),
    );
  }
}
