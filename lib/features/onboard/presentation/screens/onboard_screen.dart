import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard1_welcome.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard2_gender.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard3_plan.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard4_target.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard5_height.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard6_weight.dart';
import 'package:fitness_app_premium/features/onboard/presentation/widgets/onboard7_target_weight.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});
  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _controller = PageController();
  final _selectedGender = ValueNotifier<int>(0);
  final _selectedPlan = ValueNotifier<int>(0);
  final _selectedTarget = ValueNotifier<int>(0);
  final _selectedHeight = ValueNotifier<double>(0);
  final _selectedWeight = ValueNotifier<double>(0);
  final _selectedTargetWeight = ValueNotifier<double>(0);
  final _pages = [];
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pages.add(Onboard1Welcome(onStart: _onPageChangeForward));
    _pages.add(Onboard2Gender(selectedGender: _selectedGender));
    _pages.add(Onboard3Plan(selectedPlan: _selectedPlan));
    _pages.add(Onboard4Target(selectedTarget: _selectedTarget));
    _pages.add(Onboard5Height(selectedHeight: _selectedHeight));
    _pages.add(Onboard6Weight(
        selectedWeight: _selectedWeight, selectedHeight: _selectedHeight));
    _pages.add(Onboard7TargetWeight(
      selectedTargetWeight: _selectedTargetWeight,
      selectedWeight: _selectedWeight,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // progressBar & backButton
            if (_selectedPage != 0) _getProgressBarAndBackButton,
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
            // progress bar & next button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_pages.length - 1 == _selectedPage) {
                    Logger().e("last index");
                    return;
                  }
                  _onPageChangeForward(true);
                },
                child: Text(_selectedPage == 0 ? "Start" : "Next"),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _onPageChangeForward(bool isForward) {
    _selectedPage = isForward ? _selectedPage + 1 : _selectedPage - 1;
    setState(() {});
    _controller.animateToPage(_selectedPage,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  Widget get _getProgressBarAndBackButton {
    return Row(
      children: [
        // backButton
        // for first page we don't need backBUtton
        _selectedPage == 1
            ? SizedBox()
            : IconButton(
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
