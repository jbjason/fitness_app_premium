import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:provider/provider.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  // Mock State for toggles
  bool _wakeUp = true;
  bool _gym = true;
  bool _breakfast = false;
  bool _lunch = true;
  bool _dinner = true;
  bool _bedtime = true;
  bool _hydration = true;

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
          "Daily Reminders",
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
              Icons.notifications_active_rounded,
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
            SizedBox(height: 15.h),

            // --- Morning Routine ---
            _buildSectionHeader(theme, "Morning Routine"),
            SizedBox(height: 15.h),
            _buildReminderCard(
              theme,
              title: "Wake Up",
              time: "06:00 AM",
              icon: Icons.wb_sunny_rounded,
              color: Colors.orange,
              value: _wakeUp,
              onChanged: (v) => setState(() => _wakeUp = v),
            ),
            SizedBox(height: 15.h),
            _buildReminderCard(
              theme,
              title: "Morning Workout",
              time: "07:30 AM",
              icon: Icons.fitness_center_rounded,
              color: MyColor.vibrantPurple,
              value: _gym,
              onChanged: (v) => setState(() => _gym = v),
            ),

            SizedBox(height: 25.h),

            // --- Meals ---
            _buildSectionHeader(theme, "Meals"),
            SizedBox(height: 15.h),
            _buildReminderCard(
              theme,
              title: "Breakfast",
              time: "08:30 AM",
              icon: Icons.free_breakfast_rounded,
              color: MyColor.fatOrange,
              value: _breakfast,
              onChanged: (v) => setState(() => _breakfast = v),
            ),
            SizedBox(height: 15.h),
            _buildReminderCard(
              theme,
              title: "Lunch",
              time: "01:00 PM",
              icon: Icons.lunch_dining_rounded,
              color: MyColor.mintFresh,
              value: _lunch,
              onChanged: (v) => setState(() => _lunch = v),
            ),
            SizedBox(height: 15.h),
            _buildReminderCard(
              theme,
              title: "Dinner",
              time: "07:00 PM",
              icon: Icons.dinner_dining_rounded,
              color: MyColor.calorieRed,
              value: _dinner,
              onChanged: (v) => setState(() => _dinner = v),
            ),

            SizedBox(height: 25.h),

            // --- Health & Sleep ---
            _buildSectionHeader(theme, "Health & Sleep"),
            SizedBox(height: 15.h),
            _buildReminderCard(
              theme,
              title: "Drink Water",
              time: "Every 1 hour",
              icon: Icons.water_drop_rounded,
              color: MyColor.waterCyan,
              value: _hydration,
              onChanged: (v) => setState(() => _hydration = v),
            ),
            SizedBox(height: 15.h),
            _buildReminderCard(
              theme,
              title: "Bedtime",
              time: "10:30 PM",
              icon: Icons.bedtime_rounded,
              color: MyColor.logGradient2Color,
              value: _bedtime,
              onChanged: (v) => setState(() => _bedtime = v),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        label: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            gradient: LinearGradient(
              colors: provider.activeGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: provider.activeGradient.last.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.add, color: Colors.white, size: 20.w),
              SizedBox(width: 8.w),
              Text(
                "New Reminder",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 18.h,
          decoration: BoxDecoration(
            color: MyColor.vibrantPurple,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 10.w),
        Text(title, style: theme.textTheme.titleMedium),
      ],
    );
  }

  Widget _buildReminderCard(
    ThemeData theme, {
    required String title,
    required String time,
    required IconData icon,
    required Color color,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
          // Icon
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: color, size: 24.w),
          ),
          SizedBox(width: 15.w),
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: MyColor.vibrantPurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Toggle
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              activeTrackColor: MyColor.vibrantPurple,
              value: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
