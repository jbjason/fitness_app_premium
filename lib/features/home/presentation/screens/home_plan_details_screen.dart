import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

enum HomeDetailsPlanType { hydration, meal, exercise }

class HomePlanDetailsScreen extends StatelessWidget {
  final HomeDetailsPlanType planType;
  const HomePlanDetailsScreen({super.key, required this.planType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<OnboardProvider>();
    final plan = provider.currentWeightLossPlan;

    String title = "";
    Color color = MyColor.vibrantPurple;
    IconData icon = Icons.help;
    Widget content = const SizedBox();

    switch (planType) {
      case HomeDetailsPlanType.hydration:
        title = "Hydration Plan";
        color = MyColor.waterCyan;
        icon = Icons.water_drop_rounded;
        content = _buildHydrationContent(theme, plan);
        break;
      case HomeDetailsPlanType.meal:
        title = "Meal Plan";
        color = MyColor.fatOrange;
        icon = Icons.restaurant_menu_rounded;
        content = _buildMealContent(theme, plan);
        break;
      case HomeDetailsPlanType.exercise:
        title = "Exercise Routine";
        color = MyColor.vibrantPurple;
        icon = Icons.fitness_center_rounded;
        content = _buildExerciseContent(theme, plan);
        break;
    }

    return Scaffold(
      backgroundColor: MyColor.homeBodyColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: theme.cardColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: MyColor.textColor, size: 18.w),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        centerTitle: true,
        title: Text(title, style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _buildHeaderCard(theme, title, color, icon, plan.levelName),
            SizedBox(height: 30.h),
            content,
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(ThemeData theme, String title, Color color,
      IconData icon, String levelName) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 40.w),
          ),
          SizedBox(height: 20.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "$levelName Level",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Hydration Content ---
  Widget _buildHydrationContent(ThemeData theme, WeightLossPlan plan) {
    // Assuming a standard glass is 0.25L
    final double liters = _parseWaterLiters(plan.drinkPlan.waterLiters);
    final int glasses = (liters / 0.25).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(theme, "Daily Goal"),
        SizedBox(height: 15.h),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                  color: MyColor.shadowLight,
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                plan.drinkPlan.waterLiters,
                style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColor.waterCyan),
              ),
              SizedBox(width: 8.w),
              Text(
                "Liters\nPer Day",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: MyColor.textThird,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 25.h),
        _buildSectionTitle(theme, "Tracking (~250ml/glass)"),
        SizedBox(height: 15.h),
        Wrap(
          spacing: 15.w,
          runSpacing: 15.h,
          alignment: WrapAlignment.center,
          children: List.generate(glasses, (index) {
            return Column(
              children: [
                Icon(Icons.local_drink_rounded,
                    color: MyColor.waterCyan.withOpacity(0.5), size: 32.w),
                SizedBox(height: 4.h),
                Text("${index + 1}",
                    style: TextStyle(
                        fontSize: 10.sp, color: MyColor.inActiveColor)),
              ],
            );
          }),
        ),
        SizedBox(height: 25.h),
        _buildTipCard(
            theme,
            "Hydration Tip",
            "Drinking water before meals can help you feel fuller and aid in weight loss.",
            MyColor.waterCyan),
      ],
    );
  }

  // --- Meal Content ---
  Widget _buildMealContent(ThemeData theme, WeightLossPlan plan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(theme, "Today's Menu"),
        SizedBox(height: 15.h),
        _buildMealItem(
          theme,
          "Breakfast",
          plan.mealPlan.breakfast,
          "08:00 AM",
          "~350 kcal",
          Icons.free_breakfast_rounded,
          MyColor.fatOrange,
        ),
        _buildMealItem(
          theme,
          "Lunch",
          plan.mealPlan.lunch,
          "01:00 PM",
          "~500 kcal",
          Icons.lunch_dining_rounded,
          MyColor.mintFresh,
        ),
        _buildMealItem(
          theme,
          "Snacks",
          plan.mealPlan.snacks,
          "04:00 PM",
          "~150 kcal",
          Icons.restaurant_rounded,
          MyColor.energyOrange,
        ),
        // Mock Dinner for completeness as it might not be in the basic model
        _buildMealItem(
          theme,
          "Dinner",
          "Grilled Fish or Tofu with Steamed Vegetables",
          "07:30 PM",
          "~400 kcal",
          Icons.dinner_dining_rounded,
          MyColor.vibrantPurple,
        ),
        SizedBox(height: 10.h),
        _buildTipCard(
            theme,
            "Diet Tip",
            "Focus on protein and fiber to keep you satisfied longer between meals.",
            MyColor.fatOrange),
      ],
    );
  }

  Widget _buildMealItem(ThemeData theme, String title, String meal, String time,
      String cal, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
              color: MyColor.shadowLight,
              blurRadius: 5,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 24.w),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: MyColor.homeBodyColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(time,
                          style: TextStyle(
                              fontSize: 10.sp, color: MyColor.textThird)),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(meal, style: theme.textTheme.bodyMedium),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.local_fire_department_rounded,
                        size: 14.w, color: MyColor.calorieRed),
                    SizedBox(width: 4.w),
                    Text(cal,
                        style: TextStyle(
                            fontSize: 12.sp, color: MyColor.calorieRed)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Exercise Content ---
  Widget _buildExerciseContent(ThemeData theme, WeightLossPlan plan) {
    final activities = plan.exercisePlan.activities;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(theme, "Routine Overview"),
        SizedBox(height: 15.h),
        Row(
          children: [
            Expanded(
              child: _buildStatBox(
                  theme, "Duration", plan.exercisePlan.duration, Icons.timer),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: _buildStatBox(theme, "Intensity", plan.levelName,
                  Icons.speed), // Using level name as intensity
            ),
          ],
        ),
        SizedBox(height: 25.h),
        _buildSectionTitle(theme, "Exercises"),
        SizedBox(height: 15.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activities.length,
          separatorBuilder: (c, i) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: MyColor.dividerColor),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: MyColor.vibrantPurple.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                          color: MyColor.vibrantPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    activities[index],
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 25.h),
        _buildTipCard(
            theme,
            "Pro Tip",
            "Consistency is key. Even a light workout is better than skipping entirely.",
            MyColor.vibrantPurple),
      ],
    );
  }

  Widget _buildStatBox(
      ThemeData theme, String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
              color: MyColor.shadowLight,
              blurRadius: 5,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: MyColor.textThird, size: 24.w),
          SizedBox(height: 8.h),
          Text(value.replaceAll('/day', ''),
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 4.h),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(title,
        style:
            theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold));
  }

  Widget _buildTipCard(
      ThemeData theme, String title, String content, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_rounded, color: color, size: 24.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Text(content,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontSize: 13.sp, color: MyColor.textThird)),
              ],
            ),
          )
        ],
      ),
    );
  }

  double _parseWaterLiters(String value) {
    final String cleaned = value.replaceAll(',', '.').trim();
    if (cleaned.isEmpty) {
      return 0;
    }

    final List<String> parts = cleaned.split('-');
    if (parts.length == 2) {
      final double? minValue = double.tryParse(parts[0].trim());
      final double? maxValue = double.tryParse(parts[1].trim());
      if (minValue != null && maxValue != null) {
        return (minValue + maxValue) / 2;
      }
    }

    return double.tryParse(cleaned) ?? 0;
  }
}
