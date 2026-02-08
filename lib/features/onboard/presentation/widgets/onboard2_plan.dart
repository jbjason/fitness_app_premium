import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Onboard2Plan extends StatefulWidget {
  const Onboard2Plan({super.key});
  @override
  State<Onboard2Plan> createState() => _Onboard2PlanState();
}

class _Onboard2PlanState extends State<Onboard2Plan> {
  int _selectedPlan = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          'Choose Your Plan',
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: MyColor.textColor,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),

        // Subtitle / Info
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            'Your coach will design a weight loss plan\nthat suits your lifestyle best.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 30.h),

        // Plan Options List
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildPlanOption(0, 'Beginner', '20-30 min a day',
                    Icons.accessibility_new_rounded),
                SizedBox(height: 15.h),
                _buildPlanOption(1, 'Intermediate', '40-60 min a day',
                    Icons.fitness_center_rounded),
                SizedBox(height: 15.h),
                _buildPlanOption(2, 'Advanced', '60-90 min a day',
                    Icons.local_fire_department_rounded),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Plan Card Builder
  Widget _buildPlanOption(
      int index, String plan, String duration, IconData iconData) {
    final bool isSelected = _selectedPlan == index;

    return GestureDetector(
      onTap: () {
        if (_selectedPlan != index) {
          setState(() => _selectedPlan = index);
          final data = Provider.of<OnboardProvider>(context, listen: false);
          data.setPlan(index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: isSelected ? MyColor.accentColor : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color:
                isSelected ? MyColor.accentColor : Colors.grey.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? MyColor.accentColor.withOpacity(0.4)
                  : Colors.grey.withOpacity(0.05),
              blurRadius: isSelected ? 12 : 5,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : MyColor.accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: isSelected ? Colors.white : MyColor.accentColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 20.w),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : MyColor.textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isSelected
                          ? Colors.white.withOpacity(0.9)
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Selection Indicator (Radio/Check)
            Container(
              height: 24.w,
              width: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(
                  color:
                      isSelected ? Colors.white : Colors.grey.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 16.sp, color: MyColor.accentColor)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
