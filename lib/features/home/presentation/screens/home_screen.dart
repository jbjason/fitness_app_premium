import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/home/presentation/screens/home_plan_details_screen.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<OnboardProvider>();
    final plan = provider.currentWeightLossPlan;

    return Scaffold(
      backgroundColor: MyColor.homeBodyColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            // Header
            _buildHeader(theme, provider),
            SizedBox(height: 25.h),
            // Main Goal Card
            _buildMainGoalCard(theme, provider),
            SizedBox(height: 25.h),
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    theme,
                    icon: Icons.local_fire_department_rounded,
                    value: "840",
                    unit: "kcal",
                    label: "Calories",
                    iconColor: MyColor.calorieRed,
                    bgColor: MyColor.calorieRed.withOpacity(0.1),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: _buildStatCard(
                    theme,
                    icon: Icons.directions_walk_rounded,
                    value: "4,200",
                    unit: "/6k",
                    label: "Steps",
                    iconColor: MyColor.stepsGreen,
                    bgColor: MyColor.stepsGreen.withOpacity(0.1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            // Your Plan List
            _buildSectionHeader(theme, "Your Plan"),
            SizedBox(height: 15.h),
            Column(
              children: [
                _buildPlanRow(theme,
                    icon: Icons.water_drop_rounded,
                    title: "Hydration",
                    subtitle: "${plan.drinkPlan.waterLiters}L Goal",
                    color: MyColor.waterCyan,
                    detailsType: HomeDetailsPlanType.hydration,
                    context: context),
                SizedBox(height: 12.h),
                _buildPlanRow(theme,
                    icon: Icons.restaurant_menu_rounded,
                    title: "Meal Plan",
                    subtitle: plan.mealPlan.lunch,
                    color: MyColor.fatOrange,
                    detailsType: HomeDetailsPlanType.meal,
                    context: context),
                SizedBox(height: 12.h),
                _buildPlanRow(theme,
                    icon: Icons.fitness_center_rounded,
                    title: "Exercise",
                    subtitle: plan.exercisePlan.activities.first,
                    color: MyColor.vibrantPurple,
                    detailsType: HomeDetailsPlanType.exercise,
                    context: context),
              ],
            ),
            SizedBox(height: 25.h),
            // Today's Plan (Large Card)
            _buildSectionHeader(theme, "Today's Plan", showSeeAll: true),
            SizedBox(height: 15.h),
            _buildBigWorkoutCard(theme, provider),
            SizedBox(height: 25.h),
            // Quick Actions
            _buildSectionHeader(theme, "Meals & Water"),
            SizedBox(height: 15.h),
            SizedBox(
              height: 130.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.none,
                children: [
                  _buildActionCard(theme, "Water", "4/8 Cups",
                      Icons.water_drop_rounded, MyColor.waterCyan),
                  SizedBox(width: 15.w),
                  _buildActionCard(theme, "Breakfast", "Oatmeal",
                      Icons.free_breakfast_rounded, MyColor.fatOrange),
                  SizedBox(width: 15.w),
                  _buildActionCard(theme, "Lunch", "Log now",
                      Icons.lunch_dining_rounded, MyColor.mintFresh),
                ],
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, OnboardProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back,",
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: MyColor.textThird)),
            SizedBox(height: 4.h),
            Text("Sarah Alexa", style: theme.textTheme.displaySmall),
          ],
        ),
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: provider.activeGradient),
          ),
          child: Container(
            padding: EdgeInsets.all(2.w),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: MyColor.cardBackgroundColor),
            child: CircleAvatar(
              radius: 20.r,
              backgroundImage: const NetworkImage(
                  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=200"),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMainGoalCard(ThemeData theme, OnboardProvider provider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      provider.currentWeightLossPlan.levelName.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${provider.selectedWeight}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.h, left: 4.w),
                        child: Text("kg",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14.sp)),
                      ),
                    ],
                  ),
                  Text("Current Weight",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12.sp)),
                ],
              ),
              // Circular Progress
              SizedBox(
                width: 90.w,
                height: 90.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 90.w,
                      height: 90.w,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        color: Colors.white.withOpacity(0.2),
                        strokeWidth: 6.w,
                      ),
                    ),
                    SizedBox(
                      width: 90.w,
                      height: 90.w,
                      child: CircularProgressIndicator(
                        value: provider.progressPercentage,
                        color: Colors.white,
                        strokeWidth: 6.w,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Target",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 10.sp)),
                        Text("${provider.selectedTargetWeight}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),
          // BMI Pill
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: Icon(Icons.monitor_weight_outlined,
                      color: Colors.white, size: 14.w),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "BMI: ${provider.bmi.toStringAsFixed(1)} (Normal)",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.white70, size: 18.w),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatCard(ThemeData theme,
      {required IconData icon,
      required String value,
      required String unit,
      required String label,
      required Color iconColor,
      required Color bgColor}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
              color: MyColor.shadowLight,
              blurRadius: 10,
              offset: const Offset(0, 4))
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20.sp)),
              SizedBox(width: 4.w),
              Text(unit,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 10.sp)),
            ],
          ),
          Text(label,
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildPlanRow(ThemeData theme,
      {required IconData icon,
      required String title,
      required String subtitle,
      required Color color,
      required HomeDetailsPlanType detailsType,
      required BuildContext context}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomePlanDetailsScreen(planType: detailsType),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
                color: MyColor.shadowLight,
                blurRadius: 5,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: color, size: 20.w),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontSize: 14.sp)),
                  SizedBox(height: 2.h),
                  Text(subtitle,
                      style:
                          theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: MyColor.inActiveColor, size: 20.w),
          ],
        ),
      ),
    );
  }

  Widget _buildBigWorkoutCard(ThemeData theme, OnboardProvider provider) {
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        image: const DecorationImage(
          image: NetworkImage(
              "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=1000"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
              color: MyColor.shadowMedium,
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.2),
                  Colors.transparent
                ],
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
                    "${provider.currentWeightLossPlan.levelName.toUpperCase()} PLAN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8.h),
                Text("Full Body HIIT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white70, size: 14.w),
                    SizedBox(width: 4.w),
                    Text("45 Mins",
                        style:
                            TextStyle(color: Colors.white70, fontSize: 12.sp)),
                    SizedBox(width: 15.w),
                    Icon(Icons.fitness_center,
                        color: Colors.white70, size: 14.w),
                    SizedBox(width: 4.w),
                    Text("12 Exercises",
                        style:
                            TextStyle(color: Colors.white70, fontSize: 12.sp)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22.r,
              child: Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Icon(Icons.play_arrow_rounded,
                    color: MyColor.vibrantPurple, size: 28.w),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildActionCard(ThemeData theme, String title, String subtitle,
      IconData icon, Color color) {
    return Container(
      width: 130.w,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r)),
            child: Icon(icon, color: color, size: 20.w),
          ),
          const Spacer(),
          Text(title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          Text(subtitle, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title,
      {bool showSeeAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.titleLarge),
        if (showSeeAll)
          Text("See All",
              style: TextStyle(
                  color: MyColor.vibrantPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp)),
      ],
    );
  }
}
