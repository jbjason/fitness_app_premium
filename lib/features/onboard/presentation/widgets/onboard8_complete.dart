import 'package:fitness_app_premium/config/extension/media_query_extension.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Onboard8Complete extends StatefulWidget {
  const Onboard8Complete({super.key});
  @override
  State<Onboard8Complete> createState() => _Onboard8CompleteState();
}

class _Onboard8CompleteState extends State<Onboard8Complete>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..forward().then((_) {
          _controller.stop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
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
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(MyImage.trainerImg),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Generating your daily schedule...",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Spacer(),
                SizedBox(
                  width: context.screenWidth * .6,
                  height: context.screenWidth * .6,
                  child: CustomPaint(
                    painter: CirclePainter(_controller),
                    child: Center(
                      child: Text(
                        "${(_controller.value * 100).toInt()}%",
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                AnimatedOpacity(
                  opacity: 1 - (_controller.value).clamp(0, .8),
                  duration: const Duration(milliseconds: 300),
                  child: ListTile(
                    leading: Icon(Icons.check, color: Colors.green),
                    title: Text(
                      'Generating the schedule for Intermediate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _controller.value >= 1.0
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: 1 * _controller.value,
                  duration: const Duration(milliseconds: 500),
                  child: ListTile(
                    leading: Icon(Icons.check, color: Colors.green),
                    title: Text(
                      'Your plan is ready!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Animation<double> animation;
  CirclePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 16.0;
    final rect = Offset.zero & size;
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final completePaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, -pi / 2, 2 * pi, false, paint);
    canvas.drawArc(
        rect, -pi / 2, 2 * pi * animation.value, false, completePaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.animation.value != animation.value;
  }
}
