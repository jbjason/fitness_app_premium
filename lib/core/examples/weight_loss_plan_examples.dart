import 'package:fitness_app_premium/core/models/weight_loss_plan.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Example usage of Weight Loss Plans in your app
class WeightLossPlanExamples {
  
  /// Example 1: Get current user's plan
  static void getCurrentPlan(BuildContext context) {
    final provider = context.read<OnboardProvider>();
    
    // Get the current plan based on user's selection
    final plan = provider.currentWeightLossPlan;
    
    print('Plan Level: ${plan.levelName}');
    print('Weekly Weight Loss: ${plan.weeklyWeightLoss} kg');
    print('Daily Calorie Deficit: ${plan.dailyCalorieDeficit} kcal');
    
    // Access drink plan
    print('\nDrink Plan:');
    print('Water: ${plan.drinkPlan.waterLiters} L');
    print('Green Tea: ${plan.drinkPlan.greenTea}');
    
    // Access meal plan
    print('\nMeal Plan:');
    print('Breakfast: ${plan.mealPlan.breakfast}');
    print('Lunch: ${plan.mealPlan.lunch}');
    print('Dinner: ${plan.mealPlan.dinner}');
    
    // Access exercise plan
    print('\nExercise Plan:');
    print('Duration: ${plan.exercisePlan.duration}');
    for (var activity in plan.exercisePlan.activities) {
      print('- $activity');
    }
    
    // Access lifestyle plan
    print('\nLifestyle:');
    print('Sleep: ${plan.lifestylePlan.sleepHours} hours');
    print('Steps: ${plan.lifestylePlan.dailySteps}');
  }
  
  /// Example 2: Calculate weeks to reach target
  static void calculateProgress(BuildContext context) {
    final provider = context.read<OnboardProvider>();
    
    final currentWeight = provider.selectedWeight;
    final targetWeight = provider.selectedTargetWeight;
    final weeklyLossRate = provider.currentWeightLossPlan.weeklyWeightLoss;
    
    final weeks = WeightLossPlan.calculateWeeksToTarget(
      currentWeight,
      targetWeight,
      weeklyLossRate,
    );
    
    print('Current Weight: $currentWeight kg');
    print('Target Weight: $targetWeight kg');
    print('Weeks to Target: $weeks weeks');
    print('Expected completion: ${DateTime.now().add(Duration(days: weeks * 7))}');
  }
  
  /// Example 3: Generate progress chart data
  static void generateProgressChart(BuildContext context) {
    final provider = context.read<OnboardProvider>();
    
    final progressList = WeightLossProgress.generateProgressChart(
      currentWeight: provider.selectedWeight,
      targetWeight: provider.selectedTargetWeight,
      weeklyLossRate: provider.currentWeightLossPlan.weeklyWeightLoss,
    );
    
    print('Progress Chart:');
    for (var progress in progressList) {
      print('Week ${progress.weekNumber}: ${progress.expectedWeightLoss.toStringAsFixed(2)} kg lost');
    }
  }
  
  /// Example 4: Get all three plans for comparison
  static void compareAllPlans() {
    print('=== BEGINNER PLAN ===');
    _printPlan(WeightLossPlan.beginnerPlan);
    
    print('\n=== INTERMEDIATE PLAN ===');
    _printPlan(WeightLossPlan.intermediatePlan);
    
    print('\n=== ADVANCED PLAN ===');
    _printPlan(WeightLossPlan.advancedPlan);
  }
  
  static void _printPlan(WeightLossPlan plan) {
    print('Weekly Loss: ${plan.weeklyWeightLoss} kg');
    print('Calorie Deficit: ${plan.dailyCalorieDeficit} kcal/day');
    print('Water: ${plan.drinkPlan.waterLiters} L');
    print('Exercise: ${plan.exercisePlan.duration}');
    print('Steps: ${plan.lifestylePlan.dailySteps}');
  }
  
  /// Example 5: Check if user is on track (mock implementation)
  static bool isUserOnTrack({
    required double currentWeight,
    required double startingWeight,
    required int weeksElapsed,
    required double expectedWeeklyLoss,
  }) {
    final expectedLoss = weeksElapsed * expectedWeeklyLoss;
    final actualLoss = startingWeight - currentWeight;
    
    // Within 10% tolerance
    final lowerBound = expectedLoss * 0.9;
    final upperBound = expectedLoss * 1.1;
    
    return actualLoss >= lowerBound && actualLoss <= upperBound;
  }
  
  /// Example 6: Adjust plan based on goal (future enhancement)
  static WeightLossPlan adjustPlanForGoal({
    required WeightLossPlan basePlan,
    required String goal,
  }) {
    // This is a placeholder showing how you might customize plans
    // based on different fitness goals in the future
    
    switch (goal.toLowerCase()) {
      case 'build muscle & strength':
        // Would increase protein, adjust calories, focus on strength
        return basePlan; // TODO: Implement custom adjustments
      
      case 'lose belly fat':
        // Would emphasize core workouts, reduce carbs
        return basePlan; // TODO: Implement custom adjustments
      
      case 'get athletic & fit':
        // Would balance cardio and strength
        return basePlan; // TODO: Implement custom adjustments
      
      default:
        return basePlan;
    }
  }
  
  /// Example 7: Calculate daily calorie target
  static double calculateDailyCalories({
    required double weight, // kg
    required double height, // cm
    required int age,
    required String gender, // 'male' or 'female'
    required String activityLevel, // 'sedentary', 'moderate', 'active'
    required double calorieDeficit,
  }) {
    // Using Mifflin-St Jeor Equation
    double bmr;
    
    if (gender.toLowerCase() == 'male') {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
    
    // Apply activity multiplier
    double activityMultiplier;
    switch (activityLevel.toLowerCase()) {
      case 'sedentary':
        activityMultiplier = 1.2;
        break;
      case 'moderate':
        activityMultiplier = 1.55;
        break;
      case 'active':
        activityMultiplier = 1.725;
        break;
      default:
        activityMultiplier = 1.375;
    }
    
    final tdee = bmr * activityMultiplier;
    final targetCalories = tdee - calorieDeficit;
    
    return targetCalories;
  }
}

/// Example Widget showing how to display plan info
class WeightLossPlanInfoWidget extends StatelessWidget {
  const WeightLossPlanInfoWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardProvider>();
    final plan = provider.currentWeightLossPlan;
    
    return Column(
      children: [
        Text('Current Plan: ${plan.levelEmoji} ${plan.levelName}'),
        Text('Weekly Loss: ${plan.weeklyWeightLoss} kg'),
        Text('Calorie Deficit: ${plan.dailyCalorieDeficit} kcal'),
        
        const SizedBox(height: 20),
        
        // Show weeks to target
        Builder(
          builder: (context) {
            final weeks = WeightLossPlan.calculateWeeksToTarget(
              provider.selectedWeight,
              provider.selectedTargetWeight,
              plan.weeklyWeightLoss,
            );
            
            return Text('Target in $weeks weeks');
          },
        ),
      ],
    );
  }
}
