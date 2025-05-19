import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard2_gender.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard3_plan.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard4_target.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard5_height.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard6_weight.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard7_target_weight.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard8_complete.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});
  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _controller = PageController(keepPage: true);
  final _pages = [
    Onboard2Gender(),
    Onboard3Plan(),
    Onboard4Target(),
    Onboard5Height(),
    Onboard6Weight(),
    Onboard7TargetWeight(),
    Onboard8Complete(),
  ];
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // progressBar & backButton
            _getProgressBarAndBackButton,
            const SizedBox(height: 30),
            // pages
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: PageView.builder(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _pages.length,
                  itemBuilder: (context, i) => _pages[i],
                ),
              ),
            ),
            // next button
            if (_selectedPage != _pages.length - 1)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_pages.length - 1 == _selectedPage) return;
                    _onPageChangeForward(true);
                  },
                  child: Text("Next"),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _onPageChangeForward(bool isForward) async {
    _selectedPage = isForward ? _selectedPage + 1 : _selectedPage - 1;
    setState(() {});
    if (_selectedPage == 0) {
      await Future.delayed(Duration(milliseconds: 2500));
    }
    _controller.animateToPage(_selectedPage,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  Widget get _getProgressBarAndBackButton {
   // if (_selectedPage == _pages.length - 1) return SizedBox();
    return Row(
      children: [
        // backButton
        // for first page we don't need backBUtton
        if (_selectedPage != 0)
          IconButton(
            onPressed: () => _onPageChangeForward(false),
            icon: Icon(Icons.arrow_back_ios_new, color: MyColor.textColor),
          ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // goal & focus title
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "0${_selectedPage + 1} ",
                    style: TextStyle(
                        color: MyColor.accentColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 22),
                  ),
                  TextSpan(
                    text: "GOAL & FOCUS",
                    style: TextStyle(
                        color: MyColor.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // progress bar
            Row(
              children: List.generate(_pages.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: index == _selectedPage ? 20 : 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: index == _selectedPage
                        ? MyColor.accentColor
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
