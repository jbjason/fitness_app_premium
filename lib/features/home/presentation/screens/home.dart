import 'package:fitness_app_premium/features/home/presentation/screens/home_screen.dart';
import 'package:fitness_app_premium/features/home/presentation/widgets/home_navbar.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_screen.dart';
import 'package:fitness_app_premium/features/progress_report/presentation/screen/progress_report_screen.dart';
import 'package:fitness_app_premium/features/schedule/presentation/screen/schedule_screen.dart';
import 'package:fitness_app_premium/features/workout/presentation/screen/workout_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;
  bool _isNavBarVisible = true;
  double _lastScrollOffset = 0;

  final _pages = [
    HomeScreen(),
    ProgressReportScreen(),
    WorkoutScreen(),
    ScheduleScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: IndexedStack(index: _currentPage, children: _pages),
      ),
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        offset: _isNavBarVisible ? Offset.zero : const Offset(0, 1),
        child: HomeNavbar(
          onPageChange: _onPageChange,
          currentPage: _currentPage,
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final currentScrollOffset = notification.metrics.pixels;
      final scrollDelta = currentScrollOffset - _lastScrollOffset;

      // Only trigger if scrolled more than 5 pixels to avoid jitter
      if (scrollDelta.abs() > 5) {
        if (scrollDelta > 0 && _isNavBarVisible) {
          // Scrolling down - hide navbar
          setState(() => _isNavBarVisible = false);
        } else if (scrollDelta < 0 && !_isNavBarVisible) {
          // Scrolling up - show navbar
          setState(() => _isNavBarVisible = true);
        }
      }

      _lastScrollOffset = currentScrollOffset;
    }
    return false;
  }

  void _onPageChange(int i) => setState(() => _currentPage = i);
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}
