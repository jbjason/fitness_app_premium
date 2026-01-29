import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // Mock state for selected date (2 = Wednesday/14)
  int _selectedDateIndex = 2;

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
        title: Text(
          "Schedule",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20.w),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: theme.cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: MyColor.shadowLight,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Icon(
              Icons.more_horiz_rounded,
              color: MyColor.textThird,
              size: 20.w,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15.h),
          // 1. Calendar Date Selector
          _buildCalendarStrip(theme, provider),
          SizedBox(height: 10.h),
          // 2. Timeline List
          Expanded(
            child: _buildTimelineList(theme, provider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: provider.activeGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: provider.activeGradient.last.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Icon(Icons.add, color: Colors.white, size: 28.w),
        ),
      ),
    );
  }

  // --- 1. Calendar Strip ---
  Widget _buildCalendarStrip(ThemeData theme, OnboardProvider provider) {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final dates = ["12", "13", "14", "15", "16", "17", "18"];

    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedDateIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedDateIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 60.w,
              decoration: BoxDecoration(
                color: isSelected ? null : theme.cardColor,
                gradient: isSelected
                    ? LinearGradient(
                        colors: provider.activeGradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: provider.activeGradient.last.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  else
                    BoxShadow(
                      color: MyColor.shadowLight,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    days[index],
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? Colors.white70 : MyColor.textThird,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    dates[index],
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isSelected ? Colors.white : MyColor.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  if (isSelected) ...[
                    SizedBox(height: 4.h),
                    CircleAvatar(
                      radius: 2.r,
                      backgroundColor: Colors.white,
                    )
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- 2. Timeline Layout ---
  Widget _buildTimelineList(ThemeData theme, OnboardProvider provider) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      children: [
        _buildTimelineItem(
          theme,
          provider,
          time: "07:00 AM",
          title: "Wake Up & Water",
          subtitle: "2 Glasses of water",
          icon: Icons.water_drop_rounded,
          color: MyColor.waterCyan,
          isDone: true,
          type: "hydration",
        ),
        _buildTimelineItem(
          theme,
          provider,
          time: "08:00 AM",
          title: "Breakfast",
          subtitle: "Oatmeal & Berries",
          icon: Icons.free_breakfast_rounded,
          color: MyColor.fatOrange,
          isDone: true,
          type: "meal",
        ),
        _buildTimelineItem(
          theme,
          provider,
          time: "09:30 AM",
          title: "Morning Workout",
          subtitle: "Upper Body Power • 45 min",
          icon: Icons.fitness_center_rounded,
          color: MyColor.vibrantPurple,
          isDone: true,
          type: "workout",
        ),
        _buildTimelineItem(
          theme,
          provider,
          time: "01:00 PM",
          title: "Lunch",
          subtitle: "Grilled Chicken Salad",
          icon: Icons.lunch_dining_rounded,
          color: MyColor.mintFresh,
          isDone: false,
          isNext: true, // Special styling for next item
          type: "meal",
        ),
        _buildTimelineItem(
          theme,
          provider,
          time: "04:00 PM",
          title: "Snack",
          subtitle: "Greek Yogurt",
          icon: Icons.restaurant_rounded,
          color: MyColor.energyOrange,
          isDone: false,
          type: "meal",
        ),
         _buildTimelineItem(
          theme,
          provider,
          time: "06:00 PM",
          title: "Evening Yoga",
          subtitle: "Stretching & Relaxing • 20 min",
          icon: Icons.self_improvement_rounded,
          color: MyColor.vibrantPurple,
          isDone: false,
          type: "workout",
        ),
        SizedBox(height: 80.h), // Space for FAB
      ],
    );
  }

  Widget _buildTimelineItem(
    ThemeData theme,
    OnboardProvider provider, {
    required String time,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isDone,
    required String type,
    bool isNext = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Column
          SizedBox(
            width: 60.w,
            child: Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: Text(
                time,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isNext ? MyColor.textColor : MyColor.textThird,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          // Timeline Line & Dot
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 24.h),
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDone 
                      ? color 
                      : isNext ? color : MyColor.inActiveColor, 
                    width: 2.w
                  ),
                  color: isDone ? color : Colors.white,
                ),
                child: isDone
                    ? Icon(Icons.check, size: 8.w, color: Colors.white)
                    : null,
              ),
              Expanded(
                child: Container(
                  width: 2.w,
                  color: MyColor.dividerColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
          SizedBox(width: 15.w),
          // Content Card
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(20.r),
                // Add a border if it's the next item to highlight urgency
                border: isNext 
                  ? Border.all(color: color.withOpacity(0.5), width: 1.5) 
                  : null,
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
                  // Icon Box
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: type == "workout"
                          // Workouts get gradient background
                          ? null
                          : color.withOpacity(0.1),
                      gradient: type == "workout"
                          ? LinearGradient(colors: provider.activeGradient)
                          : null,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      icon,
                      color: type == "workout" ? Colors.white : color,
                      size: 22.w,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            decoration: isDone ? TextDecoration.lineThrough : null,
                            color: isDone ? MyColor.textThird : MyColor.textColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            decoration: isDone ? TextDecoration.lineThrough : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Checkbox/Status Action
                  if (!isDone)
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: MyColor.inActiveColor),
                      ),
                      child: Icon(Icons.chevron_right, size: 16.w, color: MyColor.textThird),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
