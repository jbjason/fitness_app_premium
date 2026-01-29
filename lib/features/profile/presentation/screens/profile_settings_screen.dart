import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:provider/provider.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});
  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  // Mock State
  bool _isDark = false;
  bool _notifications = true;

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
          "Settings",
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
            SizedBox(height: 20.h),
            
            // 1. Premium Card
            _buildPremiumCard(theme, provider),
            SizedBox(height: 30.h),

            // 2. General Settings
            _buildSectionHeader(theme, "General"),
            SizedBox(height: 15.h),
            _buildSettingTile(
            theme:   theme,
              title: "Language",
              value: "English",
              icon: Icons.language_rounded,
              iconColor: Colors.blueAccent,
              onTap: () {},
            ),
            SizedBox(height: 15.h),
            _buildSettingTile(
             theme:  theme,
              title: "Unit System",
              value: "Metric (kg, cm)",
              icon: Icons.scale_rounded,
              iconColor: MyColor.fatOrange,
              onTap: () {},
            ),
            SizedBox(height: 15.h),
            _buildSwitchTile(
            theme:   theme,
              title: "Dark Mode",
              value: _isDark,
              icon: Icons.dark_mode_rounded,
              iconColor: Colors.indigo,
              onChanged: (v) => setState(() => _isDark = v),
            ),

            SizedBox(height: 25.h),

            // 3. Notifications & Support
            _buildSectionHeader(theme, "Preferences"),
            SizedBox(height: 15.h),
             _buildSwitchTile(
             theme:  theme,
              title: "Push Notifications",
              value: _notifications,
              icon: Icons.notifications_active_rounded,
              iconColor: MyColor.vibrantPurple,
              onChanged: (v) => setState(() => _notifications = v),
            ),
            SizedBox(height: 15.h),
            _buildSettingTile(
             theme:  theme,
              title: "Help & Support",
              value: "",
              icon: Icons.help_outline_rounded,
              iconColor: MyColor.mintFresh,
              onTap: () {},
            ),
            SizedBox(height: 15.h),
             _buildSettingTile(
             theme:  theme,
              title: "Privacy Policy",
              value: "",
              icon: Icons.privacy_tip_outlined,
              iconColor: MyColor.textThird,
              onTap: () {},
            ),

            SizedBox(height: 25.h),

             // 4. Danger Zone
            _buildLogoutButton(theme),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumCard(ThemeData theme, OnboardProvider provider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          colors: provider.activeGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: provider.activeGradient.last.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
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
            child: Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 28.w),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Go Premium",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Unlimited access to all features",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(Icons.arrow_forward_rounded, color: MyColor.vibrantPurple, size: 20.w),
          )
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

  Widget _buildSettingTile({
    required ThemeData theme,
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (value.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Text(
                  value,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: MyColor.textThird,
                  ),
                ),
              ),
            Icon(Icons.chevron_right_rounded, color: MyColor.textThird, size: 20.w),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required ThemeData theme,
    required String title,
    required bool value,
    required IconData icon,
    required Color iconColor,
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
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 22.w),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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

  Widget _buildLogoutButton(ThemeData theme) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColor.calorieRed.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: MyColor.calorieRed.withOpacity(0.3)),
        ),
        child: Center(
          child: Text(
            "Log Out",
            style: TextStyle(
              color: MyColor.calorieRed,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
