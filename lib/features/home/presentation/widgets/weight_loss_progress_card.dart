import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeightLossProgressCard extends StatelessWidget {
  final double currentWeight;
  final double targetWeight;
  final PlanLevel planLevel;
  final List<WeightLossProgress>? progressData;

  const WeightLossProgressCard({
    super.key,
    required this.currentWeight,
    required this.targetWeight,
    required this.planLevel,
    this.progressData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final levelColor = _getLevelColor(planLevel);
    final plan = WeightLossPlan.getPlanForLevel(planLevel);
    final weeksToTarget = WeightLossPlan.calculateWeeksToTarget(
      currentWeight,
      targetWeight,
      plan.weeklyWeightLoss,
    );
    final totalWeightToLose = currentWeight - targetWeight;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [levelColor.withOpacity(0.15), levelColor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: levelColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: levelColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.trending_down_rounded,
                  color: levelColor,
                  size: 24.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight Loss Progress',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _getLevelName(planLevel),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: levelColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Main Progress Stats
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: levelColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem(
                      'Current',
                      '${currentWeight.toStringAsFixed(1)} kg',
                      MyColor.textColor,
                    ),
                    Container(
                      width: 1,
                      height: 40.h,
                      color: MyColor.textThird.withOpacity(0.2),
                    ),
                    _buildStatItem(
                      'Target',
                      '${targetWeight.toStringAsFixed(1)} kg',
                      levelColor,
                    ),
                    Container(
                      width: 1,
                      height: 40.h,
                      color: MyColor.textThird.withOpacity(0.2),
                    ),
                    _buildStatItem(
                      'To Lose',
                      '${totalWeightToLose.toStringAsFixed(1)} kg',
                      Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          // Weekly Loss Info
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: levelColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month_rounded, color: levelColor, size: 20.w),
                SizedBox(width: 10.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: MyColor.textColor,
                      ),
                      children: [
                        const TextSpan(text: 'Weekly loss: '),
                        TextSpan(
                          text: '${plan.weeklyWeightLoss.toStringAsFixed(2)} kg',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: levelColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          // Target Duration
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.flag_rounded, color: levelColor, size: 20.w),
                SizedBox(width: 10.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: MyColor.textColor,
                      ),
                      children: [
                        const TextSpan(text: 'Target achieved in: '),
                        TextSpan(
                          text: '$weeksToTarget weeks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: levelColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          // Calorie Deficit Info
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyColor.vibrantPurple.withOpacity(0.1),
                  MyColor.vibrantPurple.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.local_fire_department_rounded,
                    color: MyColor.vibrantPurple, size: 20.w),
                SizedBox(width: 10.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: MyColor.textColor,
                      ),
                      children: [
                        const TextSpan(text: 'Daily calorie deficit: '),
                        TextSpan(
                          text: '${plan.dailyCalorieDeficit.toInt()} kcal',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColor.vibrantPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: MyColor.textThird,
          ),
        ),
      ],
    );
  }

  Color _getLevelColor(PlanLevel level) {
    switch (level) {
      case PlanLevel.beginner:
        return Colors.green;
      case PlanLevel.intermediate:
        return Colors.orange;
      case PlanLevel.advanced:
        return Colors.red;
    }
  }

  String _getLevelName(PlanLevel level) {
    switch (level) {
      case PlanLevel.beginner:
        return '🟢 Beginner Plan';
      case PlanLevel.intermediate:
        return '🟡 Intermediate Plan';
      case PlanLevel.advanced:
        return '🔴 Advanced Plan';
    }
  }
}
