import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "What's your current weight?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 40),
            Text(
              "${_pointerValue.toStringAsFixed(1)} kg",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
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
                thickness: 40,
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
                  height: 150,
                  width: 10,
                  dragBehavior: LinearMarkerDragBehavior.constrained,
                  onChanged: (double value) {
                    setState(() => _pointerValue = value);
                    final data =
                        Provider.of<OnboardProvider>(context, listen: false);
                    data.setWeight(value);
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
                  color: MyColor.bodyHintBoxColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your current BMI",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(_getBMI.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: MyColor.primaryColor)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                            "You only need a bit more sweat exercise to see a fitter you!"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text:"Underweight:" ),
                      TextSpan(text:" BMI < 18.5\n\n" ,style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text:"Healthy:" ),
                      TextSpan(text:" BMI 18.5 – 24.9\n\n" ,style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text:"Overweight:" ),
                      TextSpan(text:" BMI 25 – 29.9\n\n" ,style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text:"Obese:" ),
                      TextSpan(text:" BMI ≥ 30" ,style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double get _getBMI {
    final data = Provider.of<OnboardProvider>(context, listen: false);
    final heightInMeter = data.selectedHeight * .305;
    return _pointerValue / (heightInMeter * heightInMeter);
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
