import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
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
  int _selectedDateIndex = 0;
  final Set<int> _doneItems = {};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDateIndex = (now.weekday - DateTime.monday).clamp(0, 6);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<OnboardProvider>();
    final plan = provider.currentWeightLossPlan;
    final weekDates = _getWeekDates();
    final selectedDate = weekDates[_selectedDateIndex];
    final isToday = _isSameDay(selectedDate, DateTime.now());

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
        actions: const [],
      ),
      body: Column(
        children: [
          SizedBox(height: 15.h),
          _buildSelectedDateHeader(theme, selectedDate, isToday),
          SizedBox(height: 10.h),
          // 1. Calendar Date Selector
          _buildCalendarStrip(theme, provider, weekDates),
          SizedBox(height: 10.h),
          // 2. Timeline List
          Expanded(
            child: _buildTimelineList(theme, provider, plan),
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
  Widget _buildCalendarStrip(
    ThemeData theme,
    OnboardProvider provider,
    List<DateTime> weekDates,
  ) {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        scrollDirection: Axis.horizontal,
        itemCount: weekDates.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedDateIndex;
          final date = weekDates[index];
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
                    date.day.toString(),
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
  Widget _buildTimelineList(
    ThemeData theme,
    OnboardProvider provider,
    WeightLossPlan plan,
  ) {
    final items = _buildPlanSchedule(plan);
    final nextIndex = _doneItems.length >= items.length
        ? -1
        : items.indexWhere((item) => !_doneItems.contains(item.index));

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      children: [
        ...items.map((item) {
          final isDone = _doneItems.contains(item.index);
          final isNext = item.index == nextIndex;
          return _buildTimelineItem(
            theme,
            provider,
            time: item.time,
            title: item.title,
            subtitle: item.subtitle,
            icon: item.icon,
            color: item.color,
            isDone: isDone,
            isNext: isNext,
            type: item.type,
            onTap: () => _toggleDone(item.index),
          );
        }),
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
    VoidCallback? onTap,
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
                        : isNext
                            ? color
                            : MyColor.inActiveColor,
                    width: 2.w,
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
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20.r),
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
                              decoration:
                                  isDone ? TextDecoration.lineThrough : null,
                              color:
                                  isDone ? MyColor.textThird : MyColor.textColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            subtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 10.sp,
                              decoration:
                                  isDone ? TextDecoration.lineThrough : null,
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
                        child: Icon(Icons.chevron_right,
                            size: 16.w, color: MyColor.textThird),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleDone(int index) {
    setState(() {
      if (_doneItems.contains(index)) {
        _doneItems.remove(index);
      } else {
        _doneItems.add(index);
      }
    });
  }

  Widget _buildSelectedDateHeader(
    ThemeData theme,
    DateTime selectedDate,
    bool isToday,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatSelectedDate(selectedDate),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                isToday ? "Today" : "Selected Day",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: MyColor.textThird,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: MyColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: MyColor.dividerColor.withOpacity(0.6)),
            ),
            child: Text(
              _formatMonthYear(selectedDate),
              style: theme.textTheme.labelSmall?.copyWith(
                color: MyColor.textThird,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime> _getWeekDates() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatSelectedDate(DateTime date) {
    const weekdays = [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun",
    ];
    final dayName = weekdays[date.weekday - 1];
    return "$dayName, ${date.day}";
  }

  String _formatMonthYear(DateTime date) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return "${months[date.month - 1]} ${date.year}";
  }

  List<_ScheduleItem> _buildPlanSchedule(WeightLossPlan plan) {
    return [
      _ScheduleItem(
        index: 0,
        time: "07:00 AM",
        title: "Wake Up & Water",
        subtitle: "${plan.drinkPlan.waterLiters} L water",
        icon: Icons.water_drop_rounded,
        color: MyColor.waterCyan,
        type: "hydration",
      ),
      _ScheduleItem(
        index: 1,
        time: "08:00 AM",
        title: "Breakfast",
        subtitle: plan.mealPlan.breakfast,
        icon: Icons.free_breakfast_rounded,
        color: MyColor.fatOrange,
        type: "meal",
      ),
      _ScheduleItem(
        index: 2,
        time: "09:30 AM",
        title: "Morning Workout",
        subtitle:
            "${_getActivity(plan, 0)} • ${_formatDuration(plan.exercisePlan.duration)}",
        icon: Icons.fitness_center_rounded,
        color: MyColor.vibrantPurple,
        type: "workout",
      ),
      _ScheduleItem(
        index: 3,
        time: "01:00 PM",
        title: "Lunch",
        subtitle: plan.mealPlan.lunch,
        icon: Icons.lunch_dining_rounded,
        color: MyColor.mintFresh,
        type: "meal",
      ),
      _ScheduleItem(
        index: 4,
        time: "04:00 PM",
        title: "Snack",
        subtitle: plan.mealPlan.snacks,
        icon: Icons.restaurant_rounded,
        color: MyColor.energyOrange,
        type: "meal",
      ),
      _ScheduleItem(
        index: 5,
        time: "06:00 PM",
        title: "Evening Yoga",
        subtitle:
            "${_getActivity(plan, 1)} • ${_formatDuration(plan.exercisePlan.duration)}",
        icon: Icons.self_improvement_rounded,
        color: MyColor.vibrantPurple,
        type: "workout",
      ),
    ];
  }

  String _formatDuration(String duration) {
    return duration.replaceAll('/day', '').trim();
  }

  String _getActivity(WeightLossPlan plan, int index) {
    final activities = plan.exercisePlan.activities;
    if (activities.isEmpty) return "Workout";
    if (index >= activities.length) return activities.last;
    return activities[index];
  }
}

class _ScheduleItem {
  final int index;
  final String time;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String type;

  const _ScheduleItem({
    required this.index,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.type,
  });
}
