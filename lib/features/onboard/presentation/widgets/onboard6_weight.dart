import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Onboard6Weight extends StatefulWidget {
  const Onboard6Weight({super.key});
  @override
  State<Onboard6Weight> createState() => _Onboard6WeightState();
}

class _Onboard6WeightState extends State<Onboard6Weight> {
  double _currentWeight = 65.0; // Default start
  final double _minWeight = 30.0;
  final double _maxWeight = 150.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<OnboardProvider>(context, listen: false)
            .setWeight(_currentWeight);
      }
    });
  }

  void _updateWeight(double value) {
    setState(() => _currentWeight = value);
    if (mounted) {
      Provider.of<OnboardProvider>(context, listen: false).setWeight(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          "What's Your Current Weight?",
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
            "We use this to calculate your BMI and\ntrack your progress.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 30.h),

        // Big Weight Display
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              _currentWeight.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 60.sp,
                fontWeight: FontWeight.w900,
                color: MyColor.accentColor,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              "kg",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // Horizontal Weight Ruler
        SizedBox(
          height: 80.h,
          child: SfLinearGauge(
            minimum: _minWeight,
            maximum: _maxWeight,
            interval: 10,
            showLabels: true,
            showTicks: true,
            minorTicksPerInterval: 4,
            orientation: LinearGaugeOrientation.horizontal,
            // Track styling
            axisTrackStyle: LinearAxisTrackStyle(
              color: Colors.grey[200],
              thickness: 2.h,
              edgeStyle: LinearEdgeStyle.bothCurve,
            ),
            // Tick styling
            majorTickStyle: LinearTickStyle(
              length: 15.h,
              thickness: 2.w,
              color: Colors.grey[400],
            ),
            minorTickStyle: LinearTickStyle(
              length: 8.h,
              thickness: 1.w,
              color: Colors.grey[300],
            ),
            // Label styling
            axisLabelStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            // Interactive Marker
            markerPointers: [
              LinearShapePointer(
                value: _currentWeight,
                enableAnimation: false,
                onChanged: (value) => _updateWeight(value),
                shapeType: LinearShapePointerType.circle,
                color: MyColor.accentColor,
                height: 28.w,
                width: 28.w,
                position: LinearElementPosition.cross,
                dragBehavior: LinearMarkerDragBehavior.constrained,
                elevation: 5,
              ),
              // Little arrow pointing down to the circle - Made draggable
              LinearWidgetPointer(
                value: _currentWeight,
                enableAnimation: false,
                onChanged: (value) => _updateWeight(value),
                position: LinearElementPosition.cross,
                offset: -28,
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: MyColor.accentColor,
                    size: 30.sp,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        // BMI Dashboard Card
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 20.h),
            child: _buildBMICard(),
          ),
        ),
      ],
    );
  }

  Widget _buildBMICard() {
    double bmi = _calculateBMI();
    String category = _getBMICategory(bmi);
    Color categoryColor = _getCategoryColor(bmi);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BMI Score",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: categoryColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  bmi.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                    color: categoryColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 25.h),

          // Custom Progress Bar for BMI
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: SizedBox(
                  height: 12.h,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 18, child: Container(color: Colors.blue[300])),
                      Expanded(flex: 7, child: Container(color: Colors.green)),
                      Expanded(flex: 5, child: Container(color: Colors.orange)),
                      Expanded(
                          flex: 10, child: Container(color: Colors.redAccent)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("15",
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
                  Text("18.5",
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
                  Text("25",
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
                  Text("30",
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
                  Text("40",
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
                ],
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Motivational Text
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: MyColor.bodyHintBoxColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: MyColor.bodyHintBoxColor),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    color: Colors.grey[700], size: 20.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    _getBMIMessage(category),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[800],
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateBMI() {
    final data = Provider.of<OnboardProvider>(context, listen: false);
    double rawHeight = data.selectedHeight;

    // Safety check
    if (rawHeight <= 0) return 22.0;

    // Decode 5.11 -> 5 feet, 11 inches
    int feet = rawHeight.floor();
    int inches = ((rawHeight - feet) * 100).round();

    double totalInches = (feet * 12) + inches.toDouble();
    double heightMeters = totalInches * 0.0254;

    if (heightMeters <= 0) return 0;

    return _currentWeight / (heightMeters * heightMeters);
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Healthy";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  Color _getCategoryColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  String _getBMIMessage(String category) {
    switch (category) {
      case "Underweight":
        return "A balanced diet can help you reach a healthier weight.";
      case "Healthy":
        return "You're doing great! Keep up the healthy lifestyle.";
      case "Overweight":
        return "You're close! Regular exercise will help you hit your goal.";
      case "Obese":
        return "We're here to help you start your journey to better health.";
      default:
        return "Let's get moving!";
    }
  }
}

/*
BMI Formula:

BMI=  Weight(kg)/ height(m)square(2)
 

Underweight: BMI < 18.5

Healthy: BMI 18.5–24.9

Overweight: BMI 25–29.9

Obese: BMI ≥ 30

Limitations:

BMI doesn’t account for muscle mass (athletes may have high BMI but low fat).

Body frame size (small, medium, large) can influence ideal weight.

Alternative Measures:

Waist-to-Height Ratio (keep waist circumference < half your height).

Body Fat Percentage (healthy range: Men 10–20%, Women 18–28%).
*/
