import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Onboard5Height extends StatefulWidget {
  const Onboard5Height({super.key});
  @override
  State<Onboard5Height> createState() => _Onboard5HeightState();
}

class _Onboard5HeightState extends State<Onboard5Height> {
  double _pointerValue = 165; // ~5ft 5in default start
  final double _minimumLevel = 120; // cm
  final double _maximumLevel = 220; // cm

  @override
  void initState() {
    super.initState();
    // Initialize provider with default value after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _updateHeight(_pointerValue);
    });
  }

  void _updateHeight(double cmValue) {
    setState(() {
      _pointerValue = cmValue;
    });

    // Logic: Store height as feet.inches (e.g., 5.06 for 5'6")
    double inches = cmValue / 2.54;
    int feet = inches ~/ 12;
    int remainingInches = (inches % 12).round();

    if (context.mounted) {
      final data = Provider.of<OnboardProvider>(context, listen: false);
      data.setHeight(feet + (remainingInches / 100.0));
    }
  }

  String _getFormattedHeight(double cmValue) {
    double inches = cmValue / 2.54;
    int feet = inches ~/ 12;
    int remainingInches = (inches % 12).round();
    return "$feet' $remainingInches\"";
  }

  List<LinearAxisLabel> _generateLabels() {
    return [
      const LinearAxisLabel(text: '4ft', value: 121.92),
      const LinearAxisLabel(text: '5ft', value: 152.4),
      const LinearAxisLabel(text: '6ft', value: 182.88),
      const LinearAxisLabel(text: '7ft', value: 213.36),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          "What's Your Height?",
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: MyColor.textColor,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),

        // Subtitle
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "This helps us calculate your BMI and\npersonalize your plan.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 20.h),

        // Gauge Area
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Silhouette / Image Layer
              Positioned(
                left: -80.w,
                right: 80.w,
                top: 0.h,
                bottom: 0,
                child: Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    MyImage.femaleModelImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Interactive Gauge Layer
              // We position the container to the right, but make it wide enough (280.w)
              // to contain the horizontal pointer line without overflowing.
              // Shifting right by -130.w essentially aligns the gauge axis near the right screen edge.
              Positioned(
                top: 20.h,
                bottom: 20.h,
                right: -130.w,
                width: 280.w,
                child: SfLinearGauge(
                  orientation: LinearGaugeOrientation.vertical,
                  minimum: _minimumLevel,
                  maximum: _maximumLevel,
                  interval: 30.48,
                  minorTicksPerInterval: 5,
                  tickPosition: LinearElementPosition.inside,
                  labelPosition: LinearLabelPosition.inside,
                  onGenerateLabels: _generateLabels,
                  axisTrackStyle: LinearAxisTrackStyle(
                    thickness: 4.w,
                    color: Colors.grey[200],
                    edgeStyle: LinearEdgeStyle.bothCurve,
                  ),
                  majorTickStyle: LinearTickStyle(
                    length: 15.w,
                    thickness: 2,
                    color: Colors.grey[400],
                  ),
                  minorTickStyle: LinearTickStyle(
                    length: 8.w,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                  axisLabelStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                  markerPointers: [
                    // The draggable line that goes across the image (Left of axis)
                    LinearShapePointer(
                      value: _pointerValue,
                      onChanged: (dynamic value) =>
                          _updateHeight(value as double),
                      shapeType: LinearShapePointerType.rectangle,
                      color: MyColor.accentColor,
                      height: 2.h,
                      width: 220.w,
                      position: LinearElementPosition.inside,
                      offset: 0,
                    ),

                    // The knob on the axis
                    LinearShapePointer(
                      value: _pointerValue,
                      enableAnimation: false,
                      onChanged: (dynamic value) =>
                          _updateHeight(value as double),
                      shapeType: LinearShapePointerType.circle,
                      color: MyColor.accentColor,
                      height: 16.w,
                      width: 16.w,
                      position: LinearElementPosition.cross,
                    ),

                    // The Text Bubble (Floating near the line)
                    LinearWidgetPointer(
                      value: _pointerValue,
                      enableAnimation: false,
                      onChanged: (dynamic value) =>
                          _updateHeight(value as double),
                      position: LinearElementPosition.inside,
                      offset: 40.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: MyColor.accentColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r),
                            bottomLeft: Radius.circular(0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MyColor.accentColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Text(
                          _getFormattedHeight(_pointerValue),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
