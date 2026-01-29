// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fitness_app_premium/features/auth/presentation/screens/auth_screen.dart';
import 'package:fitness_app_premium/features/profile/presentation/widgets/profile_header.dart';
import 'package:fitness_app_premium/features/profile/presentation/widgets/profile_listitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.homeBodyColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 120.h),
        child: Column(
          children: [
            const ProfileHeader(),
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildSectionTitle("General"),
                  SizedBox(height: 10.h),
                  ProfileListItem(
                    icon: Icons.person_outline_rounded,
                    title: 'Edit Profile',
                    iconColor: MyColor.vibrantPurple,
                    onTap: () {},
                  ),
                  ProfileListItem(
                    icon: Icons.notifications_none_rounded,
                    title: 'Daily Reminder',
                    iconColor: MyColor.energyOrange,
                    onTap: () {},
                  ),
                  ProfileListItem(
                    icon: Icons.language_rounded,
                    title: 'Language',
                    trailing: Text("English",
                        style: TextStyle(
                            color: MyColor.textThird, fontSize: 12.sp)),
                    iconColor: MyColor.skyPrimary,
                    onTap: () {},
                  ),
                  SizedBox(height: 25.h),
                  _buildSectionTitle("Preferences"),
                  SizedBox(height: 10.h),
                  ProfileListItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    iconColor: MyColor.textThird,
                    onTap: () {},
                  ),
                  ProfileListItem(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy Policy",
                    iconColor: MyColor.textThird,
                    onTap: () {},
                  ),
                  SizedBox(height: 25.h),
                  ProfileListItem(
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    iconColor: MyColor.calorieRed,
                    isDestructive: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AuthScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: MyColor.textThird,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
