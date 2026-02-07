/// Weight Loss Plan Level Enum
enum PlanLevel {
  beginner,
  intermediate,
  advanced,
}

/// Main Weight Loss Plan Model
class WeightLossPlan {
  final PlanLevel level;
  final double weeklyWeightLoss; // kg
  final double dailyCalorieDeficit; // kcal
  final DrinkPlan drinkPlan;
  final MealPlan mealPlan;
  final ExercisePlan exercisePlan;
  final LifestylePlan lifestylePlan;

  const WeightLossPlan({
    required this.level,
    required this.weeklyWeightLoss,
    required this.dailyCalorieDeficit,
    required this.drinkPlan,
    required this.mealPlan,
    required this.exercisePlan,
    required this.lifestylePlan,
  });

  String get levelName {
    switch (level) {
      case PlanLevel.beginner:
        return 'Beginner';
      case PlanLevel.intermediate:
        return 'Intermediate';
      case PlanLevel.advanced:
        return 'Advanced';
    }
  }

  String get levelEmoji {
    switch (level) {
      case PlanLevel.beginner:
        return '🟢';
      case PlanLevel.intermediate:
        return '🟡';
      case PlanLevel.advanced:
        return '🔴';
    }
  }

  /// Calculate weeks to reach target weight
  static int calculateWeeksToTarget(
    double currentWeight,
    double targetWeight,
    double weeklyLossRate,
  ) {
    final totalWeightToLose = currentWeight - targetWeight;
    if (totalWeightToLose <= 0) return 0;
    return (totalWeightToLose / weeklyLossRate).ceil();
  }

  /// Get plan based on level
  static WeightLossPlan getPlanForLevel(PlanLevel level) {
    switch (level) {
      case PlanLevel.beginner:
        return beginnerPlan;
      case PlanLevel.intermediate:
        return intermediatePlan;
      case PlanLevel.advanced:
        return advancedPlan;
    }
  }

  /// Predefined Plans
  static const beginnerPlan = WeightLossPlan(
    level: PlanLevel.beginner,
    weeklyWeightLoss: 0.375, // 0.25-0.5 kg average
    dailyCalorieDeficit: 500,
    drinkPlan: DrinkPlan(
      waterLiters: '2-2.5',
      greenTea: '1 cup',
      blackCoffee: '1 cup',
      optional: 'Lemon water (morning)',
    ),
    mealPlan: MealPlan(
      breakfast: 'Oats / eggs / fruits',
      lunch: 'Rice or roti + chicken/fish + veggies',
      dinner: 'Light carbs + protein',
      snacks: 'Fruits / nuts / yogurt',
    ),
    exercisePlan: ExercisePlan(
      duration: '20-30 min/day',
      activities: [
        'Walking 30 min',
        'Home workouts (bodyweight)',
        'Stretching / yoga',
      ],
    ),
    lifestylePlan: LifestylePlan(
      sleepHours: '7-9',
      dailySteps: 6000,
      cheatMealsPerWeek: 1,
    ),
  );

  static const intermediatePlan = WeightLossPlan(
    level: PlanLevel.intermediate,
    weeklyWeightLoss: 0.625, // 0.5-0.75 kg average
    dailyCalorieDeficit: 700,
    drinkPlan: DrinkPlan(
      waterLiters: '2.5-3',
      greenTea: '2 cups',
      blackCoffee: '1-2 cups',
      optional: 'Apple cider vinegar water',
    ),
    mealPlan: MealPlan(
      breakfast: 'Eggs / oats / protein smoothie',
      lunch: 'Chicken/fish + vegetables + small rice/roti',
      dinner: 'Salad + protein (no heavy carbs)',
      snacks: 'Nuts / fruit / boiled eggs',
    ),
    exercisePlan: ExercisePlan(
      duration: '40-60 min/day',
      activities: [
        'Cardio 20-30 min',
        'Strength training 3-4 days/week',
        'Core workouts',
      ],
    ),
    lifestylePlan: LifestylePlan(
      sleepHours: '7-9',
      dailySteps: 8000,
      cheatMealsPerWeek: 1,
    ),
  );

  static const advancedPlan = WeightLossPlan(
    level: PlanLevel.advanced,
    weeklyWeightLoss: 0.875, // 0.75-1.0 kg average
    dailyCalorieDeficit: 950, // 900-1000 average
    drinkPlan: DrinkPlan(
      waterLiters: '3-4',
      greenTea: '2-3 cups / herbal tea',
      blackCoffee: 'Pre-workout',
      optional: 'Electrolytes (no sugar)',
    ),
    mealPlan: MealPlan(
      breakfast: 'Eggs / protein shake',
      lunch: 'Chicken/fish + veggies (low carb)',
      dinner: 'Salad + protein only',
      snacks: 'Nuts / black coffee / green tea',
    ),
    exercisePlan: ExercisePlan(
      duration: '60-90 min/day',
      activities: [
        'HIIT cardio',
        'Heavy strength training',
        'Core & mobility',
        'Active rest day',
      ],
    ),
    lifestylePlan: LifestylePlan(
      sleepHours: '7-9',
      dailySteps: 12500, // 10k-15k average
      cheatMealsPerWeek: 0,
    ),
  );
}

/// Drink Plan Model
class DrinkPlan {
  final String waterLiters;
  final String greenTea;
  final String blackCoffee;
  final String optional;

  const DrinkPlan({
    required this.waterLiters,
    required this.greenTea,
    required this.blackCoffee,
    required this.optional,
  });
}

/// Meal Plan Model
class MealPlan {
  final String breakfast;
  final String lunch;
  final String dinner;
  final String snacks;

  const MealPlan({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
  });
}

/// Exercise Plan Model
class ExercisePlan {
  final String duration;
  final List<String> activities;

  const ExercisePlan({
    required this.duration,
    required this.activities,
  });
}

/// Lifestyle Plan Model
class LifestylePlan {
  final String sleepHours;
  final int dailySteps;
  final int cheatMealsPerWeek;

  const LifestylePlan({
    required this.sleepHours,
    required this.dailySteps,
    required this.cheatMealsPerWeek,
  });
}

/// Progress Tracking Model
class WeightLossProgress {
  final int weekNumber;
  final double expectedWeightLoss; // cumulative kg
  final double actualWeightLoss; // cumulative kg (optional)
  final DateTime date;

  const WeightLossProgress({
    required this.weekNumber,
    required this.expectedWeightLoss,
    this.actualWeightLoss = 0.0,
    required this.date,
  });

  /// Generate progress chart data
  static List<WeightLossProgress> generateProgressChart({
    required double currentWeight,
    required double targetWeight,
    required double weeklyLossRate,
  }) {
    final totalWeeks = WeightLossPlan.calculateWeeksToTarget(
      currentWeight,
      targetWeight,
      weeklyLossRate,
    );

    final progressList = <WeightLossProgress>[];
    final startDate = DateTime.now();

    for (int week = 1; week <= totalWeeks; week++) {
      progressList.add(WeightLossProgress(
        weekNumber: week,
        expectedWeightLoss: week * weeklyLossRate,
        date: startDate.add(Duration(days: week * 7)),
      ));
    }

    return progressList;
  }
}
