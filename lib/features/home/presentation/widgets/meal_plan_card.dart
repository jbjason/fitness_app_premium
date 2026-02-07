import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealPlanCard extends StatelessWidget {
  final MealPlan mealPlan;
  final PlanLevel planLevel;

  const MealPlanCard({
    super.key,
    required this.mealPlan,
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
                  '🥗',
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meal Plan',
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
          _buildMealItem('🌅 Breakfast', mealPlan.breakfast, levelColor),
          SizedBox(height: 12.h),
          _buildMealItem('☀️ Lunch', mealPlan.lunch, levelColor),
          SizedBox(height: 12.h),
          _buildMealItem('🌙 Dinner', mealPlan.dinner, levelColor),
          SizedBox(height: 12.h),
          _buildMealItem('🍎 Snacks', mealPlan.snacks, levelColor),
        ],
      ),
    );
  }

  Widget _buildMealItem(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.restaurant_menu_rounded,
              size: 16.w,
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
                    fontWeight: FontWeight.w700,
                    color: MyColor.textColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: MyColor.textThird,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
