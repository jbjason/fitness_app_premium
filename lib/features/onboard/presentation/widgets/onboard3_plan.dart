import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboard3Plan extends StatefulWidget {
  const Onboard3Plan({super.key});
  @override
  State<Onboard3Plan> createState() => _Onboard3PlanState();
}

class _Onboard3PlanState extends State<Onboard3Plan> {
  int _selectedPlan = 0;

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
        _buildPlanOption(0, 'Beginner', '5-10 min a day'),
        _buildPlanOption(1, 'Intermediate', '10-20 min a day'),
        _buildPlanOption(2, 'Advanced', '15-30 min a day'),
      ],
    );
  }

  // Plan Card Builder
  Widget _buildPlanOption(int index, String plan, String duration) {
    return GestureDetector(
      onTap: () {
        setState(() => _selectedPlan = index);
        final data = Provider.of<OnboardProvider>(context, listen: false);
        data.setPlan(index);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _selectedPlan == index ? MyColor.accentColor : Colors.white,
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
              backgroundColor: _selectedPlan == index
                  ? MyColor.accentColor
                  : Colors.transparent,
              child: _selectedPlan == index
                  ? Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
