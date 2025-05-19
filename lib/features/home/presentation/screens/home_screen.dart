import 'package:fitness_app_premium/features/auth/presentation/screens/auth_screen.dart';
import 'package:fitness_app_premium/features/home/presentation/widgets/home_navbar.dart';
import 'package:fitness_app_premium/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final _pages = [
    TestScreen(title: "Home Screen"),
    TestScreen(title: "Report Screen"),
    SizedBox(),
    TestScreen(title: "Schedule Screen"),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentPage, children: _pages),
      bottomNavigationBar: HomeNavbar(
        onPageChange: _onPageChange,
        currentPage: _currentPage,
      ),
    );
  }

  void _onPageChange(int i) {
    if (i == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AuthScreen()),
      );
    }
    setState(() => _currentPage = i);
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}
