import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:flutter/material.dart';

class Onboard2Gender extends StatefulWidget {
  const Onboard2Gender({super.key});
  @override
  State<Onboard2Gender> createState() => _Onboard2GenderState();
}

class _Onboard2GenderState extends State<Onboard2Gender> {
  int selectedGender = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            _buildGenderCard(0, MyImage.maleModelImg, size),
            SizedBox(width: 10),
            _buildGenderCard(1, MyImage.femaleModelImg, size),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderCard(int genderIndex, String imagePath, Size size) {
    return SizedBox(
      width: (size.width - 50) * .5,
      height: size.height * .5,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (selectedGender != genderIndex) {
                  setState(() => selectedGender = genderIndex);
                }
              },
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedGender == genderIndex
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
              color:
                  selectedGender == genderIndex ? MyColor.accentColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
