import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Onboard5TargetWeight extends StatefulWidget {
  const Onboard5TargetWeight({super.key});
  @override
  State<Onboard5TargetWeight> createState() => _Onboard5TargetWeightState();
}

class _Onboard5TargetWeightState extends State<Onboard5TargetWeight> {
  double _targetWeight = 55.0;
  final double _minWeight = 30.0;
  final double _maxWeight = 150.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<OnboardProvider>(context, listen: false)
            .setTargetWeight(_targetWeight);
      }
    });
  }

  void _updateTargetWeight(double value) {
    setState(() => _targetWeight = value);
    if (mounted) {
      Provider.of<OnboardProvider>(context, listen: false)
          .setTargetWeight(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OnboardProvider>(context);
    // Use selected current weight, default to 65 if not set
    final double currentWeight =
        data.selectedWeight > 0 ? data.selectedWeight : 65.0;
    final double rangeStart =
        currentWeight < _targetWeight ? currentWeight : _targetWeight;
    final double rangeEnd =
        currentWeight < _targetWeight ? _targetWeight : currentWeight;

    return Column(
      children: [
        // Title
        Text(
          "What's Your Target Weight?",
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
            "Let's set a realistic goal to achieve\nyour dream body.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 30.h),

        // Big Target Weight Display
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              _targetWeight.toStringAsFixed(1),
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

        // Gauge with Dual Pointers (Current vs Target)
        SizedBox(
          height: 100.h,
          child: SfLinearGauge(
            minimum: _minWeight,
            maximum: _maxWeight,
            interval: 10,
            showLabels: true,
            showTicks: true,
            minorTicksPerInterval: 4,
            orientation: LinearGaugeOrientation.horizontal,

            // Styles
            axisTrackStyle: LinearAxisTrackStyle(
              color: Colors.grey[200],
              thickness: 2.h,
              edgeStyle: LinearEdgeStyle.bothCurve,
            ),
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
            axisLabelStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),

            // Range connecting Current to Target to visualize progress
            ranges: [
              LinearGaugeRange(
                startValue: rangeStart,
                endValue: rangeEnd,
                color: MyColor.accentColor.withOpacity(0.3),
                startWidth: 6.h,
                endWidth: 6.h,
                position: LinearElementPosition.cross,
              )
            ],

            markerPointers: [
              // 1. Static marker for CURRENT weight
              LinearWidgetPointer(
                value: currentWeight,
                position: LinearElementPosition.cross,
                offset: -40,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Current",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_drop_down,
                        size: 24.sp, color: Colors.grey[400]),
                  ],
                ),
              ),

              // 2. Interactive TARGET Pointer (Circle)
              LinearShapePointer(
                value: _targetWeight,
                enableAnimation: false,
                onChanged: (value) => _updateTargetWeight(value),
                shapeType: LinearShapePointerType.circle,
                color: MyColor.accentColor,
                height: 28.w,
                width: 28.w,
                position: LinearElementPosition.cross,
                dragBehavior: LinearMarkerDragBehavior.constrained,
                elevation: 5,
              ),

              // 3. Interactive TARGET Pointer (Draggable Icon Wrapper)
              LinearWidgetPointer(
                value: _targetWeight,
                enableAnimation: false,
                onChanged: (value) => _updateTargetWeight(value),
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

        SizedBox(height: 10.h),

        // Analysis Card
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 20.h),
            child: _buildAnalysisCard(currentWeight),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisCard(double currentWeight) {
    bool isLoss = _targetWeight < currentWeight;
    double diff = (_targetWeight - currentWeight).abs();
    double percent = currentWeight > 0 ? (diff / currentWeight) * 100 : 0;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: MyColor.accentColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.thumb_up_rounded,
                    color: MyColor.accentColor, size: 20.sp),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  "Reasonable Goal!",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColor.textColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: 15.sp, color: Colors.grey[800], height: 1.5),
                children: [
                  const TextSpan(text: "You will "),
                  TextSpan(
                    text:
                        "${isLoss ? 'lose' : 'gain'} ${percent.toStringAsFixed(1)}%",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColor.accentColor),
                  ),
                  const TextSpan(text: " of your body weight."),
                ]),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: MyColor.bodyHintBoxColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: MyColor.bodyHintBoxColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expected Benefits:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.grey[800]),
                ),
                SizedBox(height: 10.h),
                _buildBenefitItem("Lower blood pressure"),
                SizedBox(height: 8.h),
                _buildBenefitItem("Reduce risk of type 2 diabetes"),
                SizedBox(height: 8.h),
                _buildBenefitItem("Improve heart health"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Row(
      children: [
        Icon(Icons.check_circle_outline, size: 16.sp, color: Colors.green),
        SizedBox(width: 8.w),
        Text(text, style: TextStyle(fontSize: 13.sp, color: Colors.grey[700])),
      ],
    );
  }
}
