import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileNotificationsScreen extends StatefulWidget {
  const ProfileNotificationsScreen({super.key});

  @override
  State<ProfileNotificationsScreen> createState() =>
      _ProfileNotificationsScreenState();
}

class _ProfileNotificationsScreenState
    extends State<ProfileNotificationsScreen> {
  bool _workoutReminders = true;
  bool _mealReminders = true;
  bool _waterReminders = true;
  bool _progressUpdates = true;
  bool _promotions = false;
  bool _sound = true;
  bool _vibration = true;

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              size: 20.w, color: MyColor.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notifications",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            _buildHeroCard(theme, provider),
            SizedBox(height: 25.h),
            _buildSectionHeader(theme, "Reminders"),
            SizedBox(height: 15.h),
            _buildSwitchTile(
              theme: theme,
              title: "Workout Reminders",
              subtitle: "Get notified before your session",
              value: _workoutReminders,
              icon: Icons.fitness_center_rounded,
              iconColor: MyColor.vibrantPurple,
              onChanged: (v) => setState(() => _workoutReminders = v),
            ),
            SizedBox(height: 12.h),
            _buildSwitchTile(
              theme: theme,
              title: "Meal Reminders",
              subtitle: "Never miss a planned meal",
              value: _mealReminders,
              icon: Icons.restaurant_menu_rounded,
              iconColor: MyColor.fatOrange,
              onChanged: (v) => setState(() => _mealReminders = v),
            ),
            SizedBox(height: 12.h),
            _buildSwitchTile(
              theme: theme,
              title: "Water Reminders",
              subtitle: "Stay hydrated throughout the day",
              value: _waterReminders,
              icon: Icons.water_drop_rounded,
              iconColor: MyColor.waterCyan,
              onChanged: (v) => setState(() => _waterReminders = v),
            ),
            SizedBox(height: 25.h),
            _buildSectionHeader(theme, "Updates"),
            SizedBox(height: 15.h),
            _buildSwitchTile(
              theme: theme,
              title: "Progress Updates",
              subtitle: "Weekly insights and milestones",
              value: _progressUpdates,
              icon: Icons.insights_rounded,
              iconColor: MyColor.stepsGreen,
              onChanged: (v) => setState(() => _progressUpdates = v),
            ),
            SizedBox(height: 12.h),
            _buildSwitchTile(
              theme: theme,
              title: "Promotions",
              subtitle: "New features and offers",
              value: _promotions,
              icon: Icons.local_offer_rounded,
              iconColor: MyColor.vibrantPink,
              onChanged: (v) => setState(() => _promotions = v),
            ),
            SizedBox(height: 25.h),
            _buildSectionHeader(theme, "Sound & Haptics"),
            SizedBox(height: 15.h),
            _buildSwitchTile(
              theme: theme,
              title: "Sound",
              subtitle: "Play a short sound",
              value: _sound,
              icon: Icons.volume_up_rounded,
              iconColor: Colors.blueAccent,
              onChanged: (v) => setState(() => _sound = v),
            ),
            SizedBox(height: 12.h),
            _buildSwitchTile(
              theme: theme,
              title: "Vibration",
              subtitle: "Gentle haptic alerts",
              value: _vibration,
              icon: Icons.vibration_rounded,
              iconColor: Colors.deepPurpleAccent,
              onChanged: (v) => setState(() => _vibration = v),
            ),
            SizedBox(height: 25.h),
            _buildSectionHeader(theme, "Quiet Hours"),
            SizedBox(height: 15.h),
            _buildQuietHoursCard(theme),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(ThemeData theme, OnboardProvider provider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        gradient: LinearGradient(
          colors: provider.activeGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: provider.activeGradient.last.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.notifications_active_rounded,
                color: Colors.white, size: 26.w),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stay on track",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Choose alerts that help you hit your goals.",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildSwitchTile({
    required ThemeData theme,
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required Color iconColor,
    required ValueChanged<bool> onChanged,
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
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 22.w),
          ),
          SizedBox(width: 12.w),
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
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: MyColor.textThird,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: MyColor.vibrantPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildQuietHoursCard(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: MyColor.vibrantPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.nights_stay_rounded,
                color: MyColor.vibrantPurple, size: 22.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Do not disturb",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "10:00 PM - 7:00 AM",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: MyColor.textThird,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded,
              color: MyColor.textThird, size: 20.w),
        ],
      ),
    );
  }
}
