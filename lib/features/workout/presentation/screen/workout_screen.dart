import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:provider/provider.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});
  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ["All", "Cardio", "Strength", "Yoga", "Pilates"];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<OnboardProvider>();

    return Scaffold(
      backgroundColor: MyColor.homeBodyColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Explore Workouts",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20.h),
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: theme.cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: MyColor.shadowLight,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Icon(Icons.search_rounded, color: MyColor.textThird, size: 22.w),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            
            // 1. Category Filter
            _buildCategoryList(theme, provider),
            SizedBox(height: 25.h),

            // 2. Featured Challenge
            Text("Daily Challenge", style: theme.textTheme.titleLarge),
            SizedBox(height: 15.h),
            _buildFeaturedCard(theme, provider),
            
            SizedBox(height: 25.h),

            // 3. Recommended List
            _buildSectionHeader(theme, "Recommended for You"),
            SizedBox(height: 15.h),
            _buildWorkoutList(theme),
            
            SizedBox(height: 100.h), // Bottom padding for FAB
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(ThemeData theme, OnboardProvider provider) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (c, i) => SizedBox(width: 10.h),
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? null : theme.cardColor,
                gradient: isSelected
                    ? LinearGradient(colors: provider.activeGradient)
                    : null,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: isSelected 
                      ? provider.activeGradient.last.withOpacity(0.3) 
                      : MyColor.shadowLight,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : MyColor.textThird,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedCard(ThemeData theme, OnboardProvider provider) {
    return Container(
      height: 220.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        image: DecorationImage(
          image: const NetworkImage(
              "https://images.unsplash.com/photo-1599058945522-28d584b6f0ff?q=80&w=1000"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.darken),
        ),
        boxShadow: [
          BoxShadow(
            color: MyColor.shadowMedium,
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
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
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20.h,
            bottom: 20.h,
            right: 20.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Text(
                    "Advanced • 45 min",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "High Intensity Burn",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          gradient: LinearGradient(colors: provider.activeGradient),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Start Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.h),
                        ),
                      ),
                    ),
                    SizedBox(width: 15.h),
                    Container(
                      height: 45.h,
                      width: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.bookmark_outline_rounded,
                          color: Colors.white, size: 22.h),
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

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.titleLarge),
        Text("See All",
            style: TextStyle(
                color: MyColor.vibrantPurple,
                fontWeight: FontWeight.w600,
                fontSize: 12.h)),
      ],
    );
  }

  Widget _buildWorkoutList(ThemeData theme) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (c, i) => SizedBox(height: 15.h),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: MyColor.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  index == 0
                      ? "https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=200"
                      : index == 1
                          ? "https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=200"
                          : "https://images.unsplash.com/photo-1549576490-b0b4831ef60a?q=80&w=200",
                  width: 80.h,
                  height: 80.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 15.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0
                          ? "Lower Body Power"
                          : index == 1
                              ? "Core Strength"
                              : "Morning Yoga",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: 14.h, color: MyColor.textThird),
                        SizedBox(width: 4.h),
                        Text("30 min", style: theme.textTheme.bodySmall),
                        SizedBox(width: 12.h),
                        Icon(Icons.local_fire_department_rounded,
                            size: 14.h, color: MyColor.calorieRed),
                        SizedBox(width: 4.h),
                        Text("320 kcal", style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                  color: MyColor.homeBodyColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.play_arrow_rounded,
                    color: MyColor.vibrantPurple, size: 24.h),
              )
            ],
          ),
        );
      },
    );
  }
}
