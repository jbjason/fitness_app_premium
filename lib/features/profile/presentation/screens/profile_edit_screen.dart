import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: "Sarah Alexa");
  final TextEditingController _emailController =
      TextEditingController(text: "sarah.alexa@email.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "+1 234 567 890");

  // Mock state for physical stats
  final int _age = 24;
  final double _weight = 72.5;
  final double _height = 168.0;
  int _genderIndex = 1; // 0: Male, 1: Female

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
          "Edit Profile",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save logic here
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(
                color: MyColor.vibrantPurple,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // 1. Profile Picture
            _buildProfileImage(provider),
            SizedBox(height: 30.h),

            // 2. Personal Information
            _buildSectionTitle(theme, "Personal Details"),
            SizedBox(height: 15.h),
            _buildTextField(theme, "Full Name", _nameController,
                Icons.person_outline_rounded),
            SizedBox(height: 15.h),
            _buildTextField(
                theme, "Email", _emailController, Icons.email_outlined),
            SizedBox(height: 15.h),
            _buildTextField(
                theme, "Phone", _phoneController, Icons.phone_outlined),

            SizedBox(height: 25.h),

            // 3. Physical Stats
            _buildSectionTitle(theme, "Physical Stats"),
            SizedBox(height: 15.h),
            _buildGenderSelector(theme, provider),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(child: _buildStatCard(theme, "Age", "$_age", "yo")),
                SizedBox(width: 15.w),
                Expanded(
                    child: _buildStatCard(theme, "Weight", "$_weight", "kg")),
                SizedBox(width: 15.w),
                Expanded(
                    child: _buildStatCard(
                        theme, "Height", "${_height.toInt()}", "cm")),
              ],
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(OnboardProvider provider) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.w),
              boxShadow: [
                BoxShadow(
                  color: MyColor.shadowMedium,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: CircleAvatar(
              radius: 55.r,
              backgroundImage: const NetworkImage(
                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=300",
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4.w,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: provider.activeGradient),
                border: Border.all(color: Colors.white, width: 2.w),
              ),
              child: Icon(Icons.camera_alt_rounded,
                  color: Colors.white, size: 18.w),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: MyColor.textColor,
        ),
      ),
    );
  }

  Widget _buildTextField(ThemeData theme, String label,
      TextEditingController controller, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: theme.textTheme.bodySmall,
          prefixIcon: Icon(icon, color: MyColor.textThird, size: 22.w),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        ),
      ),
    );
  }

  Widget _buildGenderSelector(ThemeData theme, OnboardProvider provider) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
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
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _genderIndex = 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: _genderIndex == 0 ? null : Colors.transparent,
                  gradient: _genderIndex == 0
                      ? LinearGradient(colors: provider.activeGradient)
                      : null,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Male",
                  style: TextStyle(
                    color: _genderIndex == 0 ? Colors.white : MyColor.textThird,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _genderIndex = 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: _genderIndex == 1 ? null : Colors.transparent,
                  gradient: _genderIndex == 1
                      ? LinearGradient(colors: provider.activeGradient)
                      : null,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Female",
                  style: TextStyle(
                    color: _genderIndex == 1 ? Colors.white : MyColor.textThird,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      ThemeData theme, String label, String value, String unit) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
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
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " $unit",
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 10.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: MyColor.textThird,
            ),
          ),
        ],
      ),
    );
  }
}
