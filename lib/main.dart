import 'package:fitness_app_premium/config/theme/theme.dart';
import 'package:fitness_app_premium/features/auth/presentation/screens/auth_screen.dart';
import 'package:fitness_app_premium/features/onboard/presentation/screens/onboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme:AppTheme.light(),
      home: const OnboardScreen()
    );
  }
}


/*
BMI Formula:

BMI=  Weight(kg)/ height(m)square(2)
 

​
 
Underweight: BMI < 18.5

Healthy: BMI 18.5–24.9

Overweight: BMI 25–29.9

Obese: BMI ≥ 30

Limitations:

BMI doesn’t account for muscle mass (athletes may have high BMI but low fat).

Body frame size (small, medium, large) can influence ideal weight.

Alternative Measures:

Waist-to-Height Ratio (keep waist circumference < half your height).

Body Fat Percentage (healthy range: Men 10–20%, Women 18–28%).
*/