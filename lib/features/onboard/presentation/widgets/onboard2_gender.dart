import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Onboard2Gender extends StatefulWidget {
  const Onboard2Gender({super.key});
  @override
  State<Onboard2Gender> createState() => _Onboard2GenderState();
}

class _Onboard2GenderState extends State<Onboard2Gender> {
  int _selectedGender = 0; // 0: Male, 1: Female

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          "What's Your Gender?",
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: MyColor.textColor,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        // Subtitle
        Text(
          "Let us know you better to customize\nyour plan.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
        SizedBox(height: 30.h),
        
        // Gender Selection Cards
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGenderCard(0, MyImage.maleModelImg, "Male"),
              SizedBox(width: 20.w),
              _buildGenderCard(1, MyImage.femaleModelImg, "Female"),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildGenderCard(int genderIndex, String imagePath, String label) {
    final bool isSelected = _selectedGender == genderIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_selectedGender != genderIndex) {
            setState(() => _selectedGender = genderIndex);
            final data = context.read<OnboardProvider>();
            data.setGender(genderIndex);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.only(bottom: 20.h), // Space for shadow
          decoration: BoxDecoration(
            color: isSelected ? MyColor.accentColor : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isSelected ? MyColor.accentColor : Colors.grey.withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected 
                    ? MyColor.accentColor.withOpacity(0.4) 
                    : Colors.grey.withOpacity(0.1),
                blurRadius: isSelected ? 15 : 10,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // Label
              Text(
                label,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : MyColor.textColor,
                ),
              ),
              
              // Image
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Selection Indicator (Radio style)
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                height: 28.w,
                width: 28.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.grey.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: isSelected 
                  ? Icon(Icons.check, size: 18.sp, color: MyColor.accentColor) 
                  : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
