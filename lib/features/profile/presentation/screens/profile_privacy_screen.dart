import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:provider/provider.dart';

class ProfilePrivacyScreen extends StatefulWidget {
  const ProfilePrivacyScreen({super.key});
  @override
  State<ProfilePrivacyScreen> createState() => _ProfilePrivacyScreenState();
}

class _ProfilePrivacyScreenState extends State<ProfilePrivacyScreen> {
  final List<Map<String, String>> _policies = [
    {
      'title': '1. Information We Collect',
      'content':
          'We collect information you provide directly to us, such as when you create an account, update your profile, or use our premium features. This includes your name, email, physical stats (height, weight, gender), and fitness goals. We also collect data automatically when you use the app, such as device information and usage logs.'
    },
    {
      'title': '2. How We Use Information',
      'content':
          'We use the information we collect to provide, maintain, and improve our services, to develop new ones, and to protect us and our users. Specifically, we use your physical stats to generate personalized workout and meal plans. We may also use your email to send you updates, newsletters, and promotional materials.'
    },
    {
      'title': '3. Data Security',
      'content':
          'We take reasonable measures to help protect information about you from loss, theft, misuse and unauthorized access, disclosure, alteration and destruction. Your personal health data is encrypted and stored securely on our servers.'
    },
    {
      'title': '4. Sharing of Information',
      'content':
          'We do not share your personal information with third parties except as described in this policy. We may share your information with third-party vendors, consultants, and other service providers who need access to such information to carry out work on our behalf.'
    },
    {
      'title': '5. Your Rights & Choices',
      'content':
          'You can update your profile information at any time through the settings in the application. You may also request the deletion of your account and associated data by contacting our support team. You may opt out of receiving promotional communications from us by following the instructions in those communications.'
    },
  ];

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
          "Privacy Policy",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            // Header Info
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: MyColor.vibrantPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                    color: MyColor.vibrantPurple.withOpacity(0.2), width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: MyColor.vibrantPurple, size: 24.w),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Updated",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: MyColor.vibrantPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "September 24, 2024",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: MyColor.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              "Please read our privacy policy carefully to get a clear understanding of how we collect, use, protect or otherwise handle your Personally Identifiable Information.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: MyColor.textThird,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),

            // Policy List
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _policies.length,
              separatorBuilder: (c, i) => SizedBox(height: 15.h),
              itemBuilder: (context, index) {
                return _buildPolicyCard(theme, provider, _policies[index]);
              },
            ),
            
            SizedBox(height: 30.h),
            
            // Contact Support Footer
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Have questions? Contact Support",
                  style: TextStyle(
                    color: MyColor.vibrantPurple,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyCard(
      ThemeData theme, OnboardProvider provider, Map<String, String> policy) {
    return Container(
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: MyColor.vibrantPurple,
          collapsedIconColor: MyColor.textThird,
          tilePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
          childrenPadding:
              EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          title: Text(
            policy['title']!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
          children: [
            Text(
              policy['content']!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: MyColor.textThird,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
