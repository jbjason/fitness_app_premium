import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Assuming OnboardProvider is available as per your HomeScreen
    final provider = context.watch<OnboardProvider>();

    return Scaffold(
      backgroundColor: MyColor.homeBodyColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Progress Report",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20.w),
            padding: EdgeInsets.all(8.w),
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
            child: Icon(
              Icons.calendar_month_rounded,
              color: MyColor.textThird,
              size: 20.w,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // 1. Main Weight Chart
            _buildWeightChartCard(theme, provider),
            SizedBox(height: 25.h),
            // 2. Summary Stats Grid
            _buildSummaryGrid(theme, provider),
            SizedBox(height: 25.h),
            // 3. BMI Linear Gauge
            _buildBMIGauge(theme, provider),
            SizedBox(height: 25.h),
            // 4. Transformation Photos
            _buildSectionTitle(theme, "Transformation"),
            SizedBox(height: 15.h),
            _buildComparisonCard(theme),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  // --- 1. Custom Weight Chart Card ---
  Widget _buildWeightChartCard(ThemeData theme, OnboardProvider provider) {
    // Mock Data: Last 7 days weights
    final List<double> weeklyWeights = [
      provider.selectedWeight + 1.5,
      provider.selectedWeight + 1.2,
      provider.selectedWeight + 0.8,
      provider.selectedWeight + 0.5,
      provider.selectedWeight + 0.9,
      provider.selectedWeight + 0.2,
      provider.selectedWeight // Current
    ];

    // Find max for scaling the bars
    final double maxWeight = weeklyWeights.reduce(math.max);
    final double minWeight = weeklyWeights.reduce(math.min);

    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.shadowMedium,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Weight History", style: theme.textTheme.titleMedium),
                  SizedBox(height: 4.h),
                  Text("Last 7 Days", style: theme.textTheme.bodySmall),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: MyColor.successGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_down_rounded,
                        color: MyColor.successGreen, size: 16.w),
                    SizedBox(width: 4.w),
                    Text("-1.5 kg",
                        style: TextStyle(
                            color: MyColor.successGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp)),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 30.h),
          // The Custom Bar Chart
          SizedBox(
            height: 150.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final weight = weeklyWeights[index];
                final bool isToday = index == 6;
                // Normalize height between 20% and 100% of container height based on data
                final double range = maxWeight - minWeight + 2; // buffer
                final double normalized = (weight - (minWeight - 1)) / range;
                final List<String> days = [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun'
                ];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Tooltip label for today
                    if (isToday)
                      Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: MyColor.textColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          weight.toStringAsFixed(1),
                          style:
                              TextStyle(color: Colors.white, fontSize: 10.sp),
                        ),
                      ),

                    // The Bar
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 14.w,
                      height: (150.h * normalized).clamp(20.h, 150.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        gradient: isToday
                            ? LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: provider.activeGradient,
                              )
                            : LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  MyColor.inActiveColor.withOpacity(0.3),
                                  MyColor.inActiveColor.withOpacity(0.6)
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      days[index],
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isToday ? MyColor.textColor : MyColor.textThird,
                        fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
                      ),
                    )
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  // --- 2. Summary Grid ---
  Widget _buildSummaryGrid(ThemeData theme, OnboardProvider provider) {
    // Calculation mock logic
    double startWeight = 74.0; // Retrieve from provider in real app
    double lost = startWeight - provider.selectedWeight;
    double progress = lost / (startWeight - provider.selectedTargetWeight);

    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            theme,
            title: "Total Lost",
            value: lost.toStringAsFixed(1),
            unit: "kg",
            icon: Icons.monitor_weight_outlined,
            color: MyColor.vibrantPurple,
            iconBg: MyColor.vibrantPurple.withOpacity(0.1),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: _buildInfoCard(
            theme,
            title: "Goal Progress",
            value: "${(progress * 100).toInt()}",
            unit: "%",
            icon: Icons.flag_rounded,
            color: MyColor.energyOrange,
            iconBg: MyColor.energyOrange.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    ThemeData theme, {
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
    required Color iconBg,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24.r),
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
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22.w),
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 26.sp,
                    color: MyColor.textColor,
                  ),
                ),
                TextSpan(
                  text: " $unit",
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(title, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }

  // --- 3. BMI Visual Gauge ---
  Widget _buildBMIGauge(ThemeData theme, OnboardProvider provider) {
    // Normalizing BMI for the slider (approx range 15 to 40)
    double bmi = provider.bmi;
    double minBMI = 15.0;
    double maxBMI = 40.0;
    double percentage = ((bmi - minBMI) / (maxBMI - minBMI)).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("BMI Score", style: theme.textTheme.titleMedium),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: MyColor.skyPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  bmi.toStringAsFixed(1),
                  style: TextStyle(
                    color: MyColor.skyPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 25.h),
          // Custom Linear Gauge
          SizedBox(
            height: 45.h,
            child: Stack(
              children: [
                // 1. The Gradient Track
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 12.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF64B5F6), // Underweight
                          Color(0xFF81C784), // Normal
                          Color(0xFFFFB74D), // Overweight
                          Color(0xFFE57373), // Obese
                        ],
                        stops: [0.0, 0.4, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),
                // 2. The Indicator Thumb
                Align(
                  alignment: Alignment(
                      (percentage * 2) - 1.0, 0), // Convert 0..1 to -1..1
                  child: Container(
                    height: 24.h,
                    width: 24.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Center(
                      child: Container(
                        height: 10.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: MyColor.textColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("15.0", style: theme.textTheme.labelSmall),
              Text("Healthy",
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: MyColor.successGreen)),
              Text("40.0", style: theme.textTheme.labelSmall),
            ],
          )
        ],
      ),
    );
  }

  // --- 4. Transformation Comparison ---
  Widget _buildComparisonCard(ThemeData theme) {
    return SizedBox(
      height: 180.h,
      child: Row(
        children: [
          Expanded(
            child: _buildPhotoCard(
                theme: theme,
                label: "Jan 10",
                weight: "74.0 kg",
                // Using a placeholder image - replace with actual user data
                imageUrl:
                    "https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=400",
                isOld: true),
          ),
          Container(
            width: 30.w,
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: MyColor.shadowLight, blurRadius: 4)
                  ]),
              child: Icon(Icons.arrow_forward_rounded,
                  size: 14.w, color: MyColor.textThird),
            ),
          ),
          Expanded(
            child: _buildPhotoCard(
                theme: theme,
                label: "Today",
                weight: "72.5 kg",
                imageUrl:
                    "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=400",
                isOld: false),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCard({
    required ThemeData theme,
    required String label,
    required String weight,
    required String imageUrl,
    required bool isOld,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: theme.cardColor,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          // Darken the 'old' photo slightly to emphasize the 'new' one
          colorFilter: isOld
              ? ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.darken)
              : null,
        ),
        boxShadow: [
          BoxShadow(
            color: MyColor.shadowMedium,
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Stack(
        children: [
          // Gradient Overlay for text readability
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20.r)),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15.h,
            left: 15.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: Colors.white.withOpacity(0.1))),
                  child: Text(
                    label,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  weight,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.titleLarge),
        Icon(Icons.more_horiz_rounded, color: MyColor.textThird),
      ],
    );
  }
}
