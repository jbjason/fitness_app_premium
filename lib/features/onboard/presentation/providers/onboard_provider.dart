import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';

class OnboardProvider with ChangeNotifier {
  int _selectedGender = 0;
  int _selectedPlan = 0;
  double _selectedHeight = 5.0;
  double _selectedWeight = 60.0;
  double _selectedTargetWeight = 55.0;
  final List<WeightEntry> _weightHistory = [];

  int get selectedGender => _selectedGender;
  int get selectedPlan => _selectedPlan;
  double get selectedHeight => _selectedHeight;
  double get selectedWeight => _selectedWeight;
  double get selectedTargetWeight => _selectedTargetWeight;
  List<WeightEntry> get weightHistory => List.unmodifiable(_weightHistory);

  void setGender(int i) {
    _selectedGender = i;
    notifyListeners();
  }

  void setPlan(int i) {
    _selectedPlan = i;
    notifyListeners();
  }

  void setHeight(double i) {
    _selectedHeight = i;
    notifyListeners();
  }

  void setWeight(double i) {
    _selectedWeight = i;
    notifyListeners();
  }

  void setTargetWeight(double i) {
    _selectedTargetWeight = i;
    notifyListeners();
  }

  /// Record a weight entry (history collector)
  void recordWeightEntry(double weight, {DateTime? date}) {
    final entryDate = date ?? DateTime.now();
    _weightHistory.removeWhere((e) => _isSameDay(e.date, entryDate));
    _weightHistory.add(WeightEntry(date: entryDate, weight: weight));
    _weightHistory.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  /// Ensure there's at least a record for today
  void ensureTodayEntry() {
    final today = DateTime.now();
    final exists = _weightHistory.any((e) => _isSameDay(e.date, today));
    if (!exists) {
      recordWeightEntry(_selectedWeight, date: today);
    }
  }

  /// Get current plan level based on selected plan index
  PlanLevel get currentPlanLevel {
    switch (_selectedPlan) {
      case 0:
        return PlanLevel.beginner;
      case 1:
        return PlanLevel.intermediate;
      case 2:
        return PlanLevel.advanced;
      default:
        return PlanLevel.intermediate;
    }
  }

  /// Get current weight loss plan
  WeightLossPlan get currentWeightLossPlan {
    return WeightLossPlan.getPlanForLevel(currentPlanLevel);
  }

  List<Color> get activeGradient {
    return selectedGender == 1 ? MyColor.fitnessGradient : MyColor.coolGradient;
  }

  double get bmi {
    final heightCm = _getHeightCm();
    if (heightCm <= 0) return 0.0;
    final heightM = heightCm / 100;
    return _selectedWeight / (heightM * heightM);
  }

  // Progress logic (0.0 to 1.0)
  double get progressPercentage {
    final startWeight = getStartWeightForProgress();
    final totalLossNeeded = startWeight - _selectedTargetWeight;
    if (totalLossNeeded <= 0) return 0.0;
    final lost = startWeight - _selectedWeight;
    return (lost / totalLossNeeded).clamp(0.0, 1.0);
  }

  double getStartWeightForProgress() {
    if (_weightHistory.isEmpty) return _selectedWeight;
    return _weightHistory.first.weight;
  }

  List<double> getWeeklyWeights({DateTime? endDate}) {
    final end = endDate ?? DateTime.now();
    final dates = List.generate(7, (i) => end.subtract(Duration(days: 6 - i)));
    return dates.map((d) => _getWeightOnOrBefore(d)).toList();
  }

  double _getWeightOnOrBefore(DateTime date) {
    if (_weightHistory.isEmpty) return _selectedWeight;
    final eligible = _weightHistory.where((e) => !e.date.isAfter(date)).toList();
    if (eligible.isEmpty) return _selectedWeight;
    eligible.sort((a, b) => a.date.compareTo(b.date));
    return eligible.last.weight;
  }

  double _getHeightCm() {
    final feet = _selectedHeight.floor();
    final inches = ((_selectedHeight - feet) * 100).round();
    return ((feet * 12) + inches) * 2.54;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Goals removed: app now focuses on weight loss only for all users.
}

class WeightEntry {
  final DateTime date;
  final double weight;

  const WeightEntry({
    required this.date,
    required this.weight,
  });
}
