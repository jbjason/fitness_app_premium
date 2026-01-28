import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
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

  List<Color> get activeGradient {
    return selectedGender == 1 ? MyColor.fitnessGradient : MyColor.coolGradient;
  }

  ///
  ///
  final String mainGoal = 'Butt Lift & Tone';
  final String planLevel = 'Intermediate';
  final double currentWeight = 70.5;
  final double targetWeight = 58.0;
  final double height = 165.0; // cm

  double get bmi => currentWeight / ((height / 100) * (height / 100));

  // Progress logic (0.0 to 1.0)
  double get progressPercentage {
    double totalLossNeeded = currentWeight - targetWeight;
    double totalJourney = totalLossNeeded + 5; // Mock starting point
    return (5 / totalJourney).clamp(0.0, 1.0);
  }

  List<Map<String, String>> get getGoals {
    ///   Male = 0 Female = 1
    return selectedGender == 1
        ? [
            {
              'title': 'Lose Weight & Keep Fit',
              'subtitle': "💪 Slim & fit ahead!",
              'description':
                  'Get ready to see a healthier, lighter you. Follow our tailored plan to conquer your fitness goal!',
              'image': MyImage.loseWeightImg
            },
            {
              'title': 'Butt Lift & Tone',
              'subtitle': "🥰 Bubble butt awaits!",
              'description':
                  'Your journey to lifted butt starts now!\nLet\'s shape your glutes into perfect ones!',
              'image': MyImage.buttLiftImg
            },
            {
              'title': 'Lose Belly Fat',
              'subtitle': "👋 Say bye to belly fat!",
              'description':
                  'Shed your stubborn belly fat and get a slimmer waistline, and we\'re here to support you!',
              'image': MyImage.bellyFatImg
            },
            {
              'title': 'Build Muscles & Strength',
              'subtitle': "💪 Muscle up, confidence up!",
              'description':
                  'Let\'s craft your ideal physique with our superb plan, one muscle at a time.',
              'image': MyImage.buildMuscleImg
            },
          ]
        : [
            {
              'title': 'Lose Weight & Get Lean',
              'subtitle': '🔥 Burn fat, stay sharp!',
              'description':
                  'Drop excess fat, boost your energy, and feel lighter every day with a plan built for men.',
              'image': MyImage.loseWeightMaleImg,
            },
            {
              'title': 'Build Muscle & Strength',
              'subtitle': '💪 Stronger every rep!',
              'description':
                  'Gain solid muscle and real strength with structured workouts designed for maximum results.',
              'image': MyImage.buildMuscleMaleImg,
            },
            {
              'title': 'Lose Belly Fat',
              'subtitle': '🚫 Crush the dad belly!',
              'description':
                  'Target stubborn belly fat and reveal a stronger, tighter core with focused routines.',
              'image': MyImage.loseBellyFatMaleImg,
            },
            {
              'title': 'Get Athletic & Fit',
              'subtitle': '⚡ Move better, feel faster!',
              'description':
                  'Improve endurance, agility, and overall fitness to perform better in daily life and sports.',
              'image': MyImage.athleticMaleImg,
            },
          ];
  }
}
