import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrinkChartCard extends StatelessWidget {
  final DrinkPlan drinkPlan;
  final PlanLevel planLevel;

  const DrinkChartCard({
    super.key,
    required this.drinkPlan,
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
                  '🥤',
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Drink Chart',
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
          _buildDrinkItem('💧 Water', '${drinkPlan.waterLiters} L', levelColor),
          SizedBox(height: 12.h),
          _buildDrinkItem('🍵 Green Tea', drinkPlan.greenTea, levelColor),
          SizedBox(height: 12.h),
          _buildDrinkItem('☕ Black Coffee', drinkPlan.blackCoffee, levelColor),
          SizedBox(height: 12.h),
          _buildDrinkItem('✨ Optional', drinkPlan.optional, levelColor, isOptional: true),
        ],
      ),
    );
  }

  Widget _buildDrinkItem(String label, String value, Color color, {bool isOptional = false}) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: isOptional ? color.withOpacity(0.3) : color,
            borderRadius: BorderRadius.circular(2.r),
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
                  fontSize: 14.sp,
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
