import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfilePremiumScreen extends StatelessWidget {
  const ProfilePremiumScreen({super.key});

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
          "Premium",
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
            _buildSectionHeader(theme, "Choose a plan"),
            SizedBox(height: 15.h),
            _buildPlanCard(
              theme: theme,
              provider: provider,
              title: "Monthly",
              price: "\$9.99",
              subtitle: "Billed monthly",
              highlight: false,
            ),
            SizedBox(height: 12.h),
            _buildPlanCard(
              theme: theme,
              provider: provider,
              title: "Annual",
              price: "\$79.99",
              subtitle: "Save 33%",
              highlight: true,
            ),
            SizedBox(height: 25.h),
            _buildSectionHeader(theme, "Premium benefits"),
            SizedBox(height: 15.h),
            _buildBenefitItem(
              theme: theme,
              icon: Icons.auto_awesome_rounded,
              color: MyColor.vibrantPurple,
              title: "Smart meal plans",
              subtitle: "Personalized to your goals and taste",
            ),
            SizedBox(height: 12.h),
            _buildBenefitItem(
              theme: theme,
              icon: Icons.fitness_center_rounded,
              color: MyColor.stepsGreen,
              title: "Workout programs",
              subtitle: "Progressive routines for all levels",
            ),
            SizedBox(height: 12.h),
            _buildBenefitItem(
              theme: theme,
              icon: Icons.insights_rounded,
              color: MyColor.fatOrange,
              title: "Advanced insights",
              subtitle: "Trends, streaks, and milestones",
            ),
            SizedBox(height: 12.h),
            _buildBenefitItem(
              theme: theme,
              icon: Icons.notifications_active_rounded,
              color: MyColor.waterCyan,
              title: "Smart reminders",
              subtitle: "Stay on track with tailored alerts",
            ),
            SizedBox(height: 25.h),
            _buildCtaCard(theme, provider),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(ThemeData theme, OnboardProvider provider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
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
            blurRadius: 14,
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
            child: Icon(Icons.workspace_premium_rounded,
                color: Colors.white, size: 26.w),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upgrade your results",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Get full access to plans and coaching tools.",
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

  Widget _buildPlanCard({
    required ThemeData theme,
    required OnboardProvider provider,
    required String title,
    required String price,
    required String subtitle,
    required bool highlight,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: highlight
              ? provider.activeGradient.last
              : Colors.transparent,
          width: highlight ? 1.5 : 1,
        ),
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
              color: highlight
                  ? provider.activeGradient.last.withOpacity(0.1)
                  : MyColor.vibrantPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.stars_rounded,
                color: highlight
                    ? provider.activeGradient.last
                    : MyColor.vibrantPurple,
                size: 22.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
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
          Text(
            price,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: highlight
                  ? provider.activeGradient.last
                  : MyColor.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem({
    required ThemeData theme,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
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
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 22.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
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
        ],
      ),
    );
  }

  Widget _buildCtaCard(ThemeData theme, OnboardProvider provider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
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
      child: Column(
        children: [
          Text(
            "Start your 7-day free trial",
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Cancel anytime. No commitment.",
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 14.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: MyColor.vibrantPurple,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              "Continue",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: MyColor.vibrantPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
