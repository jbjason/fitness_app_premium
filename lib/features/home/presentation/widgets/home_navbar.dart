import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeNavbar extends StatelessWidget {
  final int currentPage;
  final Function(int) onPageChange;

  const HomeNavbar({
    super.key,
    required this.currentPage,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    final activeGradient = MyColor.fitnessGradient;

    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
      child: SizedBox(
        height: 110.h,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70.h,
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: MyColor.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(0, Icons.home_rounded, "Home"),
                    _buildNavItem(1, Icons.bar_chart_rounded, "Report"),
                    SizedBox(width: 60.h),
                    _buildNavItem(3, Icons.calendar_month_rounded, "Schedule"),
                    _buildNavItem(4, Icons.person_rounded, "Profile"),
                  ],
                ),
              ),
            ),
      
            // 2. The Exotic Center FAB
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => onPageChange(2),
                  child: Container(
                    height: 65.w,
                    width: 65.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: activeGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: Colors.white, width: 4.h),
                      boxShadow: [
                        BoxShadow(
                          color: activeGradient.last.withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.fitness_center_rounded,
                        color: Colors.white,
                        size: 28.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = currentPage == index;
    final Color color = isSelected ? MyColor.vibrantPurple : MyColor.textThird;

    return GestureDetector(
      onTap: () => onPageChange(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26.w),
            SizedBox(height: 4.h),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              height: 5.w,
              width: 5.w,
              decoration: BoxDecoration(
                color: isSelected ? MyColor.vibrantPurple : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}