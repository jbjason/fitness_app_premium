import 'package:fitness_app_premium/config/extension/media_query_extension.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Onboard5Height extends StatefulWidget {
  const Onboard5Height({super.key});
  @override
  State<Onboard5Height> createState() => _Onboard5HeightState();
}

class _Onboard5HeightState extends State<Onboard5Height> {
  double _pointerValue = 152; // Start from 4ft
  final double _minimumLevel = 122; // 4ft in cm
  final double _maximumLevel = 213; // 7ft in cm

  // Converts cm to ft and in
  String _cmToFeetInches(double cmValue) {
    double inches = cmValue / 2.54;
    int feet = inches ~/ 12;
    int remainingInches = (inches % 12).round();
    // setting ft & inches as  feet.inches
    final data = Provider.of<OnboardProvider>(context, listen: false);
    data.setHeight(feet + (12 * remainingInches / 100));
    print("${feet + (12 * remainingInches / 100)}---------");
    return "${feet}ft ${remainingInches}inch";
  }

  // Generates labels in feet and inches
  List<LinearAxisLabel> _generateLabels() {
    return [
      LinearAxisLabel(text: '4ft 0in', value: 122),
      LinearAxisLabel(text: '5ft 0in', value: 152),
      LinearAxisLabel(text: '6ft 0in', value: 183),
      LinearAxisLabel(text: '7ft 0in', value: 213),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _buildHeightCalculator(context),
    );
  }

  Widget _buildHeightCalculator(BuildContext context) {
    return SfLinearGauge(
      orientation: LinearGaugeOrientation.vertical,
      minimum: _minimumLevel,
      maximum: _maximumLevel,
      tickPosition: LinearElementPosition.outside,
      labelPosition: LinearLabelPosition.outside,
      minorTicksPerInterval: 5,
      interval: 10,
      onGenerateLabels: _generateLabels,
      axisTrackStyle: const LinearAxisTrackStyle(color: Color(0xffBC5A94)),
      markerPointers: <LinearMarkerPointer>[
        LinearShapePointer(
          value: _pointerValue,
          enableAnimation: false,
          onChanged: (dynamic value) {
            setState(() => _pointerValue = value as double);
          },
          shapeType: LinearShapePointerType.rectangle,
          color: MyColor.accentColor,
          height: 2,
          width: context.screenWidth * .8 - 100,
        ),
        _buildLinearWidgetPointer(
          value: _pointerValue,
          offset: 0,
          child: SizedBox(
            width: 24,
            height: 16,
            child: Image.asset(MyImage.rectanglePointertImg),
          ),
        ),
        _buildLinearWidgetPointer(
          value: _pointerValue,
          offset: context.screenWidth * .8 - 100,
          position: LinearElementPosition.outside,
          child: Container(
            width: 60,
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                _cmToFeetInches(_pointerValue),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      ],
      ranges: <LinearGaugeRange>[
        LinearGaugeRange(
          endValue: _pointerValue,
          startWidth: context.screenWidth * .8 - 50,
          midWidth: context.screenWidth * .8 - 50,
          endWidth: context.screenWidth * .8,
          color: Colors.transparent,
          child: Image.asset(
            width: 30,
            height: 60,
            MyImage.femaleModelImg,
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }

  LinearWidgetPointer _buildLinearWidgetPointer({
    required double value,
    required Widget child,
    LinearElementPosition position = LinearElementPosition.cross,
    double offset = 0,
  }) {
    return LinearWidgetPointer(
      value: value,
      enableAnimation: false,
      onChanged: (dynamic value) {
        setState(() => _pointerValue = value as double);
      },
      offset: offset,
      position: position,
      child: child,
    );
  }
}

/// cm code
/* import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Onboard5Height extends StatefulWidget {
  const Onboard5Height({super.key});
  @override
  State<Onboard5Height> createState() => _Onboard5HeightState();
}

class _Onboard5HeightState extends State<Onboard5Height> {
  double _pointerValue = 130;
  final double _maximumLevel = 200;

  List<LinearAxisLabel> _generateLabels() {
    return [
      const LinearAxisLabel(text: '0 cm', value: 0),
      const LinearAxisLabel(text: '25 cm', value: 25),
      const LinearAxisLabel(text: '50 cm', value: 50),
      const LinearAxisLabel(text: '75 cm', value: 75),
      const LinearAxisLabel(text: '100 cm', value: 100),
      const LinearAxisLabel(text: '125 cm', value: 125),
      const LinearAxisLabel(text: '150 cm', value: 150),
      const LinearAxisLabel(text: '175 cm', value: 175),
      const LinearAxisLabel(text: '200 cm', value: 200),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _buildHeightCalculator(context),
    );
  }

  Widget _buildHeightCalculator(BuildContext context) {
    return SfLinearGauge(
      orientation: LinearGaugeOrientation.vertical,
      maximum: _maximumLevel,
      tickPosition: LinearElementPosition.outside,
      labelPosition: LinearLabelPosition.outside,
      minorTicksPerInterval: 5,
      interval: 25,
      onGenerateLabels: _generateLabels,
      axisTrackStyle: const LinearAxisTrackStyle(color: Color(0xffBC5A94)),
      markerPointers: <LinearMarkerPointer>[
        LinearShapePointer(
          value: _pointerValue,
          enableAnimation: false,
          onChanged: (dynamic value) {
            setState(() {
              _pointerValue = value as double;
            });
          },
          shapeType: LinearShapePointerType.rectangle,
          color: MyColor.accentColor,
          height: 2,
          width: context.screenWidth * .8 - 100,
        ),
        _buildLinearWidgetPointer(
          value: _pointerValue,
          offset: 0,
          child: SizedBox(
            width: 24,
            height: 16,
            child: Image.asset(MyImage.rectanglePointertImg),
          ),
        ),
        _buildLinearWidgetPointer(
          value: _pointerValue,
          offset: context.screenWidth * .8 - 100,
          position: LinearElementPosition.outside,
          child: Container(
            width: 60,
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '${_pointerValue.toStringAsFixed(0)}cm',
              ),
            ),
          ),
        ),
      ],
      ranges: <LinearGaugeRange>[
        LinearGaugeRange(
          endValue: _pointerValue,
          startWidth: context.screenWidth * .8 - 50,
          midWidth: context.screenWidth * .8 - 50,
          endWidth: context.screenWidth * .8,
          color: Colors.transparent,
          child: Image.asset(
            width: 30,
            height: 60,
            MyImage.femaleModelImg,
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }

  LinearWidgetPointer _buildLinearWidgetPointer({
    required double value,
    required Widget child,
    LinearElementPosition position = LinearElementPosition.cross,
    double offset = 0,
  }) {
    return LinearWidgetPointer(
      value: value,
      enableAnimation: false,
      onChanged: (dynamic value) {
        setState(() {
          _pointerValue = value as double;
        });
      },
      offset: offset,
      position: position,
      child: child,
    );
  }
}
*/
