# Weight Loss Plan Feature - Documentation

## Overview
A comprehensive weight loss plan system integrated throughout the fitness app, featuring personalized plans for Beginner, Intermediate, and Advanced levels.

## Features Implemented

### 1. **Weight Loss Plan Models** (`lib/core/models/weight_loss_plan.dart`)

#### Core Components:
- **PlanLevel Enum**: Beginner, Intermediate, Advanced
- **WeightLossPlan**: Main model containing all plan details
- **DrinkPlan**: Daily drink recommendations
- **MealPlan**: Meal structure and food suggestions
- **ExercisePlan**: Exercise duration and activities
- **LifestylePlan**: Sleep, steps, and habit guidelines
- **WeightLossProgress**: Progress tracking and calculations

#### Weight Loss Formulas:

| Plan Level    | Weekly Weight Loss | Daily Calorie Deficit |
|---------------|-------------------|----------------------|
| Beginner      | 0.25-0.5 kg       | 500 kcal            |
| Intermediate  | 0.5-0.75 kg       | 700 kcal            |
| Advanced      | 0.75-1.0 kg       | 900-1000 kcal       |

### 2. **Drink Chart Card** (`drink_chart_card.dart`)
🥤 Displays daily hydration plan:
- Water intake (liters)
- Green tea recommendations
- Black coffee guidelines
- Optional drinks

### 3. **Meal Plan Card** (`meal_plan_card.dart`)
🥗 Shows structured meal plan:
- 🌅 Breakfast suggestions
- ☀️ Lunch options
- 🌙 Dinner recommendations
- 🍎 Healthy snacks

### 4. **Exercise Plan Card** (`exercise_plan_card.dart`)
🏋️ Displays workout schedule:
- Duration per day
- Activity types
- Level-specific exercises

**Beginner (20-30 min/day):**
- Walking 30 min
- Home workouts (bodyweight)
- Stretching / yoga

**Intermediate (40-60 min/day):**
- Cardio 20-30 min
- Strength training 3-4 days/week
- Core workouts

**Advanced (60-90 min/day):**
- HIIT cardio
- Heavy strength training
- Core & mobility
- Active rest day

### 5. **Lifestyle Plan Card** (`lifestyle_plan_card.dart`)
🧠 Habits & daily goals:
- 😴 Sleep: 7-9 hours
- 👟 Daily Steps:
  - Beginner: 6,000 steps
  - Intermediate: 8,000 steps
  - Advanced: 10,000-15,000 steps
- 🍔 Cheat Meals:
  - Beginner/Intermediate: 1 per week
  - Advanced: None
- 📊 Progress Check: Every 7 days

### 6. **Weight Loss Progress Card** (`weight_loss_progress_card.dart`)
📊 Displays:
- Current weight vs Target weight
- Weight to lose
- Weekly loss rate
- Estimated weeks to target
- Daily calorie deficit

**Formula:**
```dart
weeks = (currentWeight - targetWeight) / weeklyLossRate;
```

### 7. **Weight Loss Plan Screen** (`weight_loss_plan_screen.dart`)
Complete screen with:
- Tabbed interface (Beginner/Intermediate/Advanced)
- All cards displayed per plan level
- Scrollable view with all details
- Color-coded by level (Green/Orange/Red)

### 8. **Integration Points**

#### Home Screen
- Added Weight Loss Plan banner
- Quick access to detailed plan
- Shows current plan level
- Displays key metrics

#### Profile Screen
- New "Health & Fitness" section
- Direct navigation to Weight Loss Plan
- Subtitle showing plan description

#### OnboardProvider Updates
- Added `currentPlanLevel` getter
- Added `currentWeightLossPlan` getter
- Notifies listeners on plan changes

## Usage

### Accessing Weight Loss Plans

```dart
// Get current plan from provider
final provider = context.read<OnboardProvider>();
final plan = provider.currentWeightLossPlan;

// Access plan details
print(plan.levelName); // "Beginner", "Intermediate", or "Advanced"
print(plan.weeklyWeightLoss); // e.g., 0.625 kg
print(plan.dailyCalorieDeficit); // e.g., 700 kcal
```

### Calculating Progress

```dart
// Calculate weeks to reach target
int weeks = WeightLossPlan.calculateWeeksToTarget(
  currentWeight: 70.0,
  targetWeight: 60.0,
  weeklyLossRate: 0.625,
);
// Returns: 16 weeks
```

### Navigating to Plans

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const WeightLossPlanScreen(),
  ),
);
```

## Smart Personalization (Future Enhancement)

The system supports goal-based modifications:

### If Goal = Build Muscle & Strength
- Higher protein meals
- Slight calorie deficit or maintenance
- Strength workouts priority

### If Goal = Lose Belly Fat
- Core workouts emphasized
- Sugar & carbs reduction
- HIIT cardio included

### If Goal = Get Athletic & Fit
- Mixed cardio + strength
- Mobility & endurance training
- Balanced nutrition

## Color Coding

| Level        | Color  | Indicator |
|-------------|--------|-----------|
| Beginner    | Green  | 🟢        |
| Intermediate| Orange | 🟡        |
| Advanced    | Red    | 🔴        |

## Files Created/Modified

### New Files:
1. `/lib/core/models/weight_loss_plan.dart`
2. `/lib/features/home/presentation/widgets/drink_chart_card.dart`
3. `/lib/features/home/presentation/widgets/meal_plan_card.dart`
4. `/lib/features/home/presentation/widgets/exercise_plan_card.dart`
5. `/lib/features/home/presentation/widgets/lifestyle_plan_card.dart`
6. `/lib/features/home/presentation/widgets/weight_loss_progress_card.dart`
7. `/lib/features/home/presentation/screens/weight_loss_plan_screen.dart`

### Modified Files:
1. `/lib/features/onboard/presentation/providers/onboard_provider.dart`
2. `/lib/features/home/presentation/screens/home_screen.dart`
3. `/lib/features/profile/presentation/screens/profile_screen.dart`
4. `/lib/features/profile/presentation/widgets/profile_listitem.dart`

## Screenshots Locations

The weight loss plans are accessible from:
1. **Home Screen** - Banner with quick access
2. **Profile Screen** - Health & Fitness section
3. **Weight Loss Plan Screen** - Full detailed view with tabs

## Next Steps

To further enhance the system:

1. **Add Progress Tracking**
   - Weekly weight input
   - Chart visualization
   - Achievement badges

2. **Meal Tracking**
   - Log daily meals
   - Calorie counter
   - Macros breakdown

3. **Exercise Tracking**
   - Workout completion
   - Time tracking
   - Rest day management

4. **Notifications**
   - Meal reminders
   - Water intake reminders
   - Workout time alerts

5. **AI Personalization**
   - Adjust plan based on progress
   - Suggest modifications
   - Adaptive calorie targets

## Technical Notes

- All models are immutable for better state management
- Color coding is consistent across all components
- Responsive design using flutter_screenutil
- Provider pattern for state management
- Clean architecture separation
