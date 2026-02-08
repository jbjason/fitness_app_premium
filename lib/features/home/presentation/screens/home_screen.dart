import 'package:fitness_app_premium/features/home/presentation/widgets/drink_chart_card.dart';
import 'package:fitness_app_premium/features/home/presentation/widgets/exercise_plan_card.dart';
import 'package:fitness_app_premium/features/home/presentation/widgets/lifestyle_plan_card.dart';
import 'package:fitness_app_premium/features/home/presentation/widgets/meal_plan_card.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: MyColor.homeBodyColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            _buildHeader(theme, context),
            SizedBox(height: 25.h),
            _buildMainGoalCard(theme, context),
            SizedBox(height: 25.h),
            _buildStatsRow(theme),
            SizedBox(height: 25.h),
            _buildSectionTitleOnly(theme, "Your Plan"),
            SizedBox(height: 15.h),
            _buildPlanCards(theme, context),
            SizedBox(height: 25.h),
            _buildSectionTitle(theme, "Today's Plan"),
            SizedBox(height: 15.h),
            _buildWorkoutCard(theme, context),
            SizedBox(height: 25.h),
            _buildSectionTitle(theme, "Meals & Water"),
            SizedBox(height: 15.h),
            _buildMealAndWaterRow(theme),
            SizedBox(height: 20.h + MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  // --- 1. Header Section ---
  Widget _buildHeader(ThemeData theme, BuildContext context) {
    final provider = context.read<OnboardProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back,",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: MyColor.textThird,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "Sarah Alexa",
              style: theme.textTheme.displaySmall,
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: provider.activeGradient),
            boxShadow: [
              BoxShadow(
                color: provider.activeGradient.last.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: CircleAvatar(
            radius: 22.r,
            backgroundImage: const NetworkImage(
              "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=200",
            ),
          ),
        ),
      ],
    );
  }

  // --- 2. Main Goal Card (Exotic UI) ---
  Widget _buildMainGoalCard(ThemeData theme, BuildContext context) {
    final provider = context.read<OnboardProvider>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        gradient: LinearGradient(
          colors: provider.activeGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: provider.activeGradient.last.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Glassmorphic Goal Pill
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        provider.currentWeightLossPlan.levelName,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${provider.selectedWeight}",
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 36.sp,
                            height: 1.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.h, left: 4.w),
                          child: Text(
                            "kg",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Current Weight",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              // Circular Target Progress
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background Circle
                    SizedBox(
                      width: 90.w,
                      height: 90.w,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 8.w,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    // Value Circle
                    SizedBox(
                      width: 90.w,
                      height: 90.w,
                      child: CircularProgressIndicator(
                        value: provider.progressPercentage,
                        strokeWidth: 8.w,
                        color: Colors.white,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Target",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        Text(
                          "${provider.selectedTargetWeight}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),
          // BMI Indicator
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: MyColor.logBackColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Icon(Icons.monitor_weight_outlined,
                    color: Colors.white, size: 20.w),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "BMI: ${provider.bmi.toStringAsFixed(1)} (Normal)",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14.w)
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- 3. Stats Row ---
  Widget _buildStatsRow(ThemeData theme) {
    return Row(
      children: [
        _buildStatItem(
          theme,
          label: "Calories",
          value: "840",
          unit: "kcal",
          icon: Icons.local_fire_department_rounded,
          iconColor: MyColor.calorieRed,
          bgColor: MyColor.calorieRed.withOpacity(0.1),
        ),
        SizedBox(width: 15.w),
        _buildStatItem(
          theme,
          label: "Steps",
          value: "4,200",
          unit: "/6k",
          icon: Icons.directions_walk_rounded,
          iconColor: MyColor.stepsGreen,
          bgColor: MyColor.stepsGreen.withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _buildStatItem(
    ThemeData theme, {
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: MyColor.shadowLight,
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 20.w),
            ),
            SizedBox(height: 12.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.sp,
                    ),
                  ),
                  TextSpan(
                    text: " $unit",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(label, style: theme.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }

  // --- 4. Workout Card ---
  Widget _buildWorkoutCard(ThemeData theme, BuildContext context) {
    final provider = context.read<OnboardProvider>();
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: theme.cardColor,
        image: DecorationImage(
          image: const NetworkImage(
              "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=1000"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
        boxShadow: [
          BoxShadow(
            color: MyColor.shadowMedium,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ),
            ),
          ),
          Positioned(
            left: 20.w,
            bottom: 20.h,
            right: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: MyColor.vibrantPurple,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "${provider.currentWeightLossPlan.levelName} Plan",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Full Body HIIT",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        color: Colors.white70, size: 16.w),
                    SizedBox(width: 5.w),
                    Text("45 Mins",
                        style:
                            TextStyle(color: Colors.white70, fontSize: 12.sp)),
                    SizedBox(width: 15.w),
                    Icon(Icons.fitness_center_rounded,
                        color: Colors.white70, size: 16.w),
                    SizedBox(width: 5.w),
                    Text("12 Exercises",
                        style:
                            TextStyle(color: Colors.white70, fontSize: 12.sp)),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20.r,
              child:
                  Icon(Icons.play_arrow_rounded, color: MyColor.vibrantPurple),
            ),
          )
        ],
      ),
    );
  }

  // --- 5. Horizontal Actions ---
  Widget _buildMealAndWaterRow(ThemeData theme) {
    return SizedBox(
      height: 130.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _buildActionCard(
            theme,
            title: "Water",
            subtitle: "4/8 Cups",
            color: MyColor.waterCyan,
            icon: Icons.water_drop_rounded,
          ),
          SizedBox(width: 15.w),
          _buildActionCard(
            theme,
            title: "Breakfast",
            subtitle: "Oatmeal",
            color: MyColor.fatOrange,
            icon: Icons.free_breakfast_rounded,
          ),
          SizedBox(width: 15.w),
          _buildActionCard(
            theme,
            title: "Lunch",
            subtitle: "Log now",
            color: MyColor.mintFresh,
            icon: Icons.lunch_dining_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    ThemeData theme, {
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 130.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
                color: MyColor.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r)),
            child: Icon(icon, color: color, size: 24.w),
          ),
          const Spacer(),
          Text(title,
              style: theme.textTheme.titleMedium?.copyWith(fontSize: 14.sp)),
          Text(subtitle, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.titleLarge),
        Text("See All",
            style: TextStyle(
                color: MyColor.vibrantPurple,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp)),
      ],
    );
  }

  Widget _buildSectionTitleOnly(ThemeData theme, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: theme.textTheme.titleLarge),
    );
  }

  Widget _buildPlanCards(ThemeData theme, BuildContext context) {
    final plan = context.read<OnboardProvider>().currentWeightLossPlan;

    return Column(
      children: [
        DrinkChartCard(
          drinkPlan: plan.drinkPlan,
          planLevel: plan.level,
        ),
        SizedBox(height: 20.h),
        MealPlanCard(
          mealPlan: plan.mealPlan,
          planLevel: plan.level,
        ),
        SizedBox(height: 20.h),
        ExercisePlanCard(
          exercisePlan: plan.exercisePlan,
          planLevel: plan.level,
        ),
        SizedBox(height: 20.h),
        LifestylePlanCard(
          lifestylePlan: plan.lifestylePlan,
          planLevel: plan.level,
        ),
      ],
    );
  }
}
