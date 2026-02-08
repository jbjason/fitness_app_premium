import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    "All",
    "Cardio",
    "Strength",
    "Yoga",
    "Pilates"
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<OnboardProvider>();
    final plan = provider.currentWeightLossPlan;

    return Scaffold(
      backgroundColor: MyColor.homeBodyColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Explore Workouts", style: theme.textTheme.titleLarge),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20.w),
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
                color: MyColor.cardBackgroundColor, shape: BoxShape.circle),
            child: Icon(Icons.search_rounded,
                color: MyColor.textThird, size: 22.w),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            // Categories
            SizedBox(
              height: 45.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _categories.length,
                separatorBuilder: (c, i) => SizedBox(width: 10.w),
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategoryIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? null : MyColor.cardBackgroundColor,
                        gradient: isSelected
                            ? LinearGradient(colors: provider.activeGradient)
                            : null,
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: [
                          BoxShadow(
                              color: isSelected
                                  ? provider.activeGradient.last
                                      .withOpacity(0.3)
                                  : MyColor.shadowLight,
                              blurRadius: 8,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                            color:
                                isSelected ? Colors.white : MyColor.textThird,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 25.h),
            // Daily Challenge
            Text("Daily Challenge", style: theme.textTheme.titleLarge),
            SizedBox(height: 15.h),
            _buildChallengeCard(theme, provider, plan),
            SizedBox(height: 25.h),
            // Recommended
            _buildSectionHeader(theme, "Recommended for You"),
            SizedBox(height: 15.h),
            Column(
              children: [
                _buildWorkoutListItem(
                  theme,
                  title: "Full Body Flow",
                  duration: "30 min",
                  kcal: "220",
                  img:
                      "https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=200",
                ),
                SizedBox(height: 15.h),
                _buildWorkoutListItem(
                  theme,
                  title: "Core & Stability",
                  duration: "20 min",
                  kcal: "150",
                  img:
                      "https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=200",
                ),
                SizedBox(height: 15.h),
                _buildWorkoutListItem(
                  theme,
                  title: "Light Cardio",
                  duration: "45 min",
                  kcal: "300",
                  img:
                      "https://images.unsplash.com/photo-1549576490-b0b4831ef60a?q=80&w=200",
                ),
              ],
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(
      ThemeData theme, OnboardProvider provider, WeightLossPlan plan) {
    return Container(
      height: 220.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        image: const DecorationImage(
          image: NetworkImage(
              "https://images.unsplash.com/photo-1599058945522-28d584b6f0ff?q=80&w=1000"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
              color: MyColor.shadowMedium,
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
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
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Text(
                    "${plan.levelName} • 30 Min",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 10.h),
                Text("High Intensity Burn",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          gradient:
                              LinearGradient(colors: provider.activeGradient),
                        ),
                        child: Text("Start Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp)),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Container(
                      height: 45.h,
                      width: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Icon(Icons.bookmark_border_rounded,
                          color: Colors.white, size: 22.w),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWorkoutListItem(ThemeData theme,
      {required String title,
      required String duration,
      required String kcal,
      required String img}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
              color: MyColor.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.network(img,
                width: 80.w, height: 80.w, fit: BoxFit.cover),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        size: 14.w, color: MyColor.textThird),
                    SizedBox(width: 4.w),
                    Text(duration, style: theme.textTheme.bodySmall),
                    SizedBox(width: 12.w),
                    Icon(Icons.local_fire_department_rounded,
                        size: 14.w, color: MyColor.calorieRed),
                    SizedBox(width: 4.w),
                    Text("$kcal kcal", style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
                color: MyColor.homeBodyColor, shape: BoxShape.circle),
            child: Icon(Icons.play_arrow_rounded,
                color: MyColor.vibrantPurple, size: 24.w),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
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
}
