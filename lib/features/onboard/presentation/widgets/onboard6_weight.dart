import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Onboard6Weight extends StatefulWidget {
  const Onboard6Weight({super.key});

  @override
  State<Onboard6Weight> createState() => _Onboard6WeightState();
}

class _Onboard6WeightState extends State<Onboard6Weight> {
  double _pointerValue = 60.0;
  final double _minimumWeight = 20.0;
  final double _maximumWeight = 180.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
