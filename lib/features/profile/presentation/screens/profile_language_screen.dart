import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:provider/provider.dart';

class ProfileLanguageScreen extends StatefulWidget {
  const ProfileLanguageScreen({super.key});
  @override
  State<ProfileLanguageScreen> createState() => _ProfileLanguageScreenState();
}

class _ProfileLanguageScreenState extends State<ProfileLanguageScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _languages = [
    {'name': 'English (US)', 'flag': '🇺🇸', 'native': 'English'},
    {'name': 'English (UK)', 'flag': '🇬🇧', 'native': 'English'},
    {'name': 'Spanish', 'flag': '🇪🇸', 'native': 'Español'},
    {'name': 'French', 'flag': '🇫🇷', 'native': 'Français'},
    {'name': 'German', 'flag': '🇩🇪', 'native': 'Deutsch'},
    {'name': 'Italian', 'flag': '🇮🇹', 'native': 'Italiano'},
    {'name': 'Portuguese', 'flag': '🇵🇹', 'native': 'Português'},
    {'name': 'Russian', 'flag': '🇷🇺', 'native': 'Русский'},
    {'name': 'Japanese', 'flag': '🇯🇵', 'native': '日本語'},
    {'name': 'Korean', 'flag': '🇰🇷', 'native': '한국어'},
    {'name': 'Chinese', 'flag': '🇨🇳', 'native': '中文'},
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
          "Language",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
           TextButton(
            onPressed: () {
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
      body: Column(
        children: [
          SizedBox(height: 10.h),
          // 1. Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildSearchBar(theme),
          ),
          SizedBox(height: 20.h),
          
          // 2. Language List
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              physics: const BouncingScrollPhysics(),
              itemCount: _languages.length,
              separatorBuilder: (c, i) => SizedBox(height: 15.h),
              itemBuilder: (context, index) {
                final lang = _languages[index];
                final isSelected = _selectedIndex == index;
                return _buildLanguageItem(
                  theme,
                  provider,
                  name: lang['name']!,
                  native: lang['native']!,
                  flag: lang['flag']!,
                  isSelected: isSelected,
                  onTap: () => setState(() => _selectedIndex = index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
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
        controller: _searchController,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: "Search language...",
          hintStyle: theme.textTheme.bodySmall?.copyWith(color: MyColor.textThird),
          prefixIcon: Icon(Icons.search_rounded, color: MyColor.textThird, size: 22.w),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildLanguageItem(
    ThemeData theme,
    OnboardProvider provider, {
    required String name,
    required String native,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected 
            ? Border.all(color: MyColor.vibrantPurple, width: 1.5.w)
            : Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? MyColor.vibrantPurple.withOpacity(0.15) 
                  : MyColor.shadowLight,
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            // Flag
            Container(
              width: 40.w,
              height: 40.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: MyColor.homeBodyColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(flag, style: TextStyle(fontSize: 24.sp)),
            ),
            SizedBox(width: 15.w),
            // Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected ? MyColor.vibrantPurple : MyColor.textColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    native,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: MyColor.textThird,
                    ),
                  ),
                ],
              ),
            ),
            // Selection Indicator
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected 
                    ? LinearGradient(colors: provider.activeGradient)
                    : null,
                border: Border.all(
                  color: isSelected ? Colors.transparent : MyColor.inActiveColor,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 14.w)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
