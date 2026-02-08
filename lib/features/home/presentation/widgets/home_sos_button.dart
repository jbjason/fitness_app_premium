import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSosButton extends StatelessWidget {
  const HomeSosButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: "SOS",
          pageBuilder: (ctx, a1, a2) => const SOSOverlay(),
          transitionBuilder: (ctx, a1, a2, child) {
            return ScaleTransition(scale: a1, child: child);
          },
        );
      },
      child: Container(
        height: 60.w,
        width: 60.w,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: const Icon(Icons.sos_rounded, color: Colors.white, size: 28),
      ),
    );
  }
}

class SOSOverlay extends StatefulWidget {
  const SOSOverlay({super.key});

  @override
  State<SOSOverlay> createState() => _SOSOverlayState();
}

class _SOSOverlayState extends State<SOSOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _secondsRemaining = 60;
  Timer? _timer;
  String _instruction = "Breathe In";

  @override
  void initState() {
    super.initState();
    // Breathing animation (4 seconds in, 4 seconds out)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addListener(() {
      if (_controller.value < 0.5 && _instruction != "Breathe In") {
        setState(() => _instruction = "Breathe In");
        HapticFeedback.lightImpact();
      } else if (_controller.value >= 0.5 && _instruction != "Breathe Out") {
        setState(() => _instruction = "Breathe Out");
        HapticFeedback.lightImpact();
      }
    });

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
        Navigator.of(context).pop(); // Close dialog when done
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Craving Emergency",
              style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text(
              "Hold on for $_secondsRemaining seconds.\nThe craving will pass.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16.sp),
            ),
            SizedBox(height: 50.h),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 150.w,
                    height: 150.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.5),
                          Colors.blueAccent.withOpacity(0.1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.3),
                          blurRadius: 30 * _scaleAnimation.value,
                          spreadRadius: 10,
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _instruction,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50.h),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("I'm okay now", style: TextStyle(color: Colors.white54)),
            )
          ],
        ),
      ),
    );
  }
}