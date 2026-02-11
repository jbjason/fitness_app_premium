import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_enum.dart';
import 'package:fitness_app_premium/features/auth/presentation/screens/auth_screen.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_edit_screen.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_language_screen.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_notifications_screen.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_privacy_screen.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_about_us_screen.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_premium_screen.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<OnboardProvider>();
    return Scaffold(
      backgroundColor: MyColor.homeBodyColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Center(
                child: Text("Profile",
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold))),
            SizedBox(height: 30.h),
            // Avatar
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: MyColor.shadowLight,
                              blurRadius: 10,
                              offset: Offset(0, 5))
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50.r,
                        backgroundImage: const NetworkImage(
                            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=200"),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: MyColor.vibrantPurple,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.w),
                        ),
                        child:
                            Icon(Icons.edit, color: Colors.white, size: 14.w),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15.h),
                Text("Sarah Alexa",
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 5.h),
                Text(
                  "${provider.selectedGender == 1 ? 'Female' : 'Male'} • ${provider.selectedWeight} kg",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: MyColor.textThird),
                )
              ],
            ),
            SizedBox(height: 30.h),
            // Premium Banner
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfilePremiumScreen(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                      colors: provider.activeGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                        color: provider.activeGradient.last.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5))
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Icon(Icons.workspace_premium_rounded,
                          color: Colors.white, size: 24.w),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Upgrade to Premium",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp)),
                          SizedBox(height: 2.h),
                          Text("Unlock all features",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12.sp)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.white, size: 20.w)
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),
            // Settings List
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
                child: Text("General",
                    style: TextStyle(
                        color: MyColor.textThird,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            _buildProfileItem(
                context: context,
                type: ProfileItemType.editProfile,
                icon: Icons.person_outline_rounded,
                label: "Edit Profile"),
            SizedBox(height: 10.h),
            _buildProfileItem(
                context: context,
                type: ProfileItemType.notifications,
                icon: Icons.notifications_none_rounded,
                label: "Notifications"),
            SizedBox(height: 10.h),
            _buildProfileItem(
                context: context,
                type: ProfileItemType.privacy,
                icon: Icons.security_rounded,
                label: "Privacy & Security"),

            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
                child: Text("Other",
                    style: TextStyle(
                        color: MyColor.textThird,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            _buildProfileItem(
                context: context,
                type: ProfileItemType.settings,
                icon: Icons.settings_outlined,
                label: "App Settings"),
            SizedBox(height: 10.h),
            _buildProfileItem(
              context: context,
              type: ProfileItemType.aboutUs,
              icon: Icons.info_outline_rounded,
              label: "About Us"),
            SizedBox(height: 20.h),
            // Log out
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                        color: MyColor.shadowLight,
                        blurRadius: 5,
                        offset: const Offset(0, 2))
                  ]),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        color: MyColor.calorieRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Icon(Icons.logout_rounded,
                        color: MyColor.calorieRed, size: 20.w),
                  ),
                  SizedBox(width: 15.w),
                  Text("Log Out",
                      style: TextStyle(
                          color: MyColor.calorieRed,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp)),
                ],
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
      {required ProfileItemType type,
      required BuildContext context,
      required IconData icon,
      required String label}) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        final route = switch (type) {
          ProfileItemType.editProfile => ProfileEditScreen(),
          ProfileItemType.notifications =>
            const ProfileNotificationsScreen(),
          ProfileItemType.privacy => ProfilePrivacyScreen(),
          ProfileItemType.language => ProfileLanguageScreen(),
          ProfileItemType.aboutUs => const ProfileAboutUsScreen(),
          ProfileItemType.settings => ProfileSettingsScreen(),
          ProfileItemType.logout => AuthScreen(),
        };
        if (type == ProfileItemType.logout) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => AuthScreen()),
            (route) => false,
          );
          return;
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => route),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                  color: MyColor.shadowLight,
                  blurRadius: 5,
                  offset: const Offset(0, 2))
            ]),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  color: MyColor.homeBodyColor,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Icon(icon, color: MyColor.textColor, size: 20.w),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(label,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp)),
            ),
            Icon(Icons.chevron_right, color: MyColor.inActiveColor, size: 20.w)
          ],
        ),
      ),
    );
  }
}
