import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Color iconColor;
  final VoidCallback onTap;
  final bool isDestructive;

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    required this.iconColor,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: MyColor.cardBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                // Icon Box
                Container(
                  height: 40.w,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? MyColor.calorieRed.withOpacity(0.1)
                        : iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    icon,
                    color: isDestructive ? MyColor.calorieRed : iconColor,
                    size: 20.w,
                  ),
                ),
                SizedBox(width: 16.w),
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isDestructive
                          ? MyColor.calorieRed
                          : MyColor.textColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                // Trailing
                trailing ??
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.w,
                      color: MyColor.textThird.withOpacity(0.5),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
