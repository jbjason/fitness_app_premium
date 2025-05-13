import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Onboard7TargetWeight extends StatefulWidget {
  const Onboard7TargetWeight(
      {super.key,
      required this.selectedWeight,
      required this.selectedTargetWeight});
  final ValueNotifier<double> selectedWeight;
  final ValueNotifier<double> selectedTargetWeight;
  @override
  State<Onboard7TargetWeight> createState() => _Onboard7TargetWeightState();
}

class _Onboard7TargetWeightState extends State<Onboard7TargetWeight> {
  double _pointerValue = 60.0;
  final double _minimumWeight = 20.0;
  final double _maximumWeight = 180.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "What's your target weight?",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text("${_pointerValue.toStringAsFixed(1)} kg",
                textAlign: TextAlign.center),
            Text("${widget.selectedTargetWeight.value.toStringAsFixed(1)} kg",
                textAlign: TextAlign.center),
          ],
        ),
        // Syncfusion Gauge
        SfLinearGauge(
          minimum: _minimumWeight,
          maximum: _maximumWeight,
          interval: 40,
          showLabels: true,
          showAxisTrack: true,
          orientation: LinearGaugeOrientation.horizontal,
          axisTrackStyle: const LinearAxisTrackStyle(
            color: Color(0xFFE0E0E0),
            thickness: 15,
          ),
          ranges: <LinearGaugeRange>[
            LinearGaugeRange(
              startValue: _minimumWeight,
              endValue: _pointerValue,
              color: MyColor.accentColor, // Active track color
              startWidth: 15,
              endWidth: 15,
              position: LinearElementPosition.cross,
            )
          ],
          markerPointers: <LinearMarkerPointer>[
            // Main Pointer
            LinearShapePointer(
              value: _pointerValue,
              enableAnimation: true,
              shapeType: LinearShapePointerType.triangle,
              color: MyColor.primaryColor,
              height: 100,
              width: 10,
              dragBehavior: LinearMarkerDragBehavior.constrained,
              onChanged: (double value) {
                setState(() => _pointerValue = value);
                widget.selectedTargetWeight.value = _pointerValue;
              },
            ),
            // Display Weight
            LinearWidgetPointer(
              value: _pointerValue,
              child: CircleAvatar(
                radius: 20,
                child: Center(
                  child: Text(
                    _pointerValue.toStringAsFixed(1),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("👌 REASONABLE GOAL!"),
              const SizedBox(height: 10),
              Text(
                  "You will lose $_getLoasingWeightPercent of body weight"),
              Text(
                  "Moderate weight loss can alse make a big difference:\n- Lower blood pressure\n- Reduce the risk of type 2 diabetes"),
            ],
          ),
        )
      ],
    );
  }

  String get _getLoasingWeightPercent {
    double percent = 0.0;
    if (widget.selectedTargetWeight.value < widget.selectedWeight.value) {
      percent = (widget.selectedTargetWeight.value * 100) /
          widget.selectedWeight.value;
    } else {
      percent = (widget.selectedWeight.value * 100) /
          widget.selectedTargetWeight.value;
    }
    return "${percent.toStringAsFixed(1)}%";
  }
}
