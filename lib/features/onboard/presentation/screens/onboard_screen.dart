import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard1_welcome.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard2_gender.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard3_plan.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard4_target.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard5_height.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard6_weight.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});
  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _controller = PageController(initialPage: 0, keepPage: true);
  final _pages = [];
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pages.add(Onboard1Welcome(onStart: _onPageChange, index: 0));
    _pages.add(Onboard2Gender());
    _pages.add(Onboard3Plan());
    _pages.add(Onboard4Target());
    _pages.add(Onboard5Height());
    _pages.add(Onboard6Weight());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if(_selectedPage!=0) _getProgressBarAndBackButton,
            const SizedBox(height: 30),
            // pages
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: PageView.builder(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (val) => setState(() => _selectedPage = val),
                  itemCount: _pages.length,
                  itemBuilder: (context, i) => _pages[i],
                ),
              ),
            ),
            // progress bar & next button
            if (_selectedPage != 0) ...[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_pages.length - 1 == _selectedPage) {
                      Logger().e("last index");
                      return;
                    }
                    _onPageChange(_selectedPage);
                  },
                  child: const Text("Next"),
                ),
              ),
              const SizedBox(height: 10),
            ]
          ],
        ),
      ),
    );
  }

  void _onPageChange(int index) {
    _controller.animateToPage(
      index + 1,
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  Widget get _getProgressBarAndBackButton {
    return Row(
      children: [
        IconButton(
          onPressed: () => _onPageChange(_selectedPage - 2),
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
