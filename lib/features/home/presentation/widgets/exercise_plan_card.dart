import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExercisePlanCard extends StatelessWidget {
  final ExercisePlan exercisePlan;
  final PlanLevel planLevel;

  const ExercisePlanCard({
    super.key,
    required this.exercisePlan,
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
                  '🏋️',
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exercise Plan',
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
          SizedBox(height: 15.h),
          // Duration Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [levelColor.withOpacity(0.2), levelColor.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer_outlined, size: 16.w, color: levelColor),
                SizedBox(width: 6.w),
                Text(
                  exercisePlan.duration,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: levelColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          // Activities List
          ...exercisePlan.activities.asMap().entries.map((entry) {
            final index = entry.key;
            final activity = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: index == exercisePlan.activities.length - 1 ? 0 : 10.h),
              child: _buildActivityItem(activity, levelColor),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String activity, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_rounded,
            size: 16.w,
            color: color,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            activity,
            style: TextStyle(
              fontSize: 13.sp,
              color: MyColor.textColor,
              fontWeight: FontWeight.w500,
            ),
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
