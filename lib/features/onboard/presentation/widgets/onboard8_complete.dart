import 'dart:math';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/home/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboard8Complete extends StatefulWidget {
  const Onboard8Complete({super.key});
  @override
  State<Onboard8Complete> createState() => _Onboard8CompleteState();
}

class _Onboard8CompleteState extends State<Onboard8Complete>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<String> _steps = [
    "Analyzing your BMI & body type...",
    "Calculating daily calorie needs...",
    "Creating personalized workout plan...",
    "Finalizing your schedule...",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (mounted) {
      _controller.forward().then((value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Home()),
                (route) => false);
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          "We Are Almost There!",
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: MyColor.textColor,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Text(
          "AI is generating your personalized\nfitness plan.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),

        SizedBox(height: 40.h),
        // Circular Progress
        Expanded(
          flex: 2,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Ring
                  SizedBox(
                    height: 220.w,
                    width: 220.w,
                    child: CustomPaint(
                      painter: _ProgressRingPainter(
                        progress: _animation.value,
                        trackColor: Colors.grey[200]!,
                        progressColor: MyColor.accentColor,
                      ),
                    ),
                  ),

                  // Text Content
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${(_animation.value * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w900,
                          color: MyColor.textColor,
                        ),
                      ),
                      Text(
                        "Complete",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),

        // Steps Checklist
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_steps.length, (index) {
                    double startPercent = index / _steps.length;
                    double endPercent = (index + 1) / _steps.length;

                    bool isPending = _animation.value < startPercent;
                    bool isInProgress = _animation.value >= startPercent &&
                        _animation.value < endPercent;
                    bool isCompleted = _animation.value >= endPercent;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isPending ? 0.3 : 1.0,
                        child: Row(
                          children: [
                            // Icon
                            Container(
                              height: 24.w,
                              width: 24.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted
                                    ? Colors.green
                                    : (isInProgress
                                        ? MyColor.accentColor.withOpacity(0.1)
                                        : Colors.grey[200]),
                              ),
                              child: isCompleted
                                  ? Icon(Icons.check,
                                      color: Colors.white, size: 14.sp)
                                  : (isInProgress
                                      ? Padding(
                                          padding: EdgeInsets.all(6.w),
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: MyColor.accentColor))
                                      : null),
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              _steps[index],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: isInProgress || isCompleted
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: MyColor.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;

  _ProgressRingPainter(
      {required this.progress,
      required this.trackColor,
      required this.progressColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 20) / 2;
    final strokeWidth = 15.0.w;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        2 * pi * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
