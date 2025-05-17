import 'package:flutter/material.dart';

class OnboardProvider with ChangeNotifier {
  int _selectedGender = 0;
  int _selectedPlan = 0;
  int _selectedTarget = 0;
  double _selectedHeight = 5.0;
  double _selectedWeight = 60.0;
  double _selectedTargetWeight = 55.0;

  int get selectedGender => _selectedGender;
  int get selectedPlan => _selectedPlan;
  int get selectedTarget => _selectedTarget;
  double get selectedHeight => _selectedHeight;
  double get selectedWeight => _selectedWeight;
  double get selectedTargetWeight => _selectedTargetWeight;

  void setGender(int i) => _selectedGender = i;
  void setPlan(int i) => _selectedPlan = i;
  void setTarget(int i) => _selectedTarget = i;
  void setHeight(double i) => _selectedHeight = i;
  void setWeight(double i) => _selectedWeight = i;
  void setTargetWeight(double i) => _selectedTargetWeight = i;
}
