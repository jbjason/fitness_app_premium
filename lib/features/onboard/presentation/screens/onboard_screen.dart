import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard1_gender.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard2_plan.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard3_height.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard4_weight.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard5_target_weight.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard6_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});
  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late PageController _controller;
  int _selectedPage = 0;
  final List<Widget> _pages = [
    const Onboard1Gender(),
    const Onboard2Plan(),
    const Onboard3Height(),
    const Onboard4Weight(),
    const Onboard5TargetWeight(),
    const Onboard6Complete(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controller
    _controller = PageController(keepPage: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handles forward and backward navigation logic
  void _onPageChange(bool isForward) {
    // Prevent out of bounds
    if (isForward && _selectedPage == _pages.length - 1) return;
    if (!isForward && _selectedPage == 0) return;

    final int nextPage = isForward ? _selectedPage + 1 : _selectedPage - 1;

    // Update state immediately for UI responsiveness
    setState(() => _selectedPage = nextPage);
    _controller.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic, // Smoother curve
    );
  }

  @override
  Widget build(BuildContext context) {
    // Constraint: "in first page add some padding to adjust rest of the page"
    // We add extra top padding if we are on the first page.

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header Section (Progress & Back Button)
            _buildCustomHeader(),

            // 2. Main Page Content
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable swipe to ensure flow control
                itemCount: _pages.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: _pages[i],
                  );
                },
              ),
            ),

            // 3. Bottom Action Section
            if (_selectedPage != _pages.length - 1) _buildNextButton(),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Back Button
          Row(
            children: [
              if (_selectedPage != 0)
                IconButton(
                  onPressed: () => _onPageChange(false),
                  // Enhanced icon styling
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: MyColor.textColor,
                    size: 24.sp,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    padding: EdgeInsets.all(8.w),
                  ),
                )
              else
                SizedBox(width: 40.w, height: 43.h),
            ],
          ),

          SizedBox(height: 15.h),

          // Title Row
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "0${_selectedPage + 1} ",
                  style: TextStyle(
                    color: MyColor.accentColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 24.sp,
                    fontFamily: 'Roboto',
                  ),
                ),
                TextSpan(
                  text: "GOAL & FOCUS",
                  style: TextStyle(
                    color: MyColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 15.h),

          // Enhanced Animated Progress Bar
          SizedBox(
            height: 6.h,
            child: Row(
              children: List.generate(_pages.length, (index) {
                bool isActive = index == _selectedPage;
                bool isPassed = index < _selectedPage;
                return Expanded(
                  flex: isActive ? 3 : 1,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      color: isActive
                          ? MyColor.accentColor
                          : (isPassed
                              ? MyColor.accentColor.withOpacity(0.5)
                              : Colors.grey[200]),
                      borderRadius: BorderRadius.circular(4.r),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: MyColor.accentColor.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _onPageChange(true),
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.accentColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: MyColor.accentColor.withOpacity(0.4),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          "Next",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
