import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Onboard7TargetWeight extends StatefulWidget {
  const Onboard7TargetWeight({super.key});
  @override
  State<Onboard7TargetWeight> createState() => _Onboard7TargetWeightState();
}

class _Onboard7TargetWeightState extends State<Onboard7TargetWeight> {
  double _pointerValue = 55.0;
  final double _minimumWeight = 20.0;
  final double _maximumWeight = 180.0;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OnboardProvider>(context, listen: false);
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
            Text("${data.selectedWeight.toStringAsFixed(1)} kg",
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
                data.setTargetWeight(_pointerValue);
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
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MyColor.bodyHintBoxColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "👌 REASONABLE GOAL!",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "You will $_getLoasingWeightPercent of body weight\n",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                  "Moderate weight loss can alse make a big difference:\n\n- Lower blood pressure\n\n- Reduce the risk of type 2 diabetes"),
            ],
          ),
        )
      ],
    );
  }

  String get _getLoasingWeightPercent {
    final data = Provider.of<OnboardProvider>(context, listen: false);
    double percent = 0.0;
    if (data.selectedTargetWeight < data.selectedWeight) {
      percent = 100 - ((data.selectedTargetWeight * 100) / data.selectedWeight);

      return "lose ${percent.toStringAsFixed(1)}%";
    } else {
      percent = 100 - ((data.selectedWeight * 100) / data.selectedTargetWeight);

      return "gain ${percent.toStringAsFixed(1)}%";
    }
  }
}
