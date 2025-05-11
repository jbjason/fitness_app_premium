import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';

class Onboard3Plan extends StatefulWidget {
  const Onboard3Plan({super.key});
  @override
  State<Onboard3Plan> createState() => _Onboard3PlanState();
}

class _Onboard3PlanState extends State<Onboard3Plan> {
  String? selectedPlan;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Choose your plan',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        // Info Card
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.track_changes, color: Colors.redAccent),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Your coach will design a weight loss plan for you to suit you best',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        // Plan Options
        _buildPlanOption('Beginner', '5-10 min a day'),
        _buildPlanOption('Intermediate', '10-20 min a day'),
        _buildPlanOption('Advanced', '15-30 min a day'),
      ],
    );
  }

  // Plan Card Builder
  Widget _buildPlanOption(String plan, String duration) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedPlan = plan);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedPlan == plan ? MyColor.accentColor : Colors.white,
            width: 2,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.layers, color: Colors.black),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plan,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(duration, style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            CircleAvatar(
              radius: 10,
              backgroundColor:
                  selectedPlan == plan ? MyColor.accentColor  : Colors.transparent,
              child: selectedPlan == plan
                  ? Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
