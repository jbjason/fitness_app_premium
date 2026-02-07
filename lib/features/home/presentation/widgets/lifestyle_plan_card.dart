import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LifestylePlanCard extends StatelessWidget {
  final LifestylePlan lifestylePlan;
  final PlanLevel planLevel;

  const LifestylePlanCard({
    super.key,
    required this.lifestylePlan,
    required this.planLevel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final levelColor = _getLevelColor(planLevel);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: levelColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '🧠',
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lifestyle & Habits',
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
          _buildHabitItem(
            '😴 Sleep',
            '${lifestylePlan.sleepHours} hours',
            Icons.bedtime_rounded,
            levelColor,
          ),
          SizedBox(height: 12.h),
          _buildHabitItem(
            '👟 Daily Steps',
            '${_formatSteps(lifestylePlan.dailySteps)} steps',
            Icons.directions_walk_rounded,
            levelColor,
          ),
          SizedBox(height: 12.h),
          _buildHabitItem(
            '🍔 Cheat Meals',
            lifestylePlan.cheatMealsPerWeek == 0
                ? 'None'
                : '${lifestylePlan.cheatMealsPerWeek} per week',
            Icons.restaurant_rounded,
            levelColor,
          ),
          SizedBox(height: 12.h),
          _buildHabitItem(
            '📊 Progress Check',
            'Every 7 days',
            Icons.analytics_rounded,
            levelColor,
          ),
        ],
      ),
    );
  }

  Widget _buildHabitItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              size: 18.w,
              color: color,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: MyColor.textColor,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: MyColor.textThird,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatSteps(int steps) {
    if (steps >= 1000) {
      return '${(steps / 1000).toStringAsFixed(1)}k';
    }
    return steps.toString();
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
