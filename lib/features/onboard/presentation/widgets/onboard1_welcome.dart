import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:flutter/material.dart';

class Onboard1Welcome extends StatelessWidget {
  const Onboard1Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Image
        CircleAvatar(
          radius: 50,
          backgroundImage:
              AssetImage(MyImage.trainerImg), // Update with your asset path
        ),
        SizedBox(height: 30),

        // Welcome Text
        Text(
          'Hello, \nwelcome to the journey to your dream body',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        // Subtitle Text
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: 'Here comes a few simple questionsbefore we can '),
              TextSpan(
                text: 'personalize',
                style: TextStyle(color: MyColor.primaryColor),
              ),
              TextSpan(text: ' your daily'),
              TextSpan(
                text: ' goal',
                style: TextStyle(color: MyColor.primaryColor),
              ),
              TextSpan(text: ' and '),
              TextSpan(
                text: 'schedule',
                style: TextStyle(color: MyColor.primaryColor),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
