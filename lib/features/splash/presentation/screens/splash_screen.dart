// ignore_for_file: use_build_context_synchronously
import 'package:fitness_app_premium/config/extension/media_query_extension.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_dimens.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/onboard/presentation/screens/onboard_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimationStart = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedCrossFade(
        duration: Duration(milliseconds: 2000),
        crossFadeState: _isAnimationStart
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstCurve: Curves.easeIn,
        secondCurve: Curves.easeOut,
        secondChild: _getSplashBody,
        firstChild: SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      MyImage.trainerImg), // Update with your asset path
                ),
                SizedBox(height: 30),
                // Welcome Text
                Text(
                  'Hello, \nwelcome to the journey \nto your dream body',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                // Subtitle Text
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'Here comes a few simple questionsbefore we can ',
                              ),
                      TextSpan(
                        text: 'personalize',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyColor.primaryColor),
                      ),
                      TextSpan(text: ' your daily'),
                      TextSpan(
                        text: ' goal',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyColor.primaryColor),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'schedule',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyColor.primaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _isAnimationStart = false);
                      Future.delayed(Duration(milliseconds: 2500)).then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => OnboardScreen()),
                        );
                      });
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),
                    child: const Text("Start"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _getSplashBody => SizedBox(
        height: context.screenHeight,
        width: context.screenWidth,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: MyDimens().orageGradient),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      "— PART 01 —",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "GOAL & FOCUS",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
