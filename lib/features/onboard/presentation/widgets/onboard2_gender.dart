import 'package:fitness_app_premium/config/extension/media_query_extension.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboard2Gender extends StatefulWidget {
  const Onboard2Gender({super.key});
  @override
  State<Onboard2Gender> createState() => _Onboard2GenderState();
}

class _Onboard2GenderState extends State<Onboard2Gender> {
  int _selectedGender = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          "What's Your Gender?",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 30),
        // Gender Selection
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGenderCard(0, MyImage.maleModelImg),
            SizedBox(width: 10),
            _buildGenderCard(1, MyImage.femaleModelImg),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderCard(int genderIndex, String imagePath) => SizedBox(
        width: (context.screenWidth - 50) * .5,
        height: context.screenHeight * .48,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (_selectedGender != genderIndex) {
                    setState(() => _selectedGender = genderIndex);
                    final data =
                        Provider.of<OnboardProvider>(context, listen: false);
                    data.setGender(genderIndex);
                  }
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedGender == genderIndex
                              ? MyColor.accentColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: MyColor.accentColor, width: 2),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: -20,
                      bottom: -20,
                      left: -20,
                      right: -20,
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              genderIndex == 0 ? "Male" : "Female",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _selectedGender == genderIndex
                    ? MyColor.accentColor
                    : Colors.black,
              ),
            ),
          ],
        ),
      );
}
