import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Onboard4Target extends StatefulWidget {
  const Onboard4Target({super.key});
  @override
  State<Onboard4Target> createState() => _Onboard4TargetState();
}

class _Onboard4TargetState extends State<Onboard4Target> {
  int selectedIndex = 0;

  final List<Map<String, String>> _goals = [
    {
      'title': 'Lose Weight & Keep Fit',
      'subtitle': "💪 Slim & fit ahead!",
      'description':
          'Get ready to see a healthier, lighter you. Follow our tailored plan to conquer your fitness goal!',
      'image': MyImage.loseWeightImg
    },
    {
      'title': 'Butt Lift & Tone',
      'subtitle': "🥰 Bubble butt awaits!",
      'description':
          'Your journey to lifted butt starts now!\nLet\'s shape your glutes into perfect ones!',
      'image': MyImage.buttLiftImg
    },
    {
      'title': 'Lose Belly Fat',
      'subtitle': "👋 Say bye to belly fat!",
      'description':
          'Shed your stubborn belly fat and get a slimmer waistline, and we\'re here to support you!',
      'image': MyImage.bellyFatImg
    },
    {
      'title': 'Build Muscles & Strength',
      'subtitle': "💪 Muscle up, confidence up!",
      'description':
          'Let\'s craft your ideal physique with our superb plan, one muscle at a time.',
      'image': MyImage.buildMuscleImg
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          "What's Your Main Goal?",
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "Select your primary focus to personalize\nyour journey.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 20.h),

        // Goals List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 20.h),
            physics: const BouncingScrollPhysics(),
            itemCount: _goals.length,
            itemBuilder: (context, index) {
              return _buildGoalOption(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGoalOption(int index) {
    final bool isSelected = selectedIndex == index;
    final Map<String, String> goal = _goals[index];

    return GestureDetector(
      onTap: () {
        if (selectedIndex != index) {
          setState(() => selectedIndex = index);
          final data = Provider.of<OnboardProvider>(context, listen: false);
          data.setTarget(index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Title + Image + Check
            Row(
              children: [
                Expanded(
                  child: Text(
                    goal['title'] ?? '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : MyColor.textColor,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                // Image container
                Container(
                  height: 60.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(isSelected ? 0.2 : 0),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    goal['image'] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            // Expandable Description Section
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: isSelected
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Divider(
                            color: Colors.white.withOpacity(0.3),
                            height: 1,
                          ),
                        ),
                        Text(
                          goal['subtitle'] ?? "",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          goal['description'] ?? "",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
